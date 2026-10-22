using Godot;

public partial class Player : CharacterBody2D
{
    private const float Speed = 200.0f;

    public override void _Ready()
    {
        GD.Print("Player inicializado - normalização manual");
    }

    public override void _PhysicsProcess(double delta)
    {
        
    }
}