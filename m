References: <1472413323-21723-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
Date: Mon, 29 Aug 2016 22:45:52 +0200
MIME-Version: 1.0
In-Reply-To: <1472413323-21723-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/08/16 21:42, Steffan Karger wrote:
> Previously, we would use the compiler's default C version, which
> defaults to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for
> clang, but might even differ per distro.
>=20
> One of the reasons to accept the gnu89 default of GCC < 4.9, was
> that MSVC didn't support c99.  But in MSVC 2015, MS finanally fixed
> that.
>=20
> Having to support c89 in the codebase occasionally forces us to
> write less readable code, for example by forcing all declaration to
> be at the starting of a block (which includes 'for loop initial
> declarations').
>=20
> Let's be clear about what standard we obey, and stop punishing
> ourselves with c89/gnu89.  Let's switch the master branch to c99.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...> --- configure.ac
> | 1 + 1 file changed, 1 insertion(+)
>=20
> diff --git a/configure.ac b/configure.ac index 9189c94..16cab19
> 100644 --- a/configure.ac +++ b/configure.ac @@ -1125,6 +1125,7 @@
> if test "${enable_pkcs11}" =3D "yes"; then ) fi
>=20
> +CFLAGS=3D"${CFLAGS} -std=3Dc99" if test "${enable_pedantic}" =3D "yes";
> then enable_strict=3D"yes" CFLAGS=3D"${CFLAGS} -pedantic"
>=20

I so much wants to give this an ACK.  But this breaks CentOS 5 builds
very badly.  The glibc-headers isn't prepared for C99 on that distro.

I took the latest git master where I could do a successful build.
Then I applied just this patch, and here is the explosion:
<http://paste.fedoraproject.org/417049/14725031/>

To move towards C99, we need to add some tricks which makes this not
requiring users to overwrite C99 with C89.  That should happen
automatically.

Some CentOS 5.11 details:
glibc-2.5-123.el5_11.3
glibc-headers-2.5-123.el5_11.3
gcc-4.1.2-55.el5
openssl-0.9.8e-40.el5_11
lzo-2.02-2.el5.1


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxJ8AAAoJEIbPlEyWcf3y9/AP/2ArG2hclq5B48K7/c5pddg5
TC9QY2fgI/NoUGTTzOz7K3Pmzqo98pRAJPlItHZuQGnMsI4mUUoGz5AJxY31faSk
GqrXsJw87IMiPT1ZVSiUeNOLgA7drUHjQo9fe4uzZKfY+pIQcP09cOjWyyjPdiWm
1I4AqSuqawrva7cPVdIMQ/mxQA6SPFqCOF4y9wL2u6he1G7w9D3loomq5SP4zTQ9
wkarGmJ5x7bzLH/5C5Wl/s0yD0lWKG0FSaAelPw5+h4qxIXSMKhVNhapohJ7zUfX
YW+yVH5+pROAvGg/VgGdvdthPPqlodJSi4hIgkgRqtBnyhp+zzGjbvmCE2aL0DtN
XXx2FZppAbZzUgdvfCBjjElmtz0y4v2cewgTO/5f9Aumj/JDSpwbOgrCfSiwrqvh
OWsDPhnliYWacELUvEmK3M/tQHAfIVP307fy8ZgUtkwh/H4hLI+m7AaTOyzo7a73
PmcjtBVe1VLKBq1PDM9IORO7dAz7ApecuLoTe3BrhXF+lDe4DLaUxQhWHocl+Gwr
YhFPny4PyV7kAUNrsReZHxYC04cHvKxG4lh5LJg+jqXnF5obuRM6jBjPKdyo4HW5
qwyD6osMV9DK9BByQY8ClypufBa0ABVJYKUDtUgVl/Rl05mhsLJLlFi2AP4FQMcr
+5rF+M2E5JyR7mysH6cA
=3DVCb4
-----END PGP SIGNATURE-----

