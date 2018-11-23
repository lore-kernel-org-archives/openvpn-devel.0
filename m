References: <1541757573-30178-1-git-send-email-lstipakov@...277...>
 <201811210934.wAL9YhYM092344@...2054...>
Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a5e41421-e2ce-3062-5164-30ba8494b110@...2080...>
Date: Fri, 23 Nov 2018 01:46:04 +0100
MIME-Version: 1.0
In-Reply-To: <201811210934.wAL9YhYM092344@...2054...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="V5nzrlJNhmHMzYkJDz6vwbG5Nt1XOALJO"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove extra token after
 #endif
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V5nzrlJNhmHMzYkJDz6vwbG5Nt1XOALJO
Content-Type: multipart/mixed; boundary="JGtmWTDhfhXFGGCu5Aw8bzn3qigZpUjdH";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <a5e41421-e2ce-3062-5164-30ba8494b110@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove extra token after
 #endif
References: <1541757573-30178-1-git-send-email-lstipakov@...277...>
 <201811210934.wAL9YhYM092344@...2054...>
In-Reply-To: <201811210934.wAL9YhYM092344@...2054...>

--JGtmWTDhfhXFGGCu5Aw8bzn3qigZpUjdH
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/11/2018 10:34, Gert Doering wrote:
>=20
> Regarding Christian's comment about "#endif" vs. "#endif /* ENABLE_CRYPTO=
 /*"
> - well, we have both in our tree, so neither is "correct" or "wrong".
>=20
> For such a short #ifdef/#endif span, I'd see it as optional because the
> corresponding #ifdef is easily spotted.  For something spanning more
> code, possibly nested #ifdef, a comment after the #endif would definitely
> be better, though.

Just FTR; I share this point of view.  We've not been too picky about these
#endif remarks in the past but something we saw more of after the big
reformatting commit right before the v2.4.0 release.

We used these uncrustify settings for the great reformatting patch:

-------------------
# Annotate #else and #endif statements
mod_add_long_ifdef_endif_comment=3D20
mod_add_long_ifdef_else_comment=3D5
-------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--JGtmWTDhfhXFGGCu5Aw8bzn3qigZpUjdH--

--V5nzrlJNhmHMzYkJDz6vwbG5Nt1XOALJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb903SAAoJEIbPlEyWcf3yOqQP/RsyVsCovoKdy4gP70Uu3DgD
hCtjJc1Lsq07PuAR5V/VRbmhQZKdsWK+X3RQm/MFdyss1EbmRrnhJibLx2kMX2Zy
lQ9/jMOkUC18gRvzdk1c8Y+Nx+8PhJbOPrBEHKsIyPxrnci1p0beDZxYKsdAgJf/
P0x6h80yYqZMsugsbMNffbplCDyWyfJHjpi1/Uw79bLzKgHhxWVb4R+QhGYYFbaa
xYROt83tGy7ez/SzuOWh85s/UtHr3yit3dhS/fHv+osrPZP3bDOyU+CnNjCJdULs
PrsGlcYnASeWOH7k3afm5v9BXk5Ck7bH4TQUWomz5a8CiHwF81lcVgrx2cqH4jl2
KdDS0s987dL+E/r/QQXrLox+3uvoqKVwQdEt+rP3wE5yWXUN/mz0Dv36X+cPQhd9
BRfONXfyNTbzzVdje52XKE2zpPWIzhSj2yKiWGZpHXjLjr4nsElVBTpuqaVoZWNW
sIFWhMDFPf38COTE9cSfhyqPdC9Z/FhgMr6z2p4Hff+bnIA0WNn7xuJ7n200hcu3
72+L+dGUaVHjm/IiIGd44Vlkp2lsUf79TKBwYGpWTHDrTvcBMFRN4zoMVSFbA5+E
oEEdSmqboILmMy2TFnLi74qF63e/ADOGDy3KbGajANmaQITzFfdYQIqbG/mdJi71
uR3CaT+dwCriL3r2oaGJ
=1MDF
-----END PGP SIGNATURE-----

--V5nzrlJNhmHMzYkJDz6vwbG5Nt1XOALJO--

