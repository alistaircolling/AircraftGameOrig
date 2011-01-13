package 
{
	import controllers.LoadSettingsXMLCommand;
	import controllers.ServiceSetCommand;
	import controllers.StartClickedCommand;
	import controllers.StoreSettingsXMLCommand;
	
	import flash.display.DisplayObjectContainer;
	
	import model.ExampleModel;
	import model.LeaderBoardModel;
	import model.SettingsModel;
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.mvcs.SignalCommand;
	import org.robotlegs.mvcs.SignalContext;
	
	import services.BlackBoxService;
	import services.CompiledXMLService;
	import services.LeaderBoardService;
	
	import signals.ChangeState;
	import signals.ErrorReceived;
	import signals.LeaderBoardSet;
	import signals.LoadXML;
	import signals.SettingsUpdated;
	import signals.SettingsXMLLoaded;
	import signals.StageSet;
	import signals.StartClicked;
	import signals.StatusUpdate;
	import signals.TextSetOnModel;
	import signals.UpdateBalance;
	import signals.UserDataSet;
	
	import view.components.InputView;
	import view.components.IntroView;
	import view.components.LeaderBoard;
	import view.mediators.InputMediator;
	import view.mediators.IntroMediator;
	import view.mediators.LeaderBoardMediator;
	import view.mediators.ProjectMediator;
	
	public class ProjectContext extends SignalContext
	{
		
		public function ProjectContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void{
			
		
			//map models
			injector.mapSingleton(SettingsModel);
			injector.mapSingleton(ExampleModel);
			injector.mapSingleton(LeaderBoardModel);
			injector.mapSingleton(BlackBoxService);
			injector.mapSingleton(LeaderBoardService);
			injector.mapSingleton(UserDataModel);
			
			//map signal singletons
			injector.mapSingleton(SettingsUpdated);
			injector.mapSingleton(StartClicked);
			injector.mapSingleton(TextSetOnModel);
			injector.mapSingleton(LeaderBoardSet);
			injector.mapSingleton(StageSet);
			injector.mapSingleton(ErrorReceived);
			injector.mapSingleton(ChangeState);
			injector.mapSingleton(UserDataSet);
			injector.mapSingleton(StatusUpdate);
			injector.mapSingleton(UpdateBalance);
			
			
			//map services
			injector.mapSingleton(CompiledXMLService);
			
			//map signals   -maps signals to commands
			signalCommandMap.mapSignalClass(LoadXML, LoadSettingsXMLCommand);
			signalCommandMap.mapSignalClass(SettingsXMLLoaded, StoreSettingsXMLCommand);
			signalCommandMap.mapSignalClass(SettingsUpdated, ServiceSetCommand);
			signalCommandMap.mapSignalClass(StartClicked, StartClickedCommand);
			
			
			//map mediators
			mediatorMap.mapView(AircraftGame, ProjectMediator);
			mediatorMap.mapView(IntroView, IntroMediator);
			mediatorMap.mapView(LeaderBoard, LeaderBoardMediator);
			mediatorMap.mapView(InputView, InputMediator);
			
		//	var lbModel:LeaderBoardService = injector.getInstance(LeaderBoardService) as LeaderBoardService;
		//	lbModel.requestData();
			
		}
	}
}