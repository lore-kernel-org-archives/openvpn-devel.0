MIME-Version: 1.0
In-Reply-To: <20150730233727.GW3676@...2049...>
References: <20150730233727.GW3676@...2049...>
Date: Fri, 31 Jul 2015 11:19:15 +0300
Message-ID: <CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
From: Lev Stipakov <lstipakov@...277...>
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

Hello Samuel,

Do you use radius plugin from http://www.nongnu.org/radiusplugin/ ? I
think the way OpenVPN delegates authentication to a plugin
(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook) is asynchronous, as well
as plugin implementation, i. e. OpenVPN does not wait for a response.
Instead it periodically checks a tmp file to where plugin is supposed
to write authentication result (1 or 0).

However, plugin may also hook on OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
which is called after authentication has been done. OpenVPN calls that
hook synchronously, which may cause traffic to stall. There is a patch
that makes OpenVPN behave asynchronously, however it is not (yet)
merger to the master branch.

http://sourceforge.net/p/openvpn/mailman/message/33244190/

We used to have a packet loss issue due to synchronous nature of
client-connect and that patch has solved it.

-Lev

2015-07-31 2:37 GMT+03:00 Samuel Thibault <samuel.thibault@...1817...>:
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



-- 
-Lev

