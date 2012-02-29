MIME-Version: 1.0
In-Reply-To: <7855235.EvfmKnZP6h@...1526...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
Date: Wed, 29 Feb 2012 14:40:45 +0200
Message-ID: <CAOazyz3hiUis_34SfbNU1kcFxS=MiA7WMv0Y6Ldr5K3CDC-Mvg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/2/29 Heiko Hund <heiko.hund@...1489...>
>
> On Wednesday 29 February 2012 11:38:17 Carsten Kr=C3=BCger wrote:
> > > You forgot the GUI in this picture. If the service is connected to the
> > > management interface the GUI can't connect anymore.
> >
> > ?
> > If I understand you correctly it works this way:
> >
> > openvpnserv.exe spawns openvpn.exe
> > openvpnhelperserv.exe spawns openvpnhelper.exe
>
> It's completely different. =3D) There will be a new service, I called it
> interactive service. The GUI/client connects to a named pipe of that
> service.
> It passes the working directory, command line options and stdin input for
> openpvn to the service. The service impersonates the client, creates
> another
> named pipe and starts openvpn. Besides the stuff from the GUI it also
> passes
> to client end of the created pipe to openvpn. The GUI may now connect the
> the
> management interface. If openvpn needs to perform a privileged operation
> it
> request it through the named pipe that was passed by the interactive
> service.
> There's only a limited and well defined set of privileged operations that
> are
> serviced through the pipe. Currently only setting of IPv4 and IPv6 routes,
> but
> that will be extended to whatever makes sense e.g. ARP table flush is the
> next
> thing that will come.

This is way too complex solution for a simple problem.
A proper design and discussion should take place before advancing in
this route.

Alon.

