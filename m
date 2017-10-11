From: simon@...2293...
Date: Wed, 11 Oct 2017 15:45:30 +0200
Message-Id: <20171011134530.6676-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Document ">PASSWORD:Auth-Token" real-time
 message
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

From: Simon Rozman <simon@...2293...>

Authentication tokens are security enhancement eliminating client
need to cache passwords, and are indispensable at two factor
authentication methods, such as HOTP or TOTP.

The ">PASSWORD:Auth-Token" message was not mentioned anywhere in
the OpenVPN Management Interface Notes. This patch adds a simple use
case example, while the more detailed feature description remains
explained in the OpenVPN manual.
---
 doc/management-notes.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 0e7a7d4..c31ff5c 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -317,6 +317,13 @@ COMMAND -- password and username
 
     >PASSWORD:Verification Failed: 'custom server-generated string'
 
+  Example 6: If server pushes --auth-token to the client, the OpenVPN
+  will produce a real-time PASSWORD message:
+
+    >PASSWORD:Auth-Token:foobar
+
+  The client should replace the local password with the "foobar".
+
 COMMAND -- forget-passwords
 ---------------------------
 
-- 
2.9.0.windows.1


