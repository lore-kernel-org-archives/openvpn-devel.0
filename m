References: <1612163389-16421-1-git-send-email-gcox@...1057...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b5091ca3-f275-dc22-2518-3ff316455795@...2080...>
Date: Wed, 3 Feb 2021 11:15:08 +0100
MIME-Version: 1.0
In-Reply-To: <1612163389-16421-1-git-send-email-gcox@...1057...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J2TrDDC38Xqcic4NkuFvqc7UfinKUiT2D"
Subject: Re: [Openvpn-devel] Explain structvar usage in sample defer plugin.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J2TrDDC38Xqcic4NkuFvqc7UfinKUiT2D
Content-Type: multipart/mixed; boundary="k4oiexoEJIVDsx1sS5BYMwfD0NXghXn6Z";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <b5091ca3-f275-dc22-2518-3ff316455795@...2080...>
Subject: Re: [Openvpn-devel] Explain structvar usage in sample defer plugin.
References: <1612163389-16421-1-git-send-email-gcox@...1057...>
In-Reply-To: <1612163389-16421-1-git-send-email-gcox@...1057...>

--k4oiexoEJIVDsx1sS5BYMwfD0NXghXn6Z
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01/02/2021 08:09, Greg Cox wrote:
> sample-plugins/defer/simple.c uses OPENVPN_PLUGINv3_STRUCTVER settings
> that may not be obvious to a new author.  Add a comment to reduce
> possible confusion.
> ---
>   sample/sample-plugins/defer/simple.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins=
/defer/simple.c
> index 05bfc4efa6d85bb1696b6811428260f4cc5e9914..6f08bedd6319827c05786303f=
8a4007791042208 100644
> --- a/sample/sample-plugins/defer/simple.c
> +++ b/sample/sample-plugins/defer/simple.c
> @@ -69,12 +69,18 @@ static plugin_log_t plugin_log =3D NULL;
>    * Constants indicating minimum API and struct versions by the functions
>    * in this plugin.  Consult openvpn-plugin.h, look for:
>    * OPENVPN_PLUGIN_VERSION and OPENVPN_PLUGINv3_STRUCTVER
> + *
> + * Strictly speaking, this sample code only requires plugin_log, a featu=
re
> + * of structver version 1.  However, '1' lines up with ancient versions
> + * of openvpn that are past end-of-support.  As such, we are requiring
> + * structver '5' here to indicate a desire for modern openvpn, rather
> + * than a need for any particular feature found in structver beyond '1'.
>    */
>   #define OPENVPN_PLUGIN_VERSION_MIN 3
>   #define OPENVPN_PLUGIN_STRUCTVER_MIN 5
>=20=20=20
>   /*
> -* Our context, where we keep our state.
> + * Our context, where we keep our state.
>    */
>=20=20=20
>   struct plugin_context {
> @@ -160,7 +166,6 @@ openvpn_plugin_open_v3(const int v3structver,
>       const char **envp =3D args->envp;       /* environment variables */
>       struct plugin_context *context;
>=20=20=20
> -    /* Check API compatibility -- struct version 5 or higher needed */
>       if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
>       {
>           fprintf(stderr, "%s: this plugin is incompatible with the runni=
ng version of OpenVPN\n", MODULE);
> @@ -442,7 +447,6 @@ openvpn_plugin_func_v3(const int v3structver,
>                          struct openvpn_plugin_args_func_in const *args,
>                          struct openvpn_plugin_args_func_return *ret)
>   {
> -    /* Check API compatibility -- struct version 5 or higher needed */
>       if (v3structver < OPENVPN_PLUGIN_STRUCTVER_MIN)
>       {
>           fprintf(stderr, "%s: this plugin is incompatible with the runni=
ng version of OpenVPN\n", MODULE);
>=20

Thanks again!  Since this is purely comment fixes, I've only glared at=20
these changes, and they look good.

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--k4oiexoEJIVDsx1sS5BYMwfD0NXghXn6Z--

--J2TrDDC38Xqcic4NkuFvqc7UfinKUiT2D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAad6wACgkQhs+UTJZx
/fIIaw//RdAocdhJ+jx7rmqvX3vU+aD4uCJp1CH/KmB91/jLR2UYpH4IdtXtOI92
zb9t/IhgCQue6TXH0Vcx1j9RED5z6OIWl5/mjnp0eTyp0SbDcCtdaxfXUFdybxa9
f3k7AMJruWEUoSK0hlUkjuY7Yme15imaps9aExkCH6Ikgokjvq8SGL6r2+IgD47m
MX/MIa9O/CkTlSwt6HEI6OeWIW48N5HgiDmcS1w/37VnskDdq2g+xy33Pe4qXBaK
LupF+VTYPu628cqERV3lnk3sUbVchCmRKPLeLUyv1SQ5Ytv70LSZOL4FJjwYyp4c
IXOZ7RrbCQJmKRmcagbAq3wAAGc7AGQ1O1H5C/qjLDnXBwalvfZ8zFBGDtftojhX
Lndovrqgbm+WLgmYuH17MgIVrlUPUT24G4oYj8I1kuyGX3KTToW1D+x43VAhoi7n
CZzaaQLUOr2eYmCBcl6vPAyN9dVkQHPDiXl3MCDxlPNADE0d5S/5BClP5GkuO4Wb
wNKGU381bgOpAQ77HD5ZEimcgdwNUug/Dk5YvQx+NRrZrld3O5MdWQ1rNzD5x7T5
y7yl8a0PDKKwt9xL0hSss+bursAp7CRzcv71uo7bnb5MRGwskmm8g/cpqEelokqj
C4b9wFrxnrUg13B2BffEMKCe+/2VGGojvJbfhn/xlPY4b8ZAHpU=
=qqoN
-----END PGP SIGNATURE-----

--J2TrDDC38Xqcic4NkuFvqc7UfinKUiT2D--

