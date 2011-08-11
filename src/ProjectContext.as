package 
{
	import controllers.BlackBoxDataReceivedCommand;
	import controllers.EnterWinnerCommand;
	import controllers.GameTypeSelectedCommand;
	import controllers.InitSocketCommand;
	import controllers.LoadLeaderBoardXML;
	import controllers.RequestGameIDCommand;
	import controllers.RequestLeaderBoardCommand;
	import controllers.RestartCommand;
	import controllers.ServiceSetCommand;
	import controllers.StartClickedCommand;
	import controllers.StoreSettingsXMLCommand;
	import controllers.SubmitData;
	import controllers.UpdateBalanceCommand;
	import controllers.UpdateWinnerCommand;
	
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
	import services.GameIDService;
	import services.InitialXMLService;
	import services.LeaderBoardService;
	import services.socketUtils.CustomSocket;
	import services.socketUtils.SocketConnector;
	
	import signals.BalanceSet;
	import signals.BlackBoxDataReceived;
	import signals.ChangeState;
	import signals.DataSubmitted;
	import signals.EnterWinner;
	import signals.ErrorReceived;
	import signals.ForceShowHighlight;
	import signals.GameIDSet;
	import signals.GameTypeSelected;
	import signals.GameTypeSet;
	import signals.GraphDataSet;
	import signals.InitSocket;
	import signals.IterationChange;
	import signals.LeaderBoardSet;
	import signals.LoadXML;
	import signals.MusicVolumeSet;
	import signals.RequestGameID;
	import signals.RequestLeaderBoard;
	import signals.RestartGame;
	import signals.SettingsUpdated;
	import signals.SettingsXMLLoaded;
	import signals.ShowWinnerHighlight;
	import signals.StageSet;
	import signals.StartClicked;
	import signals.StatusUpdate;
	import signals.TextSetOnModel;
	import signals.UpdateBalance;
	import signals.UpdateWinner;
	import signals.UserDataSet;
	import signals.UserDataSetLive;
	import signals.WaitSetByXML;
	
	import utils.Logger;
	
	import view.audio.BackgroundMusic;
	import view.components.ExitView;
	import view.components.FinalView;
	import view.components.InputView;
	import view.components.IntroView;
	import view.components.LeaderBoard;
	import view.components.ResultsView;
	import view.mediators.BackgroundMusicMediator;
	import view.mediators.ExitMediator;
	import view.mediators.FinalViewMediator;
	import view.mediators.InputMediator;
	import view.mediators.IntroMediator;
	import view.mediators.LeaderBoardMediator;
	import view.mediators.ProjectMediator;
	import view.mediators.ResultsMediator;
	
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
			injector.mapSingleton(UserDataModel);
			
			//map services
			injector.mapSingleton(BlackBoxService);
			injector.mapSingleton(LeaderBoardService);
			injector.mapSingleton(CompiledXMLService);
			injector.mapSingleton(InitialXMLService);
			injector.mapSingleton(GameIDService);
			
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
			injector.mapSingleton(BalanceSet);
			injector.mapSingleton(IterationChange);
			injector.mapSingleton(GraphDataSet);
			injector.mapSingleton(RestartGame);
			injector.mapSingleton(GameIDSet);
			injector.mapSingleton(CustomSocket);
			injector.mapSingleton(UserDataSetLive);
			injector.mapSingleton(GameTypeSet);
			injector.mapSingleton(ShowWinnerHighlight);
			injector.mapSingleton(WaitSetByXML);
			injector.mapSingleton(ForceShowHighlight);
			injector.mapSingleton(MusicVolumeSet);

			
			//map signals   -maps signals to commands
			signalCommandMap.mapSignalClass(LoadXML, LoadLeaderBoardXML);
			signalCommandMap.mapSignalClass(SettingsXMLLoaded, StoreSettingsXMLCommand);
			signalCommandMap.mapSignalClass(SettingsUpdated, ServiceSetCommand);
			signalCommandMap.mapSignalClass(StartClicked, StartClickedCommand);
			signalCommandMap.mapSignalClass(UpdateBalance, UpdateBalanceCommand);
			signalCommandMap.mapSignalClass(DataSubmitted, SubmitData);
			signalCommandMap.mapSignalClass(BlackBoxDataReceived, BlackBoxDataReceivedCommand);
			signalCommandMap.mapSignalClass(RestartGame, RestartCommand);
			signalCommandMap.mapSignalClass(RequestLeaderBoard, RequestLeaderBoardCommand);
			signalCommandMap.mapSignalClass(EnterWinner, EnterWinnerCommand);
			signalCommandMap.mapSignalClass(UpdateWinner, UpdateWinnerCommand);
			signalCommandMap.mapSignalClass(RequestGameID, RequestGameIDCommand);
			signalCommandMap.mapSignalClass(InitSocket, InitSocketCommand);
			signalCommandMap.mapSignalClass(GameTypeSelected, GameTypeSelectedCommand);
			
			
			//map mediators
			mediatorMap.mapView(AircraftGame, ProjectMediator);
			mediatorMap.mapView(IntroView, IntroMediator);
		//no longer used as leaderboard appears multiple places	mediatorMap.mapView(LeaderBoard, LeaderBoardMediator);
			mediatorMap.mapView(InputView, InputMediator);
			mediatorMap.mapView(ResultsView, ResultsMediator);
			mediatorMap.mapView(FinalView, FinalViewMediator);
			mediatorMap.mapView(ExitView, ExitMediator);
			mediatorMap.mapView(BackgroundMusic, BackgroundMusicMediator);
			
			
			
			
		}
	}
}