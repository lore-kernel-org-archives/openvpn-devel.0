From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 16:03:38 +0100
Message-ID: <1404593.Apkr3x9kAi@...1526...>
In-Reply-To: <CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Fabian

On Wednesday 29 February 2012 14:07:01 Fabian Knittel wrote:
> Let's see whether I understood the design. After initial setup, the
> GUI has a connection via the mgmt interface to OpenVPN and OpenVPN has
> a connection via the "privilege interface" to the "interactive
> service". OpenVPN basically runs in the same context as the GUI, i.e.
> without permission to change the network configuration (change routes,
> etc.). The "interactive service" runs in a context with permissions to
> change the network configuration. Any privileged operations are
> requested by OpenVPN via the "privilege interface" and performed by
> the "interactive service". (There must be something missing, otherwise
> I don't get why you call it "interactive service" ...?)

It's interactive in contrast to the other already existing service, that ju=
st=20
starts all openvpn connections that it finds at the time the service itself=
 is=20
started. I internally called that service automatic. The GUI and openvpn=20
interact with the interactive service, hence the name. And partially becaus=
e I=20
couldn't come up with something that made more sense.
=20
> Why does the "interactive service" need to start OpenVPN? Why not let
> the GUI start OpenVPN and let OpenVPN connect to the "interactive
> service"?

The key point here is the inheritance of the client end of the named pipe=20
that's being used to request privileged operations. If there would just be =
a=20
named pipe anyone could connect to, anyone could modify i.e. the routing=20
table. Something MS tries to prevent obviously.

> OTOH, if you're going to start OpenVPN as a service anyway,
> it probably doesn't really make much of a difference. Although this
> could mean that you can keep the GUI-facing side of OpenVPN identical
> to what it is now... the "interactive service" would just be an
> implementation detail of how openvpn performs its privileged
> operations.

I got lost at "going to start OpenVPN as a service anyway". Openvpn isn't=20
started as a service, the service starts openvpn. Openvpn is not running wi=
th=20
same token the service runs, but the token of the GUI that invoked the=20
service.

> Does creating a tun/tap device belong to the operations that need
> special privileges under windows? If so, this sounds a lot like an
> interface that might also allow splitting off most of the system
> specific code ... as in, this could also work on Android, no?

No, that example was a spin off to my lengthy and highly fictional=20
NetworkManager story. =3D) Essentially you're right, though. It could be us=
ed as=20
such. Usually I#d say that stuff that can be setup before privileges are=20
dropped should be done at that time. Setting of routes can only be done aft=
er=20
privdrop and that's the main use for the new interface.

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


