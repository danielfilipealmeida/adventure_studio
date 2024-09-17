# Adventure Studio (Temporary Name)

**Adventure Studio** is an Integrated Development Environment (IDE) designed for creating text-based adventure games. Developed in Swift, using **SwiftUI** and **Swift Data**, this tool aims to simplify the process of crafting interactive narratives while providing powerful tools to compile and generate fully functional adventure games.

## Key Features

- **Room Creation**: Easily create rooms, each with a description and multiple connections to other rooms. The IDE supports a many-to-many relationship between rooms, with directional links.
- **Object Management**: Define objects within your world, complete with detailed descriptions that players can inspect during gameplay.
- **Non-Playable Characters (NPCs)**: Add life to your world with NPCs that can interact with the player and the environment.
- **Lua Scripting**: Embed Lua scripting to handle dynamic interactions, puzzles, and more complex gameplay elements.
- **Data Export & Compilation**: After designing your adventure, export the necessary data to generate a lexer and parser using **Flex** and **Bison**. This will compile and produce a running adventure.
  
## Planned Features

- **Adventure Compilation**: Once your adventure is ready, the IDE will export and compile it into a fully functional text adventure, ready to be played.
  
## How it Works

1. **Create Rooms**: Design and connect rooms, defining their descriptions and how they link to one another.
2. **Add Objects**: Place objects in rooms or throughout the world that players can examine and interact with.
3. **Script Interactions**: Use Lua to create complex game logic, including puzzles, dynamic responses, and NPC behaviors.
4. **Compile and Play**: Compile your game into a playable format, complete with lexer and parser generated by Flex and Bison.

## Future Development

Adventure Studio is currently in its early stages, and the name may change in the future. It is still under active development, with plans to add more features and expand functionality based on feedback from the community.

