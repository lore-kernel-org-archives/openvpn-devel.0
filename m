Message-ID: <4B8A614A.4020406@...1114...>
Date: Sun, 28 Feb 2010 13:27:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1239166995l.18482l.9l@...1207...>	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
	<1239203062l.18482l.11l@...1207...>	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
	<1239246215l.5600l.0l@...1207...>
In-Reply-To: <1239246215l.5600l.0l@...1207...>
Content-Type: multipart/mixed; boundary="------------000601050201000300060704"
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000601050201000300060704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/04/09 05:03, Karl O. Pinc wrote:
> It occurs to me that if I want to do more than
> beg I should submit a patch, so one is attached.
> 
> On 04/08/2009 05:46:46 PM, Alon Bar-Lev wrote:
>> Available as part of OpenSC build [1].
>>
>> [1] http://www.opensc-project.org/build
> 
> I noticed that.  Does that build all of what
> OpenVPN 2.1 packages for Windows, i.e. includes
> OpenVPN GUI?  The project does not seem to release
> binaries for OpenVPN GUI, which is a requirement
> for me.
> 
> I was also a little put off by:
> "The OpenVPN overlay is provided in order to solve OpenSSL version
> incompatibility between OpenSC and OpenVPN projects."
> How can I make sure that I've got what OpenVPN is releasing
> so that I can go to OpenVPN for support?
> 
> The OpenVPN devs have a "built" source tree in which they run
> install-win32/buildinstaller.  My point being that
> if they would package it up
> and release it alongside the resultant installer
> none of these sorts of issues would ever come up.
> 
> Attached is a patch that produces a un-nsis-installer
> windows binary release as part of the build process.
> 
> Apply it with:
> 
> cd openvpn
> patch -p1 < buildbinaryrelease.patch
> 
> The result is a file named something like:
> openvpn-2.1_rc15-winbinaries.tar.gz
> 
> I deliberately produce a tar.gz file
> rather than a zip file to keep
> Windows people from downloading it accidentally
> instead of the Windows installer exe.
> 
> There is more work to be done.  The file needs to
> be signed and put on the website every time there's
> a release.  I don't see anything in svn to patch
> that would aid this process.

Hi!

I'm going through the mailing list, picking up patches which seems not
to be included.  Is this patch still interesting to get included?  This
one applies cleanly to the master branch.

I see that this patch is also followed by this one:

<http://article.gmane.org/gmane.network.openvpn.devel/2581>

This patch do not apply at all, as the standard checked out tree do not
have INSTALL-win32.html, only INSTALL-win32.txt.  Is this correct?  I
can't find this HTML file in the 2.1_rc15 nor 2.1_rc16, which was
current when this patch was sent to the mailing list.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuKYUoACgkQDC186MBRfrpVrACfWBX1kNPygMHKHea8gdSLeP+8
bVUAnj5G6Jo+WFW6ds74mi5h+S+fEnO4
=r1ZL
-----END PGP SIGNATURE-----

--------------000601050201000300060704
Content-Type: text/x-patch;
 name="buildbinaryrelease.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="buildbinaryrelease.patch"

diff -ruN openvpn-2.1_rc15/domake-win openvpn-2.1_rc15.patched/domake-win
--- openvpn-2.1_rc15/domake-win	2008-10-24 00:59:13.000000000 -0500
+++ openvpn-2.1_rc15.patched/domake-win	2009-04-08 20:59:10.000000000 -0500
@@ -133,6 +133,9 @@
 # Produce the license text, install README, and sample config files
 install-win32/maketext
 
+# Produce a binary release, not wrapped in an installer.
+install-win32/buildbinaryrelease
+
 # This final step builds the OpenVPN installer using generated
 # files from GENOUT
 install-win32/buildinstaller
diff -ruN openvpn-2.1_rc15/install-win32/buildbinaryrelease openvpn-2.1_rc15.patched/install-win32/buildbinaryrelease
--- openvpn-2.1_rc15/install-win32/buildbinaryrelease	1969-12-31 18:00:00.000000000 -0600
+++ openvpn-2.1_rc15.patched/install-win32/buildbinaryrelease	2009-04-08 21:22:42.000000000 -0500
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+# load version.nsi definitions
+. autodefs/defs.sh
+
+# Make a name for the binary release dir.
+RELEASEDIR="${PRODUCT_UNIX_NAME}-${PRODUCT_VERSION}${OUTFILE_LABEL}-winbinaries"
+
+# Copy the gen directory so it's got a good name
+cp -rp ${GENOUT} "${RELEASEDIR}"
+
+# Make the tarfile.
+tar -cf - "${RELEASEDIR}" | gzip -c > "${RELEASEDIR}.tar.gz"
+
+# Cleanup
+rm -rf "${RELEASEDIR}"


--------------000601050201000300060704--

