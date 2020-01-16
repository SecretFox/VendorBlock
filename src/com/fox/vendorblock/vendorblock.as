/*
* ...
* @author fox
*/
import com.GameInterface.InventoryItem;
import mx.utils.Delegate;

class com.fox.vendorblock.vendorblock {
	public static function main(root:MovieClip){
		var mod = new vendorblock();
		root.OnModuleActivated = function(){mod.Activate()};
	}
	
	public function Activate(){
		Hook();
	}
	
	private function Hook(){
		var backpack = _root.backpack2;
		if (!backpack.CanSellItem){
			setTimeout(Delegate.create(this, Hook), 100);
			return
		}
		if (backpack.sellBlock){
			return;
		}
		var f = function(inventoryItem:InventoryItem){
			var canSell = arguments.callee.base.apply(this, arguments);
			var canSell2 = true;
			switch(inventoryItem.m_RealType){
				case 30129: //glyph
				case 30133: //signet
				case 30104: // Weapon Start
				case 30106:
				case 30107:
				case 30118:
				case 30112:
				case 30110:
				case 30111:
				case 30100:
				case 30101: // Weapon End
				case 30131: // Talismans
					canSell2 = !inventoryItem.m_IsBoundToPlayer;
					break
				default:
					canSell2 = true;
			}
			return canSell && canSell2;
		}
		f.base = backpack.CanSellItem;
		backpack.CanSellItem = f;
		backpack.sellBlock = true;
	}
}