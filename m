Date: Sat, 24 Dec 2016 14:32:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161224133228.GO78624@...1296...>
References: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
	<1482532854-13699-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5kA4nwuSW3j1l9NB"
Content-Disposition: inline
In-Reply-To: <1482532854-13699-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] More broadly enforce Allman style
 and braces-around-conditionals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--5kA4nwuSW3j1l9NB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 23, 2016 at 11:40:54PM +0100, Steffan Karger wrote:
> This patch replaces the "Add nl_for_brace=3Dadd to uncrustify.conf" patch.
>=20
> v2: also add nl_do_brace=3Dadd and mod_full_brace_do=3Dadd
>=20
>  dev-tools/uncrustify.conf          |  8 +++++
[..]
> diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
> index 95e0b2a..d8ea870 100644
> --- a/dev-tools/uncrustify.conf
> +++ b/dev-tools/uncrustify.conf
> @@ -9,6 +9,11 @@ nl_brace_else=3Dadd
>  nl_elseif_brace=3Dadd
>  nl_else_brace=3Dadd
>  nl_else_if=3Dremove
> +nl_for_brace=3Dadd
> +nl_while_brace=3Dadd
> +nl_switch_brace=3Dadd
> +nl_fdef_brace=3Dadd
> +nl_do_brace=3Dadd
>  sp_func_proto_paren=3DRemove
>  sp_func_def_paren=3DRemove
>  sp_func_call_paren=3DRemove
> @@ -44,6 +49,9 @@ nl_after_func_proto=3D2
>  # Always use scoping braces for conditionals
>  mod_full_brace_if=3Dadd
>  mod_full_brace_if_chain=3Dfalse
> +mod_full_brace_while=3Dadd
> +mod_full_brace_for=3Dadd
> +mod_full_brace_do=3Dadd
>=20=20
>  # Annotate #else and #endif statements
>  mod_add_long_ifdef_endif_comment=3D20

Both the conceptual change / uncrustify.conf and the actual code changes
look reasonable and "fully according to how I interpret our CodingStyle
wiki".  So ACK.

As per the previous reformatting discussions, lets put this into master
and 2.4-after-2.4.0

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5kA4nwuSW3j1l9NB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYXnjsAAoJEB2Cnv7KVigSzsIMAKobouiqpZ2784NQTnR2RIFA
2UVlbJASGOkemoxZlFLWnmsENq7bOuCGjoG2MEnuAC44ynScI4qNYPsJDcQqdX9T
UfrodDzUEu+BjK2TrVT5sKXG+rKFPTUalRf6rlemoLmJKAjF0MNopRGw60n0no3d
+Mg4Jpw4IMgxPAp4DTH70k+9hEBObB1MT10JlSpY1iczW3n0T7ZsYCyHgjXo0Swk
AUxtvqqGtsEDEwYzO94ihIB/K6n4xBIfXKeDoZXQOu1wQ62TnIrWDS0Iu4eGzzdi
y50buWUAy8FcU4dpVN/0mXvXUzHSp19WAn+KGntYadbG1p6FC2Bbh/uwUas7hYh8
11wx2NsNniMkX9uos7Ppny8uVSWU+SG+YUxy83tOdcT4EFEVYHc9Ps/AH00WPjmU
aykhVPxeJbQzMNdHy9pXMvTCngdoBGXzTx7dPMosRt8YHVFaAzjtLMnxJUe/DsIS
b/SVfUeOBU+t0lm0DVArTrUtIrFZp5uRr+9zL4SPJQ==
=wwnl
-----END PGP SIGNATURE-----

--5kA4nwuSW3j1l9NB--

