Message-ID: <53F70E81.4050601@...1114...>
Date: Fri, 22 Aug 2014 11:33:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1408568426-19601-1-git-send-email-steffan@...1856...>
	<1408568426-19601-2-git-send-email-steffan@...1856...>
In-Reply-To: <1408568426-19601-2-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AXqsxxwHgvpTvNOgwghhIfVPjM1fBQ3su"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix clang warning in options.c
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AXqsxxwHgvpTvNOgwghhIfVPjM1fBQ3su
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/08/14 23:00, Steffan Karger wrote:
> fixed warning: expression which evaluates to zero treated as a
> null pointer constant of type 'struct addrinfo *'
>=20
> Seems to be innocent, but clang is correct that this is strange.
> init_tun() expects two pointers, but options_string() tried to
> feed it two uint32_t values.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f536daa..84eb6ed 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2934,8 +2934,8 @@ options_string (const struct options *o,
>  		     o->ifconfig_ipv6_local,
>  		     o->ifconfig_ipv6_netbits,
>  		     o->ifconfig_ipv6_remote,
> -		     (in_addr_t)0,
> -		     (in_addr_t)0,
> +		     NULL,
> +		     NULL,
>  		     false,
>  		     NULL);
>        if (tt)

ACK.


--=20
kind regards,

David Sommerseth


--AXqsxxwHgvpTvNOgwghhIfVPjM1fBQ3su
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlP3DoYACgkQDC186MBRfrreYACgsL+cDPI8ft22HZopkbjIFzfi
VqQAnjcJDLht8uwxNBh+4geB+H2bQIYj
=OGsz
-----END PGP SIGNATURE-----

--AXqsxxwHgvpTvNOgwghhIfVPjM1fBQ3su--

