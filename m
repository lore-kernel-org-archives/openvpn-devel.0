Message-ID: <50F21EB9.4080401@...68...>
Date: Sun, 13 Jan 2013 03:40:57 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1357994477-29981-1-git-send-email-matthias.andree@...68...>
	<20130112201331.GH22465@...1296...>
In-Reply-To: <20130112201331.GH22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC062EA0A0106ED5768CCD775"
Subject: Re: [Openvpn-devel] [PATCH] Enable TCP_NODELAY configuration on
	FreeBSD.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC062EA0A0106ED5768CCD775
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 12.01.2013 21:13, schrieb Gert Doering:
> Hi,
>=20
> On Sat, Jan 12, 2013 at 01:41:17PM +0100, Matthias Andree wrote:
>> The missing #include <netinet/tcp.h> causes a defined(TCP_NODELAY) to
>> fail.  I have added the patch to the FreeBSD ports OpenVPN 2.2.2 and
>> 2.3.0, and confirmed (with strings ... | grep) that the TCP_NODELAY code
>> is now part of the executable on amd64, and results in this log output:
>>
>> Sat Jan 12 13:39:18 2013 Listening for incoming TCP connection on [undef]
>> Sat Jan 12 13:39:18 2013 Socket flags: TCP_NODELAY=3D1 succeeded
>>
>> Obtained from: https://community.openvpn.net/openvpn/ticket/158
>> Credits to: M. Nottebrock
>>
>> Signed-off-by: Matthias Andree <matthias.andree@...68...>
>=20
> ACK, "obviously logical" - needs a build test across all other platforms
> to check whether some obscure OS (like "Linux" or "Solaris" or "MinGW")
> chokes if that header is included now, but I don't expect issues.

No need for non-FreeBSD build tests, this is the wider context
- M. Nottebrock who added the patch to Trac had added the #include in
the "#ifdef TARGET_FREEBSD" section so it is invisible to other systems.

Other BSDs already include this header, I presume it was an oversight to
omit this from FreeBSD builds, once upon a time.

 #ifdef TARGET_FREEBSD

 #ifdef HAVE_SYS_UIO_H
 #include <sys/uio.h>
 #endif

 #ifdef HAVE_NETINET_IN_SYSTM_H
 #include <netinet/in_systm.h>
 #endif

 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif

+#ifdef HAVE_NETINET_TCP_H
+#include <netinet/tcp.h>
+#endif
+
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif

 #endif /* TARGET_FREEBSD */

> 2.3.1 and master, I'd say :-)

And 2.2.3 if that branch is still maintained.




--------------enigC062EA0A0106ED5768CCD775
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDyHr0ACgkQvmGDOQUufZW7pQCggIRnjqz0ODq858Ro5w0IRKdr
W1UAn1lz9xZ+SEODgn5V1NFJba13c0kS
=7O1I
-----END PGP SIGNATURE-----

--------------enigC062EA0A0106ED5768CCD775--

