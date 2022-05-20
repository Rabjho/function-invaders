using Godot;
using System;

public class Asteroid : RigidBody2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		var animSprite = GetNode<AnimatedSprite>("AnimatedSprite");
		animSprite.Frame = (int)GD.Randi() % animSprite.Frames.GetFrameCount(animSprite.Animation);
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

}

