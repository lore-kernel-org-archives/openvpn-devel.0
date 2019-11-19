References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
 <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <78052b9a-0a3a-040d-c419-f48e9ef95a6e@...2080...>
Date: Tue, 19 Nov 2019 15:09:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Tx3VlbwKg8rXRAWNCsYAKYia7Zj0S7ITl"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tx3VlbwKg8rXRAWNCsYAKYia7Zj0S7ITl
Content-Type: multipart/mixed; boundary="T7xjgiK2rOxY0or5NYLeMcNziYqovgmHq";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <78052b9a-0a3a-040d-c419-f48e9ef95a6e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
 <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
In-Reply-To: <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>

--T7xjgiK2rOxY0or5NYLeMcNziYqovgmHq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 22:58, Selva Nair wrote:
> Hi David
>=20
> Thanks for the comments
>=20
>     My idea was just to add -Werror right in the line above, and not exte=
nd the
>     ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.
>=20
>=20
> I'm fine with that approach as well. Let me know if you want a v2.

Sorry for the delay responding.  I've done some pondering, and I have come =
to
the same conclusion as Arne, so this is a reasonable approach to add -Werro=
r.

That said, is there any specific reasons why adding the [-Werror] to
essentially all ACL_CHECK_ADD_COMPILE_FLAGS() calls?  Our ./configure script
is the only one implementing and supporting and using this macro, and it is
defined in configure.ac.

If there are no foreseeable reason for that now, I think it's just fine to
change the AC_COMPILE_IFELSE() call to use CFLAGS=3D"$1 -Werror $old_cflags=
".
Just add a comment in that area why we add the -Werror explicitly.  This ma=
kes
the whole change smaller and clearer.  If we need the flexibility later on,=
 we
can adjust this when that time arrives.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--T7xjgiK2rOxY0or5NYLeMcNziYqovgmHq--

--Tx3VlbwKg8rXRAWNCsYAKYia7Zj0S7ITl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd0/eQAAoJEIbPlEyWcf3y1awP/0MK+ZO+b3VJXMdEfdclmJ1I
8Ip+tT10GkK6VcVjQ6VOLsa6ir+fYL0eBsSEl6Jrm04yT1yPeYyu6YPTRsugo8+H
hVRr1Ki+gTWzsv57D1B6sRbsP5Kn7jJyZzr25EbZKOQkA8/R/Am3gE4l5N08MKNU
5ks+kZwutDECwdIO+uNP6T/XlxzClGHxgi+qyi9IrbFybJ6ioZE3sGwZ5PMDi+Wv
vX1Ov7Ed94rDxK1TIxDeabjKou0PkcyQvvsjvnfR3Ddn2LnjkeT9p40jksKsYh3T
2L1ScsOSwHfro2fqeqYzlAuSEkUw4XIiDHYTH2WR4NvhFzXGCj50mDnpo8eQBljM
4yihFL1qdlT7XXj5bJIkj2qD+BhnjJh0Dw0tmMbMwL86YU4tRv246QmouCHdVKu1
oax61Tf637ef3xXfE/CQTTuVlg/Q7rzXE5yYS2PHDN6WbTSxUdg0P3UoC5+88Iiw
bixP9Mynja+8s64ge2i5Ke+Y35V/tEYbMxUl5nJhRKUCRMTx9ZcBv1fFyovFNjMY
D35LHFeplSfiDFnava7+nl4i44giaTcPRfruOBNWSAwzGW09RfMe1cQw+yEHJ/Cq
nadYO8pI4x/tJg/BZ/qGBH3kPuca+gt8id01Tup9GCyzCtnd3IwLY7YQK2gqPap9
WjYZt2SjD3hHAZZdoDfZ
=mhI1
-----END PGP SIGNATURE-----

--Tx3VlbwKg8rXRAWNCsYAKYia7Zj0S7ITl--

