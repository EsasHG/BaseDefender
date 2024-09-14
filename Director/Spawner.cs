using Godot;
using System;

public partial class Spawner : Node2D
{
	[Export]
	PackedScene enemy;

	[Export]
	int perWaveCount;
	[Export]
	float waveDelay;

	double waveTimer;

	RandomNumberGenerator rand;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready(){
		rand = new RandomNumberGenerator();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta){
		waveTimer += delta;

		while (waveTimer >= waveDelay){
			spawnWave();
			waveTimer -= waveDelay;
		}
	}

	void spawnWave(){
		for (int i = 0; i < perWaveCount; i++){
			spawnEnemy();
		}
	}

	void spawnEnemy(){
		Node2D newEnemy = (Node2D)enemy.Instantiate();
		newEnemy.Position = new Vector2(rand.RandfRange(-500, 500), rand.RandfRange(-500, 500));
	}
	
}
