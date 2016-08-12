References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b80eb9b2-1ce0-1f9d-7b76-a877087e10fe@...2080...>
Date: Fri, 12 Aug 2016 20:24:35 +0200
MIME-Version: 1.0
In-Reply-To: <1451911424-12970-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/01/16 13:43, Lev Stipakov wrote:
> v2: better method naming
>=20
> On certain OSes (Windows, OS X) when network adapter is disabled
> (ethernet cable pulled off, Wi-Fi hardware switch disabled),=20
> operating system starts to use tun as an external interface.=20
> Outgoing packets are routed to tun, UDP encapsulated, given to=20
> routing table and sent to.. tun.

Can this happen on Linux or *BSD?  Could this recursive routing
actually happen at all?

[...snip...]

> + +      /* skip ipv4 packets for ipv6 tun */ +      if
> (tun_sa.addr.sa.sa_family !=3D AF_INET) +	   return;

[...snip...]

> + +      /* skip ipv6 packets for ipv4 tun */ +      if
> (tun_sa.addr.sa.sa_family !=3D AF_INET6) +	  return;

How likely is it that these two checks will hit?  Do we truly need
them?  I'm basically concerned of the potential cost an extra check
adds.  As the link speed increases, such checks will have an impact
later on if now.  If truly needed, is it worth looking into providing
some branch prediction hints to the compiler?  (unlikely/likely hints)

> if (c->c2.buf.len > 0) { +      drop_if_recursive_routing (c,
> &c->c2.buf);

If this is truly only an issue on Windows and OSX, can we consider to
#ifdef the drop_if_recursive_routing() call?


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAleuFGMACgkQDC186MBRfrphqACcCJ7UNTcaFM79njJ1HXFpw7hX
NbcAn2MgNCVh1joOOKhPo46dJ+5GAGdq
=3DxaHi
-----END PGP SIGNATURE-----

