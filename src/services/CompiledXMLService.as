package services
{
	
	
	import org.robotlegs.mvcs.Actor;
	
	public class CompiledXMLService extends Actor implements IXMLService
	{
		private var xml:XML;
		
		
		public function CompiledXMLService()
		{
			super();
		}
		
		
		//mocked up to fake loading external xml
		
		public function loadXML(__s:String  = null):void
		{
			xml = <stealth>
						<video>
							<item title="Video 1 Title" videoID="AlD9InFzdjo" length="10:01" date="2010,6,4"/>
							<item title="Video 2 Title" videoID="5oGMR9irekY" length="10:02" date="2010,6,4"/>
							<item title="Video 3 Title" videoID="K4yStSP6B7I" length="10:03" date="2010,6,4"/>
							<item title="Video 4 Title" videoID="8Pm0ziZ" length="10:04" date="2010,6,4"/>
							<item title="Video 5 Title" videoID="AlD9InFzdjo" length="10:05" date="2010,6,4"/>
							<item title="Video 6 Title" videoID="5oGMR9irekY" length="10:06" date="2010,6,4"/>
							<item title="Video 7 Title" videoID="8Pm0ziZ" length="10:07" date="2010,6,4"/>
							<item title="Video 8 Title" videoID="AlD9InFzdjo" length="10:08" date="2010,6,4"/>
						</video>
						<gallery>
							<item title="pic 1" date="2010,6,4" url="3355226494_07dab9ba54"/>
							<item title="pic 2" date="2010,6,4" url="3792349339_00000ffb7a"/>
							<item title="pic 3" date="2010,6,4" url="3355957414_bfc397beb4"/>
							<item title="pic 4" date="2010,6,4" url="3793129323_9defc51d63"/>
							<item title="pic 5" date="2010,6,4" url="3355136923_3cbe01c482"/>
							<item title="pic 6" date="2010,6,4" url="3355221976_f13d8e95dc"/>
							<item title="pic 7" date="2010,6,4" url="3354402351_cf6797c126"/>
							<item title="pic 8" date="2010,6,4" url="3793984180_22a64b96d5"/>
							<item title="pic 9" date="2010,6,4" url="3857050268_1e7037cb0e"/>
							<item title="pic 10" date="2010,6,4" url="3793975106_96ed4211d2"/>
							<item title="pic 11" date="2010,6,4" url="3735191063_6b55d6010d"/>
							<item title="pic 12" date="2010,6,4" url="3453670271_3cd0f7458b"/>   							
						</gallery>
						<blog>
							<item title="first blog post" body="Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit " date="2010,6,4" url="http://blogger.com"/>
							<item title="2nd blog post" body="sdfsdfsdf 2sdf sdf sdf sdf sdf sdf" date="2010,6,4" url="http://blogger.com"/>
							<item title="3rd blog post" body="sdfsdfsdf3 sdf sdf sdf sdf sdf sdf" date="2010,6,4" url="http://blogger.com"/>
							<item title="4th blog post" body="sdfsdfsdf 4sdf sdf sdf sdf sdf sdf" date="2010,6,4" url="http://blogger.com"/>						
						</blog>
						<tour>
							<item title="Dundrum," town="S. Dublin" area="Ireland" date="2010,7,6" endDate="2010,7,8" latlng="53.293766,-6.246951"/>
							<item title="Silverburn" town="Glasgow" area="Scotland" date="2010,7,20" endDate="2010,7,22" latlng="55.823068,-4.341466"/>
							<item title="Blue Water" town="Dartford" area="London & SE" date="2010,6,9" endDate="2010,6,11" latlng="51.437745,0.276546"/>
							<item title="Cabot Circus" town="Bristol" area="West & Wales" date="2010,6,16" endDate="2010,6,18" latlng="51.458713,-2.584963"/>
							<item title="Bullring" town="Birmingham" area="Midlands & East" date="2010,6,23" endDate="2010,6,25" latlng="52.47786648540129, -1.893167495727539"/>
							<item title="Trafford Centre" town="Manchester" area="North West" date="2010,6,30" endDate="2010,7,1" latlng="53.465581,-2.347361"/>
							<item title="Westfields" town="London" area="London & SE" date="2010,6,2" endDate="2010,6,4" latlng="51.504469,-0.218740"/>
							<item title="MetroCentre" town="Gateshead" area="Noth East" date="2010,7,13" endDate="2010,7,15" latlng="54.957647,-1.668549"/>
						</tour>
					
					</stealth>;
			
		
		}
	}
}