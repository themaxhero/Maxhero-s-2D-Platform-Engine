////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#ifndef SCENE_MANAGER_HEADER
#define SCENE_MANAGER_HEADER
#include "scene.hpp"
#include <SFML/Graphics.hpp>
namespace MHPE{
	
	using namespace sf;
	
	class SceneManager{
	
		public:
			SceneManager(RenderWindow &window, Scene &scene);
			Scene GetCurrent();
			void Call(Scene *called_scene);
			void Draw();
			void Update();
			void Return();

		private:
			stack<Scene*> Scenes;
			RenderWindow Window;
	
	};
}
#endif