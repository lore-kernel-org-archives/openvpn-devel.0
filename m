Message-ID: <55619DC4.2020108@...1856...>
Date: Sun, 24 May 2015 11:45:40 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060703050806040504010909"
Subject: [Openvpn-devel] [PATCH] Clarify --capath option in manpage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060703050806040504010909
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Prevent confusion as described in trac #422 by better explaining the 
behaviour of --capath, and providing pointers to relevant openssl man pages.

Attached are patches for the master and release/2.3 branches.  The only 
difference is that in the master patch, a line referencing the 
requirement for OpenSSL 0.9.7 is removed, since master already requires 
OpenSSL >= 0.9.8.

-Steffan

--------------060703050806040504010909
Content-Type: text/x-patch; name="2.3-Clarify-capath-option-in-manpage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.3-Clarify-capath-option-in-manpage.patch"

From 96e564e113cc26adf22e5d4b51d5754858610c3e Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 24 May 2015 11:20:11 +0200
Subject: [PATCH] Clarify --capath option in manpage

Prevent confusion as described in trac #422 by better explaining the
behaviour of --capath, and providing pointers to relevant openssl man
pages.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3263c82..3924aa9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4209,6 +4209,22 @@ they are distributed with OpenVPN, they are totally insecure.
 Directory containing trusted certificates (CAs and CRLs).
 Available with OpenSSL version >= 0.9.7 dev.
 Not available with PolarSSL.
+
+When using the
+.B \-\-capath
+option, you are required to supply valid CRLs for the CAs too.  CAs in the
+capath directory are expected to be named <hash>.<n>.  CRLs are expected to
+be named <hash>.r<n>.  See the
+.B -CApath
+option of
+.B openssl verify
+, and the
+.B -hash
+option of
+.B openssl x509
+and
+.B openssl crl
+for more information.
 .\"*********************************************************
 .TP
 .B \-\-dh file
-- 
2.1.4


--------------060703050806040504010909
Content-Type: text/x-patch;
	name="master-Clarify-capath-option-in-manpage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="master-Clarify-capath-option-in-manpage.patch"

From 3626088e146dbf959d7ec73f4e7cc5ab24c1ad57 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 24 May 2015 11:18:34 +0200
Subject: [PATCH] Clarify --capath option in manpage

Prevent confusion as described in trac #422 by better explaining the
behaviour of --capath, and providing pointers to relevant openssl man
pages.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e1e0af2..6d17ef3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4263,8 +4263,23 @@ they are distributed with OpenVPN, they are totally insecure.
 .TP
 .B \-\-capath dir
 Directory containing trusted certificates (CAs and CRLs).
-Available with OpenSSL version >= 0.9.7 dev.
 Not available with PolarSSL.
+
+When using the
+.B \-\-capath
+option, you are required to supply valid CRLs for the CAs too.  CAs in the
+capath directory are expected to be named <hash>.<n>.  CRLs are expected to
+be named <hash>.r<n>.  See the
+.B -CApath
+option of
+.B openssl verify
+, and the
+.B -hash
+option of
+.B openssl x509
+and
+.B openssl crl
+for more information.
 .\"*********************************************************
 .TP
 .B \-\-dh file
-- 
2.1.4


--------------060703050806040504010909--

