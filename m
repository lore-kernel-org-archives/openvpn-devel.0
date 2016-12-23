From: David Sommerseth <davids@...515...>
Date: Fri, 23 Dec 2016 17:07:44 +0100
Message-Id: <1482509264-24550-1-git-send-email-davids@...515...>
In-Reply-To: <1482353691-27088-3-git-send-email-davids@...515...>
References: <1482353691-27088-3-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH master+v2.4 v2] docs: Further enhance the
	documentation related to SWEET32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The git master/2.4 code lacked some useful information about
the changes to --reneg-bytes, SWEET32 and weak ciphers (less
than 128-bits cipher blocks)

v2 - Fixed a couple of grammar/typo issues

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst   |  6 ++++++
 doc/openvpn.8 | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 8508fa3..df5ccb6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -182,6 +182,12 @@ Deprecated features
 
 User-visible Changes
 --------------------
+- When using ciphers with cipher blocks less than 128-bits
+  OpenVPN will complain loudly if the configuration uses ciphers considered
+  weak, such as the SWEET32 attack vector.  In such scenarios, OpenVPN will by
+  default do a renegotiation for each 64MB of transported data (``--reneg-bytes``).
+  This renegotiation can be disabled, but is HIGHLY DISCOURAGED.
+
 - For certificate DNs with duplicate fields, e.g. "OU=one,OU=two", both fields
   are now exported to the environment, where each second and later occurrence
   of a field get _$N appended to it's field name, starting at N=1.  For the
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f079799..ddaf0ed 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4876,11 +4876,18 @@ such as TCP expect this role to be left to them.
 .B \-\-reneg\-bytes n
 Renegotiate data channel key after
 .B n
-bytes sent or received (disabled by default).
+bytes sent or received (disabled by default with an exception, see below).
 OpenVPN allows the lifetime of a key
-to be expressed as a number of bytes encrypted/decrypted, a number of packets, or
-a number of seconds.  A key renegotiation will be forced
+to be expressed as a number of bytes encrypted/decrypted, a number of packets,
+or a number of seconds.  A key renegotiation will be forced
 if any of these three criteria are met by either peer.
+
+If using ciphers with cipher block sizes less than 128-bits, \-\-reneg\-bytes is
+set to 64MB by default, unless it is explicitly disabled by setting the value to
+0, but this is
+.B HIGHLY DISCOURAGED
+as this is designed to add some protection against the SWEET32 attack vector.
+For more information see the \-\-cipher option.
 .\"*********************************************************
 .TP
 .B \-\-reneg\-pkts n
-- 
1.8.3.1


