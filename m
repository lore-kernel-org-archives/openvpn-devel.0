From: David Sommerseth <davids@...515...>
Date: Wed, 28 Feb 2018 14:19:16 +0100
Message-Id: <20180228131918.12954-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/3] man: Add .TQ groff support macro
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This introduces the .TQ groff macro.  Even though this can be found
in newer groff versions, not all platforms we support carries this one.

This macro makes it possible to have mulitple lines of options as
headers before describing all of these options in the same segment.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 364aee8a..bd9f2606 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -33,7 +33,15 @@
 .\" .ft -- normal face
 .\" .in +|-{n} -- indent
 .\"
-.TH openvpn 8 "31 January 2018"
+.\" Support macros - this is not present on all platforms
+.\" Continuation line for .TP header.
+.de TQ
+.  br
+.  ns
+.  TP \\$1\" no doublequotes around argument!
+..
+.\" End of TQ macro
+.TH openvpn 8 "28 February 2018"
 .\"*********************************************************
 .SH NAME
 openvpn \- secure IP tunnel daemon.
-- 
2.13.5


