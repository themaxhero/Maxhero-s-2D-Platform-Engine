////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#ifndef Scene_HEADER
#define Scene_HEADER
#include <SFML/Graphics.hpp>
#include "Scene_manager.hpp"
namespace MHPE{

	using namespace sf;
	
	class Scene{
	
		public:
			Scene(SceneManager &sm,RenderWindow &window);
			void Draw();
			void Update();

		private:
			SceneManager SceneMan;
			RenderWindow Win;

	};
}
#endif