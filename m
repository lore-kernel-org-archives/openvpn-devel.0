Message-ID: <a10961760510210212j5e1bf8cp@...278...>
From: Janne Johansson <icepic.dz@...277...>
Subject: Re: [Openvpn-devel] Re: Bug report (long) - OpenVPN dropping small frames
In-Reply-To: <Pine.LNX.4.61.0510210841210.29827@...210...>
MIME-Version: 1.0
References: <dj6pnr$gs4$1@...165...>
	 <Pine.LNX.4.58.0510192103130.32723@...41...>
	 <dj8pnu$1ea$1@...165...>
	 <Pine.LNX.4.61.0510210841210.29827@...210...>
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
Date: Fri Oct 21 02:14:05 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Mathias Sundman <mathias@...454...>
Cc: Mike Ireton <mike-openvpn@...479...>, openvpn-devel@lists.sourceforge.net

> >       For the others who suggested reducing mss values and such - I'm
> > already doing it. In fact I have mss clamped down to 1312 right now for
> > testing. But, mss clamping doesn't have anything to do with the loss of=
 the
> > lcp-echo frames I was complaining about.
> >
> Janne also suggested that you could play with the MTU settings. I don't
> think you will get away with only changing the MTU when you're doing
> bridging though as you would then have to change the MTU on ALL hosts
> connected to both sides of the bridge as it's the transmitting hosts MTU
> that decides what frame size to use, not the recieving end (the openvpn
> machine).

According to this wepbage: http://www.netheaven.com/pmtu.html
you can use:
echo  1  >/proc/sys/net/ipv4/ip_no_pmtu_disc
to make linux hosts stop doing the DF-trick. Might be helpful if that seems=
 to
be the case for you.

--
Some mornings, it's just not worth gnawing through the straps...

