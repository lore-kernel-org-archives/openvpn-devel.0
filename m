Subject: Re: [Openvpn-devel] Radius support (Authentification,
	Authorization and Accounting)
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <200505031348.25263.ralfluebben@...68...>
References: <200504291033.00667.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504300118280.24107@...41...>
	 <Pine.LNX.4.58.0504301334040.25603@...41...>
	 <200505031348.25263.ralfluebben@...68...>
Message-Id: <1115125584.19570.21.camel@...23...>
Mime-Version: 1.0
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
Date: Tue May  3 07:38:13 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, den 03.05.2005, 13:48 +0200 schrieb Ralf L=FCbben:
> If the server sends a "access-accept-ticket" the authorization is ok,
> in the=20
> ticket can be some attributes:
>=20
> - Framed-IP-Address: The IP-address which is pushed to the client.

AFAIK for receiving a Framed-IP-Address out of a IP-Pool the Client must
send a unique NAS-IP-Address:NAS-Port pair to the server, when doing the
*authentication*. There must also exist a Service-Type=3DFramed Attribute
in the Authentication Request.

I added this to ppp 2.4.1, to be able to receive a IP address from a
server side pool for a PPTP connection.

This is based on the patch:

http://www.xs4all.nl/~evbergen/radius-pppd.html

I simply added the NAS-Port which is the number of the ppp-interface=20

[...]
        addpair(&head, &tail, "NAS-Port", 0,rad_nasport(ifname),0);
[...]

rad_nasport simply cuts out the numeric value following ppp in the
interface name.


Handing out static Ips based on the clientname should work without
sending a unique NAS-IP-Address:NAS-Port pair in the authentication
process.

--=20
Torge Szczepanek <openvpn-devel@...239...>


