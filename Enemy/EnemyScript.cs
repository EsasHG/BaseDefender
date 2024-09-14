using Godot;
using System;

public partial class EnemyScript : CharacterBody2D
{
	[Export]
	float Speed = 300.0f;

	public override void _PhysicsProcess(double delta){
		Velocity = -Position.Normalized() * Speed;
		MoveAndSlide();
	}
}
