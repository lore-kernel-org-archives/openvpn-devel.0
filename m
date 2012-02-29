From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 13:18:05 +0100
Message-ID: <7855235.EvfmKnZP6h@...1526...>
In-Reply-To: <1375292789.20120229123817@...449...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday 29 February 2012 11:38:17 Carsten Kr=FCger wrote:
> > You forgot the GUI in this picture. If the service is connected to the
> > management interface the GUI can't connect anymore.
>=20
> ?
> If I understand you correctly it works this way:
>=20
> openvpnserv.exe spawns openvpn.exe
> openvpnhelperserv.exe spawns openvpnhelper.exe

It's completely different. =3D) There will be a new service, I called it=20
interactive service. The GUI/client connects to a named pipe of that servic=
e.=20
It passes the working directory, command line options and stdin input for=20
openpvn to the service. The service impersonates the client, creates anothe=
r=20
named pipe and starts openvpn. Besides the stuff from the GUI it also passe=
s=20
to client end of the created pipe to openvpn. The GUI may now connect the t=
he=20
management interface. If openvpn needs to perform a privileged operation it=
=20
request it through the named pipe that was passed by the interactive servic=
e.=20
There's only a limited and well defined set of privileged operations that a=
re=20
serviced through the pipe. Currently only setting of IPv4 and IPv6 routes, =
but=20
that will be extended to whatever makes sense e.g. ARP table flush is the n=
ext=20
thing that will come.

> > Not users, really. More like session. So you can connect to different
> > server simultaneously.
>=20
> Yeah, that's a point.
> But I think it would only need management commands like "connect vpn sess=
ion
> 1" "disconnect vpn session 1", "supply credentials for sessions 1".
> Credentials could be more than username/password, for example tls key
> or smartcard "connection".

Again, the management interface is for user execution level related queries=
=20
like give me you password, give me your certificate, give me your proxy=20
settings (most of this is not implemented yet), while the privileged channe=
l=20
is for things that the user may not do. This is specifically tailored for t=
he=20
situation on Windows with the GUI. Don't know if it's usable by other syste=
m=20
as much, i.e. NetworkManager is the mgmt client and root at the same time,=
=20
however no ones holding them back to also pass a unix socket to openvpn and=
=20
set the openvpn routes (etc.) directly instead of performing some sudo wrap=
per=20
script magic or whatever is currently used. Again, this can be extended to =
the=20
point where all privileged operation are performed through the unix socket.=
=20
Binding to the listen socket may be an exception to that if the port is low=
 or=20
can one pass FDs through unix sockets?

> >  Of course this could be used by two different users at the
> >=20
> > same time or different impersonations in the same session, while still
> > running ovpn with the credentials of the entity who started openvpn. So
> > the point isn't really that many user can connect, but that the running
> > sessions will be isolated from each other by the service.
>=20
> hmm, I'm unsure if you would win something.
> If the network communicating process is compromised (exploited from
> internet) than it could get all the credentials via normal interface
> from processes that holds them.

The network communication process is openvpn and it has the rights as the u=
ser=20
that started it. If that user has enough privileges to set it's primary tok=
en=20
you have a very unfortunate setup, securitywise.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


