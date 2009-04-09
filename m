Date: Wed, 08 Apr 2009 22:03:35 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...> <1239203062l.18482l.11l@...1207...>
	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
In-Reply-To: <9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
	(from alon.barlev@...277... on Wed Apr  8 17:46:46 2009)
Message-Id: <1239246215l.5600l.0l@...1207...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6AaDsiHCmrEz5ST/iAgR"
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, dave <dev@...575...>

--=-6AaDsiHCmrEz5ST/iAgR
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It occurs to me that if I want to do more than
beg I should submit a patch, so one is attached.

On 04/08/2009 05:46:46 PM, Alon Bar-Lev wrote:
> Available as part of OpenSC build [1].
>=20
> [1] http://www.opensc-project.org/build

I noticed that.  Does that build all of what
OpenVPN 2.1 packages for Windows, i.e. includes
OpenVPN GUI?  The project does not seem to release
binaries for OpenVPN GUI, which is a requirement
for me.

I was also a little put off by:
"The OpenVPN overlay is provided in order to solve OpenSSL version=20=20
incompatibility between OpenSC and OpenVPN projects."
How can I make sure that I've got what OpenVPN is releasing
so that I can go to OpenVPN for support?

The OpenVPN devs have a "built" source tree in which they run
install-win32/buildinstaller.  My point being that
if they would package it up
and release it alongside the resultant installer
none of these sorts of issues would ever come up.

Attached is a patch that produces a un-nsis-installer
windows binary release as part of the build process.

Apply it with:

cd openvpn
patch -p1 < buildbinaryrelease.patch

The result is a file named something like:
openvpn-2.1_rc15-winbinaries.tar.gz

I deliberately produce a tar.gz file
rather than a zip file to keep
Windows people from downloading it accidentally
instead of the Windows installer exe.

There is more work to be done.  The file needs to
be signed and put on the website every time there's
a release.  I don't see anything in svn to patch
that would aid this process.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

--=-6AaDsiHCmrEz5ST/iAgR
Content-Type: text/x-patch; charset=us-ascii; name=buildbinaryrelease.patch
Content-Disposition: attachment; filename=buildbinaryrelease.patch
Content-Transfer-Encoding: quoted-printable

diff -ruN openvpn-2.1_rc15/domake-win openvpn-2.1_rc15.patched/domake-win
--- openvpn-2.1_rc15/domake-win	2008-10-24 00:59:13.000000000 -0500
+++ openvpn-2.1_rc15.patched/domake-win	2009-04-08 20:59:10.000000000 -0500
@@ -133,6 +133,9 @@
 # Produce the license text, install README, and sample config files
 install-win32/maketext
=20
+# Produce a binary release, not wrapped in an installer.
+install-win32/buildbinaryrelease
+
 # This final step builds the OpenVPN installer using generated
 # files from GENOUT
 install-win32/buildinstaller
diff -ruN openvpn-2.1_rc15/install-win32/buildbinaryrelease openvpn-2.1_rc1=
5.patched/install-win32/buildbinaryrelease
--- openvpn-2.1_rc15/install-win32/buildbinaryrelease	1969-12-31 18:00:00.0=
00000000 -0600
+++ openvpn-2.1_rc15.patched/install-win32/buildbinaryrelease	2009-04-08 21=
:22:42.000000000 -0500
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+# load version.nsi definitions
+. autodefs/defs.sh
+
+# Make a name for the binary release dir.
+RELEASEDIR=3D"${PRODUCT_UNIX_NAME}-${PRODUCT_VERSION}${OUTFILE_LABEL}-winb=
inaries"
+
+# Copy the gen directory so it's got a good name
+cp -rp ${GENOUT} "${RELEASEDIR}"
+
+# Make the tarfile.
+tar -cf - "${RELEASEDIR}" | gzip -c > "${RELEASEDIR}.tar.gz"
+
+# Cleanup
+rm -rf "${RELEASEDIR}"


--=-6AaDsiHCmrEz5ST/iAgR--

