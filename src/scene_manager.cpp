////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#include "scene_manager.hpp"
namespace MHPE{
	
	SceneManager::SceneManager(RenderWindow &window, Scene &scene){
		Window = window;
		Scenes.push(scene);
	}
	
	Scene SceneManager::GetCurrent(){
		return Scenes.top(); 
	}
	
	void SceneManager::Call(Scene *called_scene){
		Scenes.push(called_scene);
	}
	
	void SceneManager::Update(){
		Scenes.top()->Update();
	}
	
	void SceneManager::Draw(){
		Scenes.top()->Draw(Window);
	}
	
	void SceneManager::Return(){
		Scenes.pop();
	}

}