////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#include "scene.hpp"
namespace MHPE{
	
	Scene::Scene(SceneManager &sm,sf::RenderWindow &window){
		SceneManager SceneMan     = sm;
		sf::RenderWindow Win      = window;
	}
	
	void Scene::Update(){
		
	}
	
	void Scene::Draw(){
		for(list<Sprite*>::iterator it = Sprites.begin(); it != Sprites.end(); ++it){
			Window.draw(**it);
		}
	}

}