////////////////////////////////////////////////////////////////////////////////////
// 
// Main.cpp - Main Code that runs first
// 
////////////////////////////////////////////////////////////////////////////////////
#include <SFML/Graphics.hpp>
#include "scene.hpp"
int main()
{

	sf::RenderWindow window(sf::VideoMode(640, 480), "MHPE");
	SampleScene scene;
	MHPE::SceneManager scenemanager(window,scene);

	while (window.isOpen()) {
		sf::Event event;
		while (window.pollEvent(event)) {
			if (event.type == sf::Event::Closed)
				window.close();
		}
		window.clear();
		scenemanager.Draw();
		//window.draw(shape);
		window.display();
	}

	return 0;

}