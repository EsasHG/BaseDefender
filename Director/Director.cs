using Godot;
using System;

public partial class Director : Node2D
{
	public static Director instance;
	
	[Export]
	public Spawner spawner;
	
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready(){
		instance = this;
		spawner.startWave(100, 20);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta){
		
	}
}
