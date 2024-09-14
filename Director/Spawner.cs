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

	[Export]
	float minDist;
	[Export]
	float maxDist;
	

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
		GetParent().GetParent().AddChild(newEnemy);
		float posX = rand.RandfRange(minDist, maxDist) * Mathf.Sign(rand.RandfRange(-1, 1));
		float posY = rand.RandfRange(-maxDist, maxDist);
		
		newEnemy.Position = rand.Randf() > 0.5f ? new Vector2(posX, posY) : new Vector2(posY, posX);
	}
	
}
