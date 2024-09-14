using Godot;
using System;

public partial class Base : StaticBody2D
{
	int health = 50;

	public void damage(int amount = 1){
		health -= amount;

		if (health <= 0){
			//die
		}
	} 
}
