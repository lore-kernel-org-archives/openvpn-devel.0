References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
Date: Fri, 12 Aug 2016 12:30:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
Content-Type: multipart/mixed; boundary="------------6515BC9818DC83777A3408CC"
Subject: Re: [Openvpn-devel] autoconf/automake warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------6515BC9818DC83777A3408CC
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/08/16 03:14, Selva Nair wrote:
>=20
>=20
> On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>> wrote:
>=20
> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>=20
>=20
> Hi,
>=20
> I noticed a few errors today when building OpenVPN on Fedora 23.
> The attached patch resolves this.  But it breaks 'make' when it
> reaches ./src/openvpnserv:
>=20
>=20
> The patch is obviously useless as it breaks configuring.
>=20
>=20
>=20
> Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No=20
> such file or directory
>=20
>=20
> It is indeed caused by a bug in automake (bug#13928) because of
> which variables in foo_SOURCES do not get expanded when
> subdir-objects is specfied. Thus $(top_srcdir) in
> $(top_srcdir)/src/openvpn/block_dns.c, for example,  causes a
> folder literally named $(top_srcdir) created inside
> src/openvpnserv/. But make wont find any files there and leads to=20
> the missing file issues.

Just thinking a bit around this and avoiding code duplication.  This
might be a bit more hackish alternative, but bear with me :)

If the Makefile.am in src/openvpnsrv has a build-target for the
block_dns.c file which would just copy the source file to the
openvpnserv/ directory ... would that work?

Rough (not really tested) example is attached.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAletpUcACgkQDC186MBRfrrUjACcCfCMTD3Xp8LlFRiLhaBGjVU1
PtMAoI2VL2nBzYzk5krtIQQ38Q3dZSqC
=3Dhk2k
-----END PGP SIGNATURE-----

--------------6515BC9818DC83777A3408CC
Content-Type: text/x-patch;
 name="openserv-build-hack.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openserv-build-hack.patch"

diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 3c757d6..04a0dd4 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -29,11 +29,20 @@ openvpnserv_CFLAGS =3D \
 openvpnserv_LDADD =3D -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt=
4 -lshlwapi -lnetapi32 -lws2_32
 endif
=20
+CLEANFILES =3D block_dns.c block_dns.h
+.PHONY =3D block_dns.c block_dns.h
+BUILT_SOURCES =3D block_dns.c block_dns.h
+
+block_dns.c :
+	cp $(top_srcdir)/src/openvpn/block_dns.c .
+
+block_dns.h :
+	cp $(top_srcdir)/src/openvpn/block_dns.h .
+
 openvpnserv_SOURCES =3D \
         common.c \
 	automatic.c \
 	interactive.c \
 	service.c service.h \
 	validate.c validate.h \
-	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_d=
ns.h \
 	openvpnserv_resources.rc

--------------6515BC9818DC83777A3408CC
Content-Type: application/pgp-signature; name="openserv-build-hack.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openserv-build-hack.patch.sig"

iEYEABECAAYFAletpUcACgkQDC186MBRfroDKACfeigAoT1wta8cPfQn19VyifhtfBUAnRQY
NtbB8UPf85nzWPCTCJLHOaRy
--------------6515BC9818DC83777A3408CC--

