using Godot;
using System;

public class Player : Area2D
{
	
	[Signal]
	public delegate void Hit();


	[Export]
	public int Speed = 400; // How fast the player will move (pixels/sec).

	public Vector2 ScreenSize; // Size of the game window.

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		ScreenSize = GetViewportRect().Size;
		Hide();
	}

 // Called every frame. 'delta' is the elapsed time since the previous frame.
 public override void _Process(float delta)
 {
	 var velocity = Vector2.Zero; // The player's movement vector.

	if (Input.IsActionPressed("move_down"))
	{
		velocity.y += 1;
	}

	if (Input.IsActionPressed("move_up"))
	{
		velocity.y -= 1;
	}

	var animatedSprite = GetNode<AnimatedSprite>("AnimatedSprite");

	if (velocity.Length() > 0)
	{
		velocity = velocity.Normalized() * Speed;
		animatedSprite.Play();
	}
	else
	{
		animatedSprite.Stop();
	}

	if (velocity.y != 0)
	{
		animatedSprite.Animation = "default";
		animatedSprite.FlipV = velocity.y > 0;
	} else {
		animatedSprite.Frame = 0;
	}



	Position += velocity * delta;
	Position = new Vector2(
		x: Mathf.Clamp(Position.x, 0, ScreenSize.x),
		y: Mathf.Clamp(Position.y, 0, ScreenSize.y)
	);

 }



private void _on_Player_body_entered(object body)
{
	Hide(); // Player disappears after being hit.
	EmitSignal(nameof(Hit));
	// Must be deferred as we can't change physics properties on a physics callback.
	GetNode<CollisionPolygon2D>("CollisionPolygon2D").SetDeferred("disabled", true);
	// Replace with function body.
}

public void start(Vector2 pos)
{
	Position = pos;
	Show();
	GetNode<CollisionPolygon2D>("CollisionPolygon2D").Disabled = false;
}
}
