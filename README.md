# godot-plugin-import-animation-tree-player


This plugin lets you import all animations in the AnimationPlayer to the AnimationTreePlayer as animation nodes.

Steps:
1) select the animation player and press the LOAD button in the ImportAnim window
2) select the AnimationTreePlayer and press the IMPORT button
3) refresh the AnimationTreePlayer selecting another node and selecting again the AnimationTreePlayer

You can optionally SAVE all the animations, present in the AnimationPlayer, as separate files (saved in res://animations)

known bugs:
once you import all the animations in the AnimationTreePlayer the nodes don't show up immediately, you have to select another node and then select again

![alt text](/ImportAnimTreePlayer.jpg)
