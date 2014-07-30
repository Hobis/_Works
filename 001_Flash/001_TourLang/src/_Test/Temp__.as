		// :: LayerModule 초기화상태로 이후
		private function p_lm_workReset_after():void
		{
			if (this._dObj.groupLayers != null)
			{
				var t_la:uint = this._dObj.groupLayers.length;
				for (var i:uint = 0; i < t_la; i++)
				{
					var t_stepGroups:Array = this._dObj.groupLayers[i];
					var t_lb:uint = t_stepGroups.length;
					for (var j:uint = 0; j < t_lb; j++)
					{
						var t_cl:CheckList = t_stepGroups[j];
						t_cl.selectedIndexDispatch = -1;
					}
				}
			}
		}

		// :: LayerModule 초기화상태로
		private function p_lm_workReset():void
		{
			if (this._dObj != null)
			{
				this._popUpWrap.open('#_4', {
					msg:
						'\n\n\n\n' +
						'정말로 초기화 할까요?'

					,
					afterFunc: this.p_lm_workReset_after
				});
			}
		}