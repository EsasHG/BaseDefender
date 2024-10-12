using Godot;
using System;

public partial class Director : Node2D
{
	public static Director instance;
	
	[Export]
	public Spawner spawner;

	[Export]
	public int currentCount = 20;
	[Export]
	public float currentRate = 5;

	[Export]
	Button nextNightButton;
	
	
	public bool day = false;

	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready(){
		instance = this;
		nextNight();
	}

	public void nextDay(){
		day = true;
		nextNightButton.Show();
	}
	
	public void nextNight(){
		spawner.startWave(currentCount, currentRate);
		day = false;
		nextNightButton.Hide();
		currentCount = (int) (currentCount * 1.2f);
		currentRate *= 1.1f;
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta){
		if (GetTree().GetNodesInGroup("Enemies").Count <= 0){
			nextDay();
		}
	}
}
