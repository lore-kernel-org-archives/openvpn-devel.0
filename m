From: David Sommerseth <davids@...515...>
Date: Wed, 21 Dec 2016 21:54:50 +0100
Message-Id: <1482353691-27088-2-git-send-email-davids@...515...>
In-Reply-To: <1482353691-27088-1-git-send-email-davids@...515...>
References: <1482353691-27088-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH release/2.3] docs: Further improve
	--reneg-bytes and SWEET32 information
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

There are still some support tickets related to SWEET32 and
our defult enforced --reneg-bytes 64 when using weaker ciphers
(less than 128-bits cipher blocks).  Try to clarify this even
more.

Also fix a few mistakes, saying less than 128-bits and not 128-bits
and less.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst   |  6 +++---
 doc/openvpn.8 | 13 ++++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 3e3aaad..1c0154c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -57,10 +57,10 @@ Improved UTF-8 support
 Behavioral changes
 ------------------
 
-- OpenVPN will complain loudly about ciphers with 128-bits block sizes or less
+- OpenVPN will complain loudly about ciphers with block sizes less than 128-bits
 
 - OpenVPN will by default re-negotiate the tunnel after 64MB when used with
-  ciphers using cipher blocks of 128-bits or less
+  ciphers using cipher blocks sizes less than 128-bits
 
 - Remove --enable-password-save option to configure, this is now always enabled
 
@@ -121,7 +121,7 @@ Version 2.3.13
 
   Ciphers with cipher blocks less than 128 bits will now do a renegotiation
   of the tunnel by default for every 64MB of data.  This behaviour can be
-  overridden by explictly setting --reneg-bytes 0 in the configuration file,
+  overridden by explicitly setting --reneg-bytes 0 in the configuration file,
   however this is HIGHLY discouraged.
 
   This is to reduce the risk for SWEET32 attacks.  The general recommendation
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2140733..6063ccd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4612,11 +4612,18 @@ such as TCP expect this role to be left to them.
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
+0,but this is
+.B HIGHLY DISCOURAGED
+as this is designed to add some protection against the SWEET32 attack vector.
+For more information see the \-\-cipher option.
 .\"*********************************************************
 .TP
 .B \-\-reneg\-pkts n
-- 
1.8.3.1


