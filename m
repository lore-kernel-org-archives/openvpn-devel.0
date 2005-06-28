From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <d9gch6$408$1@...165...>
Message-ID: <Pine.LNX.4.58.0506280831370.27900@...41...>
References: <200504291033.00667.ralfluebben@...68...> <d9gch6$408$1@...165...>
MIME-Version: 1.0
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
Date: Tue Jun 28 07:48:44 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 24 Jun 2005, Ralf [UTF-8] L=C3=BCbben wrote:

> Hello,
>=20
> the radius plugin in is working.
> I have still some questions about the OpenVpn behaviour.
>=20
> After one hour there is a rekeying/reauthentication of the user? Is that
> right.

Yes, this depends on the value of the --reneg-sec parameter which is=20
usually set to 3600.

> The problem is that before an user can be authenticated from the
> plugin the user needs a disconnect from OpenVpn for this user. At the
> moment the reauthentenication fails and the OpenVpn disconnects the user
> after the keepalive interval. Ather this the user can connect again.
>=20
> Have I the possibility to get the information if the authentication is a =
new
> or a reauthentication from the enviroment variable?
>=20
> Maybe if I already have the user in my internal list and the user comes in
> with the same username, password and remote_ip he is authenticated without
> asking the radius server.
> The other possibility is too delete the user from the list and add the us=
er
> again to the list.

One thing that I'm thinking about adding to the plugin interface is an=20
explicit constructor and destructor callback for client instance objects,=20
and a related client handle which would be passed to all the plugin=20
functions.

Right now, the best way to do this is to track client-connect and=20
client-disconnect calls.

> What are about the counters in the status file? Are they set to 0 at the
> rekeying/reauthentication? So I have to send the stop ticket to the radius
> server and I have to send again a start ticket.

The rekeying is "under the hood" and should mostly be invisible from the=20
perspective of a plugin.  There shouldn't be any=20
client-disconnect/client-connect cycling when this occurs.

> What are the maximum length of strings in the enviroment that I can get f=
rom
> the OpenVpn process? Maybe 128 characters for the username and password.

Right now the max username and password length is defined as

#define USER_PASS_LEN 128

in misc.c (each separately can be up to this length).

However, for environmental variables in general, there is no length=20
restriction.

James

> Ralf L=C3=BCbben
>=20
>=20
> Ralf L=C3=BCbben wrote:
>=20
> > Hello,
> >=20
> > I am interesting in build radius support for OpenVpn.
> > At the moment I'am thinking about what is the best way.
> >=20
> > 1. Authentification and Authroization:
> > I think this already works with the plugin pam_radius_auth.so, is that
> > right?
> >=20
> > But I am interested in more features,
> > like to get the ip-address and the routes from the RADIUS-Server.
> > Can this be done with a plugin? Maybe by creating the configurationfiles
> > at the start of the connection?
> > Or could this be integrated in the Source Code? I think this would be t=
he
> > best solution.
> > I hope the fea
> > 2. Accounting:
> > I need to count the traffic  of a VPN-connection, one the side every
> > traffic which goes from a client to the server (tun0-interface) and one
> > the other side every traffic which goes through the VPN, maybe from one
> > client to another client.
> > So when I use the counter of the tun-interface, I lose the traffic which
> > goes from one client to another. If I count the traffic of the
> > eth-interface I get other traffic, which has nothing to do with the vpn.
> >=20
> > Maybe someone has some experiences with this topic and give some hints
> > which is the best way? To do all things in a modul or to do all changes=
 in
> > the source code. and where I have to look in the source code to integra=
te
> > this feature.
> >=20
> > I hope there is a gerneal interest in this feature.
> >=20
> > For every help I am very grateful.
> >=20
> > Ralf L=C3=BCbben
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

