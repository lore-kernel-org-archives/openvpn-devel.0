From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN future goals
In-Reply-To: <42024CEA.7010908@...349...>
Message-ID: <Pine.LNX.4.58.0502031326350.23846@...41...>
References: <42024CEA.7010908@...349...>
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
Date: Thu Feb  3 12:35:15 2005
Content-Type: TEXT/PLAIN; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mathieu GIANNECCHINI <mathieu.giannecchini@...349...>
Cc: Openvpn-devel@lists.sourceforge.net

On Thu, 3 Feb 2005, Mathieu GIANNECCHINI wrote:

> Hello,
>=20
> I wonder about about OpenVPN future goals. I know that evolution between=
=20
> the 1.x version and 2.0 with the possiblity to have multiple clients=20
> connected to a single server is a great and very important evolution.=20=
=20
>=20
> For example :
>=20
> I have a server in Paris connected two clients : one is located in Dakar=
=20
> and an other one in Hano=EF.
> As the server knows it has two clients connected, my aim is to=20
> automatically initiate a connection between Dakar and Hano=EF ... so that=
=20
> Dakar and Hano=EF can communicate directly. Of course this suppose that=20
> Paris will diffuse some informations about endpoints, and that Dakar or=20
> Hanoi had a openvpn process that can be client (for Paris) _and_ server=20
> for the other endpoint.
>=20
> Is it possible to imagine that in the next release ?
> Or is it already possible ? ;-)

Full mesh is on the post-2.0 wishlist.

The way I envision it would work is that if a client has a public IP
address, it could advertise itself to the server as being directly
accessible.  The server (if configured to support this feature) would then
act as a sort of dynamic routing daemon by broadcasting a routing table of
directly addressible clients.  The client could then choose to connect
directly to another client rather than pass all data through the server.

James


