Message-ID: <40B608B1.6080609@...164...>
From: Ian Pilcher <i.pilcher@...164...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809090301070108050609"
Subject: [Openvpn-devel] Add RPM build option to disable LZO
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May 27 08:27:01 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080809090301070108050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch to the OpenVPN 1.6.0 SPEC file adds a conditional
build option to disable the use of LZO compression.  LZO is not included
in Red Hat/Fedora Core, so this will make it easier for users of those
distributions to build a RPM without LZO support (if they don't want
it).

The package can be built with 'rpmbuild -tb --without lzo ...".

-- 
========================================================================
Ian Pilcher                                        i.pilcher@...164...
========================================================================

--------------080809090301070108050609
Content-Type: text/x-patch;
 name="openvpn-lzo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-lzo.patch"

--- openvpn.spec-orig	2004-05-27 10:04:09.561878264 -0500
+++ openvpn.spec	2004-05-27 10:15:37.344319440 -0500
@@ -11,6 +11,9 @@
 Packager:	bishop clark (LC957) <bishop@...7...>
 BuildRoot:	%{_tmppath}/%{name}-%(id -un)
 
+%{!?_without_lzo:BuildRequires: lzo-devel}
+%{!?_without_lzo:Requires:   	lzo}
+
 %description
 OpenVPN is a robust and highly flexible tunneling application that
 uses all of the encryption, authentication, and certification features
@@ -24,7 +27,7 @@
 %setup -q
 
 %build
-%configure --enable-pthread
+%configure --enable-pthread %{?_without_lzo:--disable-lzo}
 %__make
 
 %install

--------------080809090301070108050609--

