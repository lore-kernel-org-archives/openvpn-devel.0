MIME-Version: 1.0
In-Reply-To: <20150730233727.GW3676@...2049...>
References: <20150730233727.GW3676@...2049...>
Date: Fri, 31 Jul 2015 14:09:51 +0500
Message-ID: <CAFHpkQGqdJdpz_FTPWzsziNHbMCt3DOwkLHA8BXU9M+-+Cv_mA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Samuel Thibault <samuel.thibault@...1817...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

I've rewritten radius thing with .net, my plugin performs queries to
multiple radius servers in parallel, I'm using it with Mono in
production for few months:

https://github.com/skbkontur/openvpn-auth-radius

I can help with that plugin if you are interested

2015-07-31 4:37 GMT+05:00 Samuel Thibault <samuel.thibault@...1817...>:
> Hello,
>
> We've been having issues on our VPN server due to the way authentication
> is done in openvpn.  Basically, when a user would connect to the VPN
> server, no trafic would pass for a couple of seconds, thus making
> the VPN way less effective...  This was an unfortunate combination
> of several issues described below.  Our current setup is openvpn in
> multiple client mode, with the openvpn-auth-radius plugin to get
> authentication from a couple of radius servers on two other machines
> next to our VPN server.
>
> Here is what happens:
>
> - AIUI, when openvpn receives an authentication request, it gives hand
> to the authentication plugin, and thus while the authentication plugin
> is working on it, no trafic can be handled by openvpn.  That is, I
> believe, an important issue, and will turn that into a bug report.  The
> issue is that authentication might take time for whatever reason (see
> below for an example).
>
> - The radius authentication plugin interrogates our two radius servers,
> gets a response, and gives back hand to openvpn.
>
> - The issue we were having is that the first of the two radius servers
> is being replaced, and is thus currently turned off.  Since the radius
> plugin tries the first server first and waits for a couple of seconds
> before trying the second one, the authentication currently always takes
> a couple of seconds. Unfortunately, that thus makes openvpn not process
> traffic for that couple of seconds...  Of course I have now disabled the
> first radius server to avoid the issue, but a radius server downtime
> (e.g. reboot or whatever) should *not* make trafic stall, so it's not
> acceptable.
>
> One could argue that the radius plugin should perhaps try both servers
> at the same time and take the first answer it gets.  That however drops
> the idea of load balancing, and in case both radius servers are down,
> the openvpn trafic will get interrupted everytime somebody tries to
> connect (and retry shortly after again and again since it'll fail),
> that's really not acceptable either.
>
> Samuel
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

