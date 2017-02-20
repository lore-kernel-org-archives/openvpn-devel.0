Date: Mon, 20 Feb 2017 14:03:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170220130341.GB93896@...1296...>
References: <20170125205302.23069-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="etg/Ry6vb8quy2uR"
Content-Disposition: inline
In-Reply-To: <20170125205302.23069-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Simple tool wihch automates
 rebasing LZ4 compat library
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--etg/Ry6vb8quy2uR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2017 at 09:53:02PM +0100, David Sommerseth wrote:
> This tool depends on a cloned upstream LZ4 git repository and a
> checked out release tag.  Then run the script like this:
>=20
>    $ ./dev-tools/lz4-rebaser.sh /path/to/lz4.git
>=20
> To see the result before committing, use: git diff --cached

All willing to give this an ACK, alas, it's penguin-tainted :-) - read,
won't work with a FreeBSD sed.

> +#ifdef NEED_COMPAT_LZ4
> +EOF
> +    sed '/"lz4\.h"/s/\(#include "\)lz4\.h\("\+\)/\1compat-lz4.h\2/' "$LZ=
4_C"
> +cat <<EOF

Not sure why this is not working here, but it looks like having too
much bells and whistles :-9 - I replaced this with

       sed 's/\"lz4\.h\"/\"compat-lz4.h"/' "$LZ4_C"

and ran it against a local copy of lz4 v131, and that produced the
expected result - no significant changes to compat-lz4.c/compat-lz4.h
(the "#ifdef HAVE_CONFIG_H" block moves to the top of the file, but=20
that is purely cosmetic - the block itself is fine)

So, any objections against the much simpler sed command there?  "lz4.h"
with double quotes never shows up elsewhere in the file today - and=20
when importing, we need to run a compile test anyway, so if it should
ever garble the .c file, we fix the script...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--etg/Ry6vb8quy2uR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYquktAAoJEB2Cnv7KVigScCsL/jz8VT0vpQxE4BUehO9/4bvW
6lF318y1eia4H6bJE0jHL70uCO7FE4PlfQrYlv+vOUCWaKW3Ua9Kq3Alts6lZ8H4
7vFjm9UVX/GDQdeyPAXYMP8nTX3Dvxd5JqHzV/A4xgw3DAW7L1pdR+/SQwITMW9Z
HbmMsURFJHhc1zpB4lkit8G0VPw4g4tqPFl8rOPqSNta5Scscgx1/r5qdo+eSDpC
gCR9+Ev/GW6C5JPt6X3djlOtVCmeKNvxR6CEsUrmpk/5mna7A1DoJ8br7F9dl5W7
jOLbj0gunMu1bBVoQv42vjePWo/HT9GqbAitt3vRL5dh80so7y9zZ1VxNn38fhnj
52sW1wZHuEsWo/chpmwfeb6vTiGJxjRJdUi7O5PyKdG+tt37NGLCgDlapnBR2chk
HBOhQI7RDZTGbNyWDsoWoHPLaQLZ7tJO0vajkHIkFB+yrcN2JC7Z/Qdss6J5XwBR
XVeoVxDcE5XKDf+nUxWGn5XyF4zjk27LWXvWxoWCfA==
=6qRj
-----END PGP SIGNATURE-----

--etg/Ry6vb8quy2uR--

