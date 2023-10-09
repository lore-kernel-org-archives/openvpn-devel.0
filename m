From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  9 Oct 2023 12:57:14 +0200
Message-Id: <20231009105714.34598-1-frank@...2641...>
In-Reply-To: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
References: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add warning for the --show-groups command
 that some groups are missing
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

From: Arne Schwabe <arne@...1227...>

OpenSSL has a weird way of only reporting EC curves that are implemented
in a certain way in the list of all EC curves. Note this fact and point
out that also the very important curves X448 and X25519 are affected.

Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Note: I fixed some typos on-the-fly. See my comments in Gerrit
for details.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/366
This mail reflects revision 7 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 686ecf7..2b3f4f4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2359,8 +2359,10 @@
 void
 show_available_curves(void)
 {
-    printf("Consider using openssl 'ecparam -list_curves' as\n"
-           "alternative to running this command.\n");
+    printf("Consider using 'openssl ecparam -list_curves' as alternative to running\n"
+           "this command.\n"
+           "Note this output does only list curves/groups that OpenSSL considers as\n"
+           "builtin EC curves. It does not list additional curves nor X448 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves = NULL;
     size_t crv_len = 0;

