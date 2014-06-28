Message-ID: <53AF0D20.7020204@...1856...>
Date: Sat, 28 Jun 2014 20:44:48 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060906030009040100050508"
Subject: [Openvpn-devel] [PATCH] Fix some typos in the man page
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
--------------060906030009040100050508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ACK to the attached patch, extracted from the 'version 2' patch supplied
by Andris Kalnozols in trac ticket #402.

Applies to both release/2.3 and master.

-Steffan

--------------060906030009040100050508
Content-Type: text/x-patch;
 name="0001-Fix-some-typos-in-the-man-page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Fix-some-typos-in-the-man-page.patch"

From ae6e57ffb677cbee90ff55c83c5071d41ede6999 Mon Sep 17 00:00:00 2001
From: Andris Kalnozols <andris@...1839...>
Date: Sat, 28 Jun 2014 19:45:48 +0200
Subject: [PATCH 1/3] Fix some typos in the man page.

Signed-off-by: Andris Kalnozols <andris@...1839...>
---
 doc/openvpn.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 786719d..14f3129 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1606,7 +1606,7 @@ and
 in server mode configurations.
 
 The server timeout is set twice the value of the second argument.
-This ensures that a timeout is dectected on client side
+This ensures that a timeout is detected on client side
 before the server side drops the connection.
 
 For example,
@@ -2459,7 +2459,7 @@ Normally, adaptive compression is enabled with
 .B \-\-comp-lzo.
 
 Adaptive compression tries to optimize the case where you have
-compression enabled, but you are sending predominantly uncompressible
+compression enabled, but you are sending predominantly incompressible
 (or pre-compressed) packets over the tunnel, such as an FTP or rsync transfer
 of a large, compressed file.  With adaptive compression,
 OpenVPN will periodically sample the compression process to measure its
@@ -3498,7 +3498,7 @@ like this:
 .B
 /C=US/L=Somewhere/CN=John Doe/emailAddress=john@...1113...
 .IP
-In addition the old behavivour was to remap any character other than
+In addition the old behaviour was to remap any character other than
 alphanumeric, underscore ('_'), dash ('-'), dot ('.'), and slash ('/') to
 underscore ('_').  The X.509 Subject string as returned by the
 .B tls_id
@@ -4354,7 +4354,7 @@ A different mode can be specified for each provider.
 Mode is encoded as hex number, and can be a mask one of the following:
 
 .B 0
-(default) \-\- Try to determind automatically.
+(default) \-\- Try to determine automatically.
 .br
 .B 1
 \-\- Use sign.
-- 
1.9.1


--------------060906030009040100050508--

