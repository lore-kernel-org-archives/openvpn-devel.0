From: Gert Doering <gert@...1296...>
Date: Mon, 22 Sep 2025 22:41:52 +0200
Message-ID: <20250922204158.23319-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
References: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] ssl: Fix -Wconversion warnings in
 pem_password_callback
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

From: Frank Lichtenheld <frank@...2641...>

The OpenSSL API is how it is, so adapt with casts.

Change-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c17e608..284d951 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -264,10 +264,10 @@
         /* prompt for password even if --askpass wasn't specified */
         pem_password_setup(NULL);
         ASSERT(!passbuf.protected);
-        strncpynt(buf, passbuf.password, size);
+        strncpynt(buf, passbuf.password, (size_t)size);
         purge_user_pass(&passbuf, false);
 
-        return strlen(buf);
+        return (int)strlen(buf);
     }
     return 0;
 }

