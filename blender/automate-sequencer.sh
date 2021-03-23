# https://blender.stackexchange.com/questions/8107/how-to-automate-blender-video-sequencer
import os

from bpy import context
scene = context.scene

path = "/my_path/to/images"
files = os.listdir(path)
files.sort()

# create the sequencer data
scene.sequence_editor_create()

seq = scene.sequence_editor.sequences.new_image(
        name="MyStrip",
        filepath=os.path.join(path, files[0]),
        channel=1, frame_start=1)

# add the rest of the images.
for f in files[1:300]:
    seq.elements.append(f)

# reverse if you want
seq.use_reverse_frames = False