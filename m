Message-ID: <51B1E530.2030709@...1114...>
Date: Fri, 07 Jun 2013 15:50:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51B1DBEF.1090705@...1435...>
In-Reply-To: <51B1DBEF.1090705@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2KWUEMWMUGXASPOQBUPWI"
Subject: Re: [Openvpn-devel] [PATCH] Do not pass struct tls_session* as void*
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KWUEMWMUGXASPOQBUPWI
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/06/13 15:11, Steffan Karger wrote:
> Hi,
>=20
> The attached patch changes the key_state_ssl_init() function to take the
> TLS session as a 'struct tls_session *', instead of a 'void *' that has
> to be cast back later. This patch prepares for a patch from Tamas Tevesz
> that actually uses the TLS session inside key_state_ssl_init().
>=20
> -Steffan

Applied to master and pushed out.

commit b97e2c3c90afdbb1a24bc1357ec6b94d626defcd
Author: Steffan Karger <steffan.karger@...1435...>
Date:   Sun May 19 10:01:29 2013 +0200

    Do not pass struct tls_session* as void* in key_state_ssl_init().

    Signed-off-by: Steffan Karger <steffan.karger@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 51B1DBEF.1090705@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7664
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


------enig2KWUEMWMUGXASPOQBUPWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGx5TAACgkQDC186MBRfroooACdGM8beQI8v2HtRLHbuNBwN9bl
8eUAniDcLPSQywmf1f9AF4extH5+WMkQ
=c/hh
-----END PGP SIGNATURE-----

------enig2KWUEMWMUGXASPOQBUPWI--

