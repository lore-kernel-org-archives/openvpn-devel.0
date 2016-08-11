From: David Sommerseth <openvpn@...2080...>
Message-ID: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
Date: Thu, 11 Aug 2016 20:50:22 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C51C54C3EB6D4264BF22A8A0"
Subject: [Openvpn-devel] autoconf/automake warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------C51C54C3EB6D4264BF22A8A0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

I noticed a few errors today when building OpenVPN on Fedora 23.  The
attached patch resolves this.  But it breaks 'make' when it reaches
./src/openvpnserv:

Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No
such file or directory

Except of that, the patch removes the warnings on Fedora 23 [1] and
causes no other issues on Scientific Linux 7.2 [2] or CentOS 5.11 [3].


And some comments to the patch.

* The subdir-objects option was needed to avoid a warning with
  automake-1.15.

* AM_PROG_CC_C_O is needed with automake-1.9.6 when the subdir-objects
  option is enabled.

* LT_INIT removes a warning on automake-1.15.


On a Fedora 23 setup without the attached patch you will see this:
- -------------------------------------------------------------------
libtoolize: Remember to add 'LT_INIT' to configure.ac.
src/openvpnserv/Makefile.am:32: warning: source file
'$(top_srcdir)/src/openvpn/block_dns.c' is in a subdirectory,
src/openvpnserv/Makefile.am:32: but option 'subdir-objects' is disabled
automake: warning: possible forward-incompatibility.
automake: At least a source file is in a subdirectory, but the
'subdir-objects'
automake: automake option hasn't been enabled.  For now, the
corresponding output
automake: object file(s) will be placed in the top-level directory.
However,
automake: this behaviour will change in future Automake versions: they
will
automake: unconditionally cause object files to be placed in the same
subdirectory
automake: of the corresponding sources.
automake: You are advised to start using 'subdir-objects' option
throughout your
automake: project, to avoid future incompatibilities.
tests/unit_tests/plugins/auth-pam/Makefile.am:10: warning: source file
'$(sut_sourcedir)/utils.c' is in a subdirectory,
tests/unit_tests/plugins/auth-pam/Makefile.am:10: but option
'subdir-objects' is disabled

- -------------------------------------------------------------------


I can see that commit 2282b1be7968ef44accde70 (by Selva Nair) is
adding cross subdir references in *_SOURCES, which requires
subdir-objects + AM_PROG_CC_C_O.

Can we fix this in a better way?


Some version info:

[1] Fedora 23:
    automake-1.15-4.fc23.noarch
    autoconf-2.69-21.fc23.noarch
    libtool-2.4.6-8.fc23.x86_64

[2] Scientific Linux 7.2
    automake-1.13.4-3.el7.noarch
    autoconf-2.69-11.el7.noarch
    libtool-2.4.2-21.el7_2.x86_64

[3] CentOS 5.11
    automake-1.9.6-3.el5
    autoconf-2.59-12
    libtool-1.5.22-7.el5_4



- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlesyO4ACgkQDC186MBRfrp1WwCfUnb0VW1dsP2SB2lm480AG/TM
m+QAnjHNyFJDmqOVTVBokroFx6AQ4SVw
=3DrRxR
-----END PGP SIGNATURE-----

--------------C51C54C3EB6D4264BF22A8A0
Content-Type: text/x-patch;
 name="wip-autotools-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="wip-autotools-fix.patch"

diff --git a/configure.ac b/configure.ac
index 4f14ebd..82c14b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,9 +55,11 @@ m4_define([serial_tests], [
                 awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D =
12) { print "serial-tests" }}'
     ])
 ])
-AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this param=
eter.
+AM_INIT_AUTOMAKE(foreign serial_tests subdir-objects) dnl NB: Do not [qu=
ote] this parameter.
+AM_PROG_CC_C_O
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
+LT_INIT
=20
 AC_ARG_ENABLE(
 	[lzo],

--------------C51C54C3EB6D4264BF22A8A0
Content-Type: application/pgp-signature;
 name="wip-autotools-fix.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="wip-autotools-fix.patch.sig"

iEYEABECAAYFAlesyO4ACgkQDC186MBRfrr3XgCeODg7mepK6ym6fkmGQlkWVJ7cqsQAn3x1
KK2FJfKj4A/5tPAynYKLBry2
--------------C51C54C3EB6D4264BF22A8A0--

