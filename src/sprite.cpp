////////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
////////////////////////////////////////////////////////////////////////////////////
#include "sprite.hpp"
namespace MHPE{

	//Sprite Constructor
	Sprite::Sprite(sf::RenderWindow &window){ 
		Window = window;
		Sprites.push(this);
		parent::Sprite();
	}

	Sprite::Sprite(sf::RenderWindow &window,sf::Texture &texture){ 
		Window = window;
		Sprites.push(this);
		parent::Sprite(texture);
	}

	Sprite::~Sprite(){
		for(list<Sprite*>::iterator it = Sprites.begin(); it != Sprites.end(); ++it){
			if(this == *it)
				Sprites.erase(it);
		}
	}

	int Sprite::GetZ(){return this.z;}

	void Sprite::SetZ(int value){this.z = value;}

	void Sprite::SetSourceRect(sf::IntRect &rect){
		SetTextureRect(&rect);
	}

	void Sprite::IsZBigger(Sprite *sprite1,Sprite *sprite2){
		if (sprite1->GetZ() > sprite2->GetZ())
			return true;
		return false;
	}

	void Sprite::Draw(){
		for(list<Sprite*>::iterator it = Sprites.begin(); it != Sprites.end(); ++it){
			Window.draw(**it);
		}
	}

}