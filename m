From: David Sommerseth <davids@...515...>
Date: Tue,  1 Nov 2016 14:38:09 +0100
Message-Id: <1478007489-17163-1-git-send-email-davids@...515...>
In-Reply-To: <1477922488-26941-1-git-send-email-davids@...515...>
References: <1477922488-26941-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2] man: Improve the --keepalive section
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

Just minor clarifications and corrections of the --keepalive option.

  v2 - Changed from ps/pto to interval/timeout
     - Rephrased the server-side timeout doubling parapgraph

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e73517a..3a4ab21 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1614,16 +1614,25 @@ and
 are mutually exclusive and cannot be used together.
 .\"*********************************************************
 .TP
-.B \-\-keepalive n m
+.B \-\-keepalive interval timeout
 A helper directive designed to simplify the expression of
 .B \-\-ping
 and
+.B \-\-ping\-restart.
+
+This option can be used on both client and server side, but it is
+in enough to add this on the server side as it will push appropriate
+.B \-\-ping
+and
 .B \-\-ping\-restart
-in server mode configurations.
+options to the client.  If used on both server and client,
+the values pushed from server will override the client local values.
 
-The server timeout is set twice the value of the second argument.
-This ensures that a timeout is detected on client side
-before the server side drops the connection.
+The
+.B timeout
+argument will be twice as long on the server side.  This ensures that
+a timeout is detected on client side before the server side drops
+the connection.
 
 For example,
 .B \-\-keepalive 10 60
@@ -1633,13 +1642,13 @@ expands as follows:
 .ft 3
 .in +4
  if mode server:
-   ping 10
-   ping\-restart 120
-   push "ping 10"
-   push "ping\-restart 60"
+   ping 10                    # Argument: interval
+   ping\-restart 120           # Argument: timeout*2
+   push "ping 10"             # Argument: interval
+   push "ping\-restart 60"     # Argument: timeout
  else
-   ping 10
-   ping\-restart 60
+   ping 10                    # Argument: interval
+   ping\-restart 60            # Argument: timeout
 .in -4
 .ft
 .fi
-- 
1.8.3.1


