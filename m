From: Gert Doering <gert@...1296...>
Date: Wed,  9 Apr 2025 14:53:31 +0200
Message-ID: <20250409125336.5835-1-gert@...1296...>
In-Reply-To: <gerrit.1744193529000.Iabef94b36bae16b2c8288b15b14d660ecb06842d@...2715...>
References: <gerrit.1744193529000.Iabef94b36bae16b2c8288b15b14d660ecb06842d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Doxygen: Fix obsolete links to OpenSSL
 documentation
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

Change-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/937
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index e4fec83..ad1a420 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -7,7 +7,7 @@
 # OCSP server using the -port option to "openssl ocsp".
 
 # Full documentation and examples:
-# http://www.openssl.org/docs/apps/ocsp.html
+# https://docs.openssl.org/master/man1/openssl-ocsp/#openssl-ocsp
 
 
 # Edit the following values to suit your needs
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index d32f9d8..91c7a5a 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -95,11 +95,11 @@
  * to supply cryptographically strong pseudo-random data.  The following links
  * contain more information on this subject:
  * - For OpenSSL's \c RAND_bytes() function:
- *   http://www.openssl.org/docs/crypto/RAND_bytes.html
+ *   https://docs.openssl.org/master/man3/RAND_bytes/#rand_bytes
  * - For OpenSSL's pseudo-random number generating system:
- *   http://www.openssl.org/docs/crypto/rand.html
+ *   https://docs.openssl.org/master/man7/RAND/#rand
  * - For OpenSSL's support for external crypto modules:
- *   http://www.openssl.org/docs/crypto/engine.html
+ *   https://docs.openssl.org/master/man7/provider/#provider
  *
  * In mbed TLS, the Havege random number generator is used. For details, see
  * the mbed TLS documentation.

