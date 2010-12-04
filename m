Date: Sat, 4 Dec 2010 03:55:33 +0100
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <20101204025529.GA3200@...33...>
References: <4CF90B25.3010104@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <4CF90B25.3010104@...515...>
Subject: Re: [Openvpn-devel] Error C2010 in openvpnserv.c during VS2008 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NDin8bjvE/0mNLFQ
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am 03.12.2010 16:22, schrieb Samuli Sepp=E4nen:
> Hi,
>=20
> I've managed to extend the Python build system so that it now tries to
> build the Windows service wrapper, "openvpnserv.exe", after building
> "openvpn.exe". However, the Visual Studio 2008 C compiler gives these
> errors:
>=20
>    openvpnserv.c(87): error C2010: '.' : unexpected in macro formal
> parameter list
>    openvpnserv.c(101): error C2010: '.' : unexpected in macro formal
> parameter list
>=20
> The offending lines with context (in beta2.2 branch) are these:
>=20
>    #define mysnprintf(out, args...) \
>    ...
>    #define MSG(flags, args...) \
>=20
> The C2010 error is described (very briefly) here:
>=20
> <http://msdn.microsoft.com/en-us/library/64sxk83h.aspx>
>=20
> Any ideas how to fix this issue?

Hi Samuli,

What you see in the offending lines is GCC's old syntax for variadic macros=
.  If
Visual Studio 2008 understands C99 sufficiently, you could #ifdef around th=
is
and use the current form in the code for GCC compilers, and the C99 form fo=
r others.

See http://gcc.gnu.org/onlinedocs/gcc/Variadic-Macros.html#Variadic-Macros =
for
an explanation.

Please try the attached patch - note I haven't been able to test this beyond
making sure it compiles on GCC 4.3.

HTH.

Best regards
Matthias

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-diff; charset=us-ascii;
	name="0001-Change-variadic-macros-to-C99-style.patch"
Content-Disposition: attachment;
	filename="0001-Change-variadic-macros-to-C99-style.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c54a7fa98f4c8d567c26ce3bd6d80f3a68173bd8 Mon Sep 17 00:00:00 2001
=46rom: Matthias Andree <matthias.andree@...68...>
Date: Sat, 4 Dec 2010 03:51:11 +0100
Subject: [PATCH] Change variadic macros to C99 style.

Breaks compatibility with GCC versions before 3.0, in an attempt to
fix compilation on Visual Studio 2008. Compiles on GCC 4.3, but untested
on Visual Studio 2008.
---
 service-win32/openvpnserv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/service-win32/openvpnserv.c b/service-win32/openvpnserv.c
index 6c9ff1e..07374e2 100755
--- a/service-win32/openvpnserv.c
+++ b/service-win32/openvpnserv.c
@@ -84,9 +84,9 @@ static HANDLE exit_event =3D NULL;
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
=20
 /* snprintf with guaranteed null termination */
-#define mysnprintf(out, args...) \
+#define mysnprintf(out, ...) \
         { \
-           snprintf (out, sizeof(out), args); \
+           snprintf (out, sizeof(out), __VA_ARGS__); \
            out [sizeof (out) - 1] =3D '\0'; \
         }
=20
@@ -98,10 +98,10 @@ static HANDLE exit_event =3D NULL;
 #define M_ERR     (MSG_FLAGS_ERROR)                    // error
=20
 /* write error to event log */
-#define MSG(flags, args...) \
+#define MSG(flags, ...) \
         { \
            char x_msg[256]; \
-           mysnprintf (x_msg, args); \
+           mysnprintf (x_msg, __VA_ARGS__); \
            AddToMessageLog ((flags), x_msg); \
         }
=20
--=20
1.7.3.2.438.g94fdb6


--4Ckj6UjgE2iN1+kY--

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkz5raEACgkQvmGDOQUufZU2GgCgyTCMs7LsonOszMa+ydrOJWcR
JeAAoJD21ScFQoZ1N4SyLWq2hiW7QpLd
=C7eg
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

