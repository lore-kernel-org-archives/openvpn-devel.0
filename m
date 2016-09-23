References: <1474573258-25420-1-git-send-email-davids@...515...>
	<1474573258-25420-2-git-send-email-davids@...515...>
	<CAKuzo_iHjBzeEELJoGwpR_V8_tHdL9WMpVjxNiPPC1FMCvPQEw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5fc699ce-d7ea-304c-5e61-4c5dc846dc98@...2080...>
Date: Fri, 23 Sep 2016 10:42:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iHjBzeEELJoGwpR_V8_tHdL9WMpVjxNiPPC1FMCvPQEw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove static global allocation of HTTP
 proxy user/passwords
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
To: Selva Nair <selva.nair@...277...>, David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/09/16 22:51, Selva Nair wrote:
> Hi,
>=20
> On Thu, Sep 22, 2016 at 3:40 PM, David Sommerseth
> <davids@...515... <mailto:davids@...515...>> wrote:
>=20
> This avoids allocating static memory which is not used unless the a
> HTTP proxy with authentication is configured.
>=20
>=20
> .....
>=20
> The only place the original code referred to the global=20
> static_proxy_user_pass appears to be in this function and from its
> usage it appears redundant.
>=20
> static void get_user_pass_http (struct http_proxy_info *p, const
> bool force) { -  if (!static_proxy_user_pass.defined || force) +
> if (!proxy_user_pass_cache || !proxy_user_pass_cache->defined||=20
> force) { unsigned int flags =3D GET_USER_PASS_MANAGEMENT; + +      if
> (!proxy_user_pass_cache) +        { +          ALLOC_OBJ_CLEAR
> (proxy_user_pass_cache, struct user_pass); +        } +      else +
> { +          CLEAR (*proxy_user_pass_cache); +        } + if
> (p->queried_creds) flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED; if
> (p->options.inline_creds) flags |=3D GET_USER_PASS_INLINE_CREDS; -
> get_user_pass (&static_proxy_user_pass, +      get_user_pass
> (proxy_user_pass_cache, p->options.auth_file, UP_TYPE_PROXY,=20
> flags); p->queried_creds =3D true; -      p->up =3D
> static_proxy_user_pass;
>=20
>=20
> A copy of the struct is made only when a new password is obtained
> using get_user_pass. Then, what was the purpose of the static? Or
> was it a bug that the copy of the cached password was not made
> every time this function was called? If not, we can just delete the
> static and use p->up directly.
>=20
> } +  p->up =3D proxy_user_pass_cache; }

I completely agree!  I did consider this too, but figured I needed to
understand better what happens if a client uses connection blocks and
if the caching of username/password goes across these connection blocks.

If you have --http-proxy configured which requires authentication and
 two connection blocks.  By removing the caching, I worry that OpenVPN
would ask for a new proxy username/password each time it tries a
different connection block.

I haven't had enough time to dig into this scenario, but if that is
not the issue then I don't see any point in keeping this cache.  But
it is hard to get a complete overview where each of these
configuration structs are unique and singular and where they are
re-used and all points at the same "object".

But I'm happy to see more spotting the same issue.  And I'm always
thankful for your thorough reviews, Selva!


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX5OrxAAoJEIbPlEyWcf3yULsP/RuL/+qm3svPCyatylCIupC5
cAXb480V+gyw+acE0IJMYGwQ7tQ7mjNKVDhV+BP5nSROX+Kgc5VPy/sHULkuNDLM
NKw4pa0X53PGPIiGSGMryphheFb22hiBVi0RPzGRC453IRSQSasKXuRMur+3Jlkf
J9T6i/WlrOD2c1VROGPY7PXjHXZct7+P42rERxWaJTTQ6KA+yS6Nzx+EZw/v9EO4
dnZhORPkq6IBu+cZ7JshhA6S2wY0CUDVZ0wSIFG2KcrJi/JjP5GkeTS+74RVbL3V
+OPcGBdlHC08wDCQpRdKsAAv7M/GmdR2sQJKoPlhT7JTkLr87LC1vV+e5tx3FonN
n45jB1bVV0VZ0Bo+lVG+4j3eyNaN/hhdMLHsQDdxQ9n1v7ajGFYf29K+nxsymb4V
GFMw45LHitHkCQfmptOjRMkmoRQE2tOjniiUyLWj1a9uEJwesPfHBpa1qYP9LprQ
rqUbscDiH5VPATUzAlv7O1UMo7mJVQdkYd9y9X9ayc+8uY5uARqf/sPoga8QGRcD
0v7/CvrXCKhVDYpIV2UWgstJ2aw2Rmv3voKC8rNlchIK5ivHly7PO0Hh4KjW2qXO
ZnW1kvYhThw0nz/W63v6QHZa/JY+p4BiybTS3mANAwvy4uzYlZugG7oq/DpFj+5/
eYH5gDWPMtJxACZzlfM5
=3DNdg9
-----END PGP SIGNATURE-----

