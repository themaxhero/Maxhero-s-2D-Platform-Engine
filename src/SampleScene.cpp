#include "SampleScene.hpp"
namespace MHPE{
	
	SampleScene::SampleScene(sf::RenderWindow &window){
		parent::Scene(window);
		Sprite Test_Sprite;
		sf::Texture testTex;
		testTex.loadFromFile("./res/Background.png");
		Test_Sprite.setTexture(testTex);
	}
	
	void SampleScene::Update(){

	}

}