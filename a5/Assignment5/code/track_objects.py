"""A very simple tracking algorithm.

For more serious tracking, look-up the papers in the projects pdf.
"""

import numpy as np
import scipy.io
import scipy.misc
from PIL import Image
import os
from showboxes import *

FRAME_DIR = 'C:/Users/modulus/Dropbox/uni/content/YR3/sem1/csc420/a5/Assignment5/data/frames/'
DETECTION_DIR = 'C:/Users/modulus/Dropbox/uni/content/YR3/sem1/csc420/a5/Assignment5/data/detections/'


def compute_similarity(current_detections, next_detections,
                       current_image, next_image):
  """Compute similarity score for detections in adjacent frames.

  Args:
    current_detections: Detections in the current frame
    next_detections:    Detections in the next frame
    current_image:      PIL.Image object for the current frame
    next_image:         PIL.Image object for the next frame

  Returns:
    sim:                Similarity matrix.
  """
  num_current_detections = len(current_detections)
  num_next_detections = len(next_detections)
  sim = np.zeros((num_current_detections, num_next_detections))

  current_detection_areas = compute_area(current_detections)
  next_detection_areas = compute_area(next_detections)

  current_detection_centers = compute_center(current_detections)
  next_detection_centers = compute_center(next_detections)

  current_image = np.array(current_image)
  next_image = np.array(next_image)

  weights = [1, 1, 2]

  for detection_id in range(num_current_detections):
    # Compare boxes sizes
    current_box_area = current_detection_areas[detection_id]
    sim[detection_id] = (np.minimum(next_detection_areas, current_box_area)
                         / np.maximum(next_detection_areas, current_box_area)
                         * weights[0])

    # Penalize distance (would be good to look-up flow, but it's slow to
    # compute for images of this size.
    center_distances = (next_detection_centers
                        - current_detection_centers[detection_id])
    sim[detection_id] += np.exp(- 0.5 * np.sum(center_distances ** 2, axis=1)
                                / 5 ** 2) * weights[1]

    # Compute patch similarity
    current_patch = grab_image_patch(current_image,
                                     current_detections[detection_id])

    for next_detection_id in range(num_next_detections):
      distance = np.linalg.norm(current_detection_centers[detection_id]
                                - next_detection_centers[next_detection_id])
      if distance > 60:
        sim[detection_id, next_detection_id] = 0.
        continue

      next_patch = grab_image_patch(next_image,
                                    next_detections[next_detection_id],
                                    current_patch.shape[:2])

      sim[detection_id, next_detection_id] += (
          weights[2] * np.sum(current_patch * next_patch))
  return sim


def grab_image_patch(image, box, target_shape=None):
  """Get the image patch based on the given box.

  Args:
    image:          np.array object for input image.
    box:            Pixel coordinate for output patch.
    target_shape:   None or size-2 tuple for target patch shape. Output patch
                    will be resized to target shape if not set to None.

  Returns:
    patch:    np.array object for cropped image patch
  """
  box = np.round(box).astype(np.int32)

  # Python index starts at 0.
  box[:2] = np.maximum(1, box[:2]) - 1
  # xmax and ymax are exclusive.
  box[2] = min(box[2], image.shape[1])
  box[3] = min(box[3], image.shape[0])

  patch = image[box[1]:box[3], box[0]:box[2], :]

  if target_shape is not None:
    patch = scipy.misc.imresize(patch, target_shape)

  patch = patch.astype(np.double)
  patch /= np.linalg.norm(patch)

  return patch


def compute_area(detections):
  """Compute the area for each detection.

  Args:
    detections:   A matrix of shape N * 4, recording the pixel coordinate of
                  each detection bounding box (inclusive).

  Returns:
    area:         A vector of length N, representing the area for each input
                  bounding box.
  """
  area = (np.maximum(0, detections[:, 2] - detections[:, 0] + 1)
          * np.maximum(0, detections[:, 3] - detections[:, 1] + 1))
  return area


def compute_center(detections):
  """Compute the center for each detection.

  Args:
    detections:   A matrix of shape N * 4, recording the pixel coordinate of
                  each detection bounding box (inclusive).

  Returns:
    center:       A matrix of shape N I 2, representing the (x, y) coordinate
                  for each input bounding box center.
  """
  center = detections[:, [0, 1]] + detections[:, [2, 3]]
  center /= 2.
  return center


def load_image_and_detections(frame_id):
  """Helper function for loading image and detections.
  """
  image_path = os.path.join(FRAME_DIR, '%06d.jpg' % frame_id)
  image = Image.open(image_path)

  mat_path = os.path.join(DETECTION_DIR, '%06d_dets.mat' % frame_id)
  mat_content = scipy.io.loadmat(mat_path)
  detections = mat_content['dets']
  return image, detections

def visualize_players(tracks):
  """Visualizes the detected moving players.

  Args:
    tracks:       A 2D list consisting of tuple-lists, representing individual tracks.

  Returns:
    (none)        uses showboxes.py for visualization.
  """

  culled_tracks = [tracks[k] for k in range(len(tracks)) if len(tracks[k]) > 5]

  color = ['r', 'c', 'b', 'y', 'm', 'navy', 'turquoise', 'darkorange', 'cornflowerblue']

  valid_colors = color[0:len(culled_tracks)]

  for image_id in range(start_frame, end_frame):

    current_image, current_detections = load_image_and_detections(image_id)

    detection_indices = []
    track_colours = []

    for track in range(len(culled_tracks)):

      current_track = culled_tracks[track]
      image_detections = [current_track[det] for det in range(len(current_track)) if current_track[det][0] == image_id]
      if (len(image_detections) == 1):
        detection_indices.append(image_detections[0][1])
        track_colours.append(valid_colors[track])

    detection_coordinates = []

    for ind in detection_indices:
      detection_coordinates.append(current_detections[ind,0:4])

    savepath = 'C:/users/modulus/Dropbox/uni/content/YR3/sem1/csc420/a5/Assignment5/tracks/'+str(image_id)+'.png'

    showboxes(current_image, detection_coordinates, track_colours, savepath)


start_frame = 62
end_frame = 72

sims = []
tracks = []

for frame_id in range(start_frame, end_frame):
  current_image, current_detections = load_image_and_detections(frame_id)

  next_image, next_detections = load_image_and_detections(frame_id + 1)

  # sim has as many rows as len(current_detections) and as many columns as
  # len(next_detections).
  # sim[k, t] is the similarity between detection k in frame i, and detection
  # t in frame j.
  # sim[k, t] == 0 indicates that k and t should probably not be the same track.
  sim = compute_similarity(current_detections, next_detections,
                           current_image, next_image)

  sim_copy = sim
  # refNull = np.zeros(simCopy.shape)
  # isNull = not refNull.any()

  for i in range(sim_copy.shape[0] * sim_copy.shape[1]):

    k, t = np.unravel_index(sim_copy.argmax(), sim_copy.shape)
    if (sim_copy[k,t] == 0):
      break # no more maxes
    frame_id_tuple = (frame_id, k)
    next_id_tuple = (frame_id+1, t)
    new_track = [frame_id_tuple, next_id_tuple]

    num_tracks = len(tracks)
    added = 0

    for j in range(num_tracks):
      track_length = len(tracks[j])
      last_track_item = tracks[j][track_length-1]
      if frame_id_tuple == last_track_item:
        tracks[j].append(next_id_tuple)
        added = 1

    if added == 0:
      tracks.append(new_track)

    sim_copy[k,:] = 0
    sim_copy[:,t] = 0

visualize_players(tracks)


























