From: Gert Doering <gert@...1296...>
Date: Mon, 27 Oct 2025 22:27:41 +0100
Message-ID: <20251027212747.4161-1-gert@...1296...>
In-Reply-To: <gerrit.1761596820000.I85320b8f1cfc02dfd561916e5637d9481edac59e@...2715...>
References: <gerrit.1761596820000.I85320b8f1cfc02dfd561916e5637d9481edac59e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] pkcs11_management_id_get: Free
 certificate object after use
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

From: Selva Nair <selva.nair@...277...>

Found by ZeroPath

Change-Id: I85320b8f1cfc02dfd561916e5637d9481edac59e
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1317
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1317
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index ce64135..9afb181 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -436,9 +436,6 @@
 {
     pkcs11h_certificate_id_list_t id_list = NULL;
     pkcs11h_certificate_id_list_t entry = NULL;
-#if 0 /* certificate_id seems to be unused -- JY */
-    pkcs11h_certificate_id_t certificate_id = NULL;
-#endif
     pkcs11h_certificate_t certificate = NULL;
     CK_RV rv = CKR_OK;
     unsigned char *certificate_blob = NULL;
@@ -548,6 +545,9 @@
     pkcs11h_certificate_freeCertificateIdList(id_list);
     id_list = NULL;
 
+    pkcs11h_certificate_freeCertificate(certificate);
+    certificate = NULL;
+
     free(internal_id);
     internal_id = NULL;
 

