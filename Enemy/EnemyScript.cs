using Godot;
using System;

public partial class EnemyScript : CharacterBody2D
{
	[Export]
	float Speed = 300.0f;
	
	[Export]
	float health = 3;
	
	public override void _PhysicsProcess(double delta){
		Velocity = -Position.Normalized() * Speed;
		MoveAndSlide();

		int collisionCount = GetSlideCollisionCount();

		for (int i = 0; i < collisionCount; i++){
			KinematicCollision2D collision = GetSlideCollision(i);
			if(((Node2D)collision.GetCollider()) is Base target)
			{
				target.damage();
				QueueFree();
				break;
			}
			
		}
		
	}

	public void hit(int amount = 1){
		health -= amount;

		if (health <= 0){
			QueueFree();
		}
	}
	
	
}
