From: "James Yonan" <jim@...41...>
Message-ID: <twig.1059003877.89013@...41...>
In-Reply-To: <3F1EF20C.5020509@...7...>
References: <Pine.LNX.4.40L2.0307231512170.24538-100000@...52...>, <Pine.LNX.4.40L2.0307231512170.24538-100000@...52...>
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN ported to Windows
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jul 23 16:45:30 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: bishop <bishop@...7...>, Felipe Sanchez <izto@...51...>
Cc: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Yes, currently the CIPE TAP driver has the capability to run on NT 4, 2K, and
XP, but this first beta release of OpenVPN has only been tested on XP so far,
because that's the only windows development machine I have access to right
now.  OpenVPN uses a slightly forked version of the CIPE TAP, but I'm in
contact with Damion K. Wilson who is the author and maintainer of CIPE on
Windows and he has expressed interest in decoupling and modularizing the TAP
driver so that it can be used by other projects.

It would help if others came forward who have an interest in testing and
maintaining OpenVPN on W2K and NT4 -- the binaries really need to be compiled
on the version of windows that they are going to be run on, and compiling
everything from source is not really an option for the end-user as it is a
relatively complex undertaking compared with the ease of ./configure, apt-get,
and emerge that we have come to expect on other OSes.

While I expect that building OpenVPN for 2K and NT4 will be a relatively
straightforward undertaking, the two areas where compatibility breaks down
between the NT 4 series and the 2K/XP series are the .inf file (that's a file
that tells Windows how to install a particular device driver and how it binds
with other device drivers in the system), and the registry layout of network
device driver info.  OpenVPN needs to do some registry lookups in order to
translate the TAP adapter name given in --dev-node into a real filename which
can be passed to the Win32 open file function.

I would agree with Bishop that as far as running on the 9x/Me series is
concerned, I think it's unlikely given the much more limited networking driver
model that is available on that series.

James

bishop <bishop@...7...> said:

> My read of it suggested that, yeah, it only does NT or above, due to the 
> better net stack in the NT family tree.
> 
> Felipe Sanchez wrote:
> > 
> > 
> > This has to be one of the greatest news I've had this week   :-)  Count me
> > in as a heavy beta-tester!
> > 
> > 
> > I have one question: If I recall correctly the cipe TAP driver works only
> > on NT-class Windows operating systems (NT 4, 2K, XP) and not on 9x-class
> > ones (9x/Me).  Is this still the case?
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> > Data Reports, E-commerce, Portals, and Forums are available now.
> > Download today and enter to win an XBOX or Visual Studio .NET.
> > http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> > _______________________________________________
> > Openvpn-users mailing list
> > Openvpn-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-users
> 
> -- 
> 	I tried joining the BATF, but it seems they're actually
> 	AGAINST all three.  Some club they are!
> 



-- 




