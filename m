Message-ID: <4F4E7BEE.50700@...1114...>
Date: Wed, 29 Feb 2012 20:26:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
In-Reply-To: <1957833067.20120229194040@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/02/12 19:40, Carsten Kr=FCger wrote:
>=20
> I think it would be good to rethink the hole script idea. Maybe
> scripts could be only server pushable.

How will you handle that some users use OpenVPN from Windows, Linux and
maybe even a mobile phone (like N900)? ... where paths are different,
depending on OS and/or distribution.  And some paths on Linux (probably
*BSD too?) are different if it is a 32bit architecture or 64bit.

I doubt it will be highly appreciated that sys-admins need to maintain
separate script profiles on the server side, for each OS/platform connectin=
g.

And you would also need to go even further, to also make --plugin only
pushable too.  Which makes the /usr/lib vs /usr/lib64 scenario a real
pain for sure.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Oe+sACgkQDC186MBRfroz1ACfQmJ94a+cMUQFExps9a7+x7AB
WGgAoJ6NT1feO/k4kiTj7Id7jUdo5ZLZ
=3DFvPe
-----END PGP SIGNATURE-----

