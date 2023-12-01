From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 12:18:46 +0100
Message-Id: <20231201111846.15097-1-frank@...2641...>
In-Reply-To: <gerrit.1701361470000.Ie511a586cf022afcab9d67891ff80676ac7d47b9@...2715...>
References: <gerrit.1701361470000.Ie511a586cf022afcab9d67891ff80676ac7d47b9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove dead remains of
 extract_x509_field_test
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

This removes some leftover references to extract_x509_field_test that
was removed 15 years ago in commit 564cbab5f.

Change-Id: Ie511a586cf022afcab9d67891ff80676ac7d47b9
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/462
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Small fix in commit message added manually.
        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8c707a4..abba748 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -880,11 +880,6 @@
     return false;
 #endif
 
-#ifdef EXTRACT_X509_FIELD_TEST
-    extract_x509_field_test();
-    return false;
-#endif
-
 #ifdef TIME_TEST
     time_test();
     return false;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e842746..6ba6ff8 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -540,9 +540,6 @@
 
 #endif
 
-/*#define EXTRACT_X509_FIELD_TEST*/
-void extract_x509_field_test(void);
-
 /**
  * Given a key_method, return true if opcode represents the one of the
  * hard_reset op codes for key-method 2

