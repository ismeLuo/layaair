package laya.html.dom {
	import laya.display.css.CSSStyle;
	import laya.display.Sprite;
	import laya.html.utils.HTMLParse;
	import laya.display.ILayout;
	import laya.html.utils.Layout;
	import laya.maths.Rectangle;
	import laya.net.Loader;
	import laya.net.URL;
	import laya.utils.Browser;
	
	/**
	 * DIV标签
	 */
	public class HTMLDivElement extends HTMLElement {
		/**@private */
		public var contextHeight:Number;
		/**@private */
		public var contextWidth:Number;
		
		public function HTMLDivElement() {
			super();
			style.block = true;
			style.lineElement = true;
			style.width = 200;
			style.height = 200;
			HTMLStyleElement;
		}
		
		/**
		 * 设置标签内容
		 */
		public function set innerHTML(text:String):void {
			this.removeChildren();
			appendHTML(text);
		}
		
		/**
		 * 追加内容，解析并对显示对象排版
		 * @param	text
		 */
		public function appendHTML(text:String):void {
			HTMLParse.parse(this, text, URI);
			layout();
		}
		
		/**
		 * @private
		 * @param	out
		 * @return
		 */
		override public function _addChildsToLayout(out:Vector.<ILayout>):Boolean {
			var words:Vector.<Object> = _getWords();
			if (words == null && _childs.length == 0) return false;
			words && words.forEach(function(o:*):void {
				out.push(o);
			});
			var tFirstKey:Boolean = true;
			_childs.forEach(function(o:Sprite):void {
				if (tFirstKey) {
					tFirstKey = false;
				} else {
					out.push(null);
				}
				//o._style._enableLayout() && o._addToLayout(out);
				o._addToLayout(out)
			});
			return true;
		}
		
		/**
		 * @private
		 * @param	out
		 */
		override public function _addToLayout(out:Vector.<ILayout>):void {
			layout();
			//!_style.absolute && out.push(this);
		}
		
		/**
		 * @private
		 * 对显示内容进行排版
		 */
		public function layout():void {
			style._type |= CSSStyle.ADDLAYOUTED;
			var tArray:Array = Layout.layout(this);
			if (tArray) {
				if (!_$P.mHtmlBounds) _set$P("mHtmlBounds", new Rectangle());
				var tRectangle:Rectangle = _$P.mHtmlBounds;
				tRectangle.x = tRectangle.y = 0;
				tRectangle.width = this.contextWidth = tArray[0];
				tRectangle.height = this.contextHeight = tArray[1];
				setBounds(tRectangle);
			}
		}
		
		/**
		 * 如果对象的高度被设置过，返回设置的高度，如果没被设置过，则返回实际内容的高度
		 */
		override public function get height():Number {
			if (_height) return _height;
			return contextHeight;
		}
		
		/**
		 * 如果对象的宽度被设置过，返回设置的宽度，如果没被设置过，则返回实际内容的宽度
		 */
		override public function get width():Number {
			if (_width) return _width;
			return contextWidth;
		}
	
	}

}