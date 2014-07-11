////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#ifndef SPRITE_HEADER
#define SPRITE_HEADER
#include <SFML/Graphics.hpp>
namespace MHPE{
	
	class Sprite;
	
	class Sprite : sf::Sprite{

		int z = 0;

		public:
			Sprite(sf::RenderWindow &window);
			Sprite(sf::RenderWindow &window,sf::Texture &texture);
			~Sprite();
			int GetZ();
			void Draw();
			void Sort();
			void SetZ();
			bool IsZBigger();
			void SetSourceRect();
	
		private:
			static list<Sprite*> Sprites;
			sf::RenderWindow Window;
	
	};
}
#endif