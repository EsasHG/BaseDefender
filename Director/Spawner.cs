using Godot;
using System;

public partial class Spawner : Node2D
{
	[Export]
	PackedScene enemy;
	[Export]
	float minDist;
	[Export]
	float maxDist;
	

	

	float spawnDelay;
	double spawnTimer;
	int spawnCounter = 0;
	
	RandomNumberGenerator rand;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready(){
		rand = new RandomNumberGenerator();
		SetProcess(false);
	}

	public void startWave(int count, float spawnRate){
		spawnCounter = count;
		spawnDelay = 1 / spawnRate;
		spawnTimer = 0;
		SetProcess(true);
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta){
		spawnTimer += delta;
		while (spawnTimer >= spawnDelay){
			spawnEnemy();
			spawnTimer -= spawnDelay;
			spawnCounter--;
			GD.Print(spawnCounter);
			if (spawnCounter <= 0){
				SetProcess(false);
				return;
			}
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
