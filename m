Subject: Re: [Openvpn-devel] 2.0: public linux <- nat -> private win2k
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084383203.89669@...41...>
In-Reply-To: <40A12427.1060104@...61...>
References: <twig.1084300129.5764@...41...>, <twig.1084300129.5764@...41...>
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
Date: Wed May 12 10:34:17 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Julien TOUCHE <julien.touche@...61...>, INVALID_ADDRESS@...215...
Cc: openvpn-devel@lists.sourceforge.net

Julien TOUCHE <julien.touche@...61...> said:

> James Yonan wrote:
> 
> > That's just the --verb 5 debugging mode that shows packet flows through
> > OpenVPN.  Try using --verb 4 or lower to suppress that output.
> > 
> ok i've missed the changelog, thanks
> 
> > 
> >>the pull options seems also to not work or is it only for "mode server"
> >>as i'm using "proto tcp-server" (in this setup, udp returns udp port X
> >>unreachable) and shared secret for now ?
> > 
> > 
> > Right now --push/--pull is primarily oriented towards --mode server usage,
> > though it should also work in OpenVPN's traditional peer-to-peer mode if TLS
> > is used.
> why is it reserved for tls mode ?

--push and --pull need a reliable back-channel to communicate the settings. 
Only TLS mode has that right now.  Non-TLS mode is stateless as well, meaning
that both peers want to have the full config before they even open the UDP/TCP
channel.

James


