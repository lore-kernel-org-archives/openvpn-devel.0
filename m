Subject: Re: [Openvpn-devel] multiple connections on one tap
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1080909081.10943@...41...>
In-Reply-To: <406D45C1.2030900@...196...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr  2 04:32:13 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Miika Keskinen <weeti@...196...>, openvpn-devel@lists.sourceforge.net

Miika Keskinen <weeti@...196...> said:

> Hi.
> 
> How much functionality there needs to be implemented in order to get 
> multiple connections with one tap-adapter working? And then, should that 
> be implemented either by implementing ethernet-switch or maybe even with 
> bridging-code? Normally when talking about bridges there is limit of 256 
> interfaces per bridge and I can see that as an issue.

OpenVPN would need to be a switch.  That means scanning ARPs, learning MAC
addresses, propagating broadcasts, etc.

> Then again, another issue with windows version of openvpn and mostly 
> it's way of resolving whether it's run as service. It would be more than 
> nice to be able to call like os.popen("openvpn ....") on windows too but 
> called that way it cannot get those consolethingies and doesn't like it. 
> So anyone got this same problem? I think that identifying could be done 
> by other means.

OpenVPN doesn't need to be run from a console window (otherwise running as a
service wouldn't work).  OpenVPN tries to open the console, but if it doesn't
exist, it is nonfatal -- OpenVPN will continue to run.  It does, however, want
the standard file handles (especially stdout) to point to something so it can
generate logging output.

James

> And sorry for my bad engrish ;)
> 
> yours.
> Miika Keskinen
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




