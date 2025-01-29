From: Gert Doering <gert@...1296...>
Date: Wed, 29 Jan 2025 19:28:18 +0100
Message-ID: <20250129182818.3041-1-gert@...1296...>
In-Reply-To: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
References: <gerrit.1737980858000.I0133085ac68f7b0db574b88276f6d5e1d3ad62d5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix doxygen warnings in crypto_epoch.h
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

Introduced by commit 92adbc88b1b37095cebde2a1c5b6ae242f382678.

Change-Id: I0133085ac68f7b0db574b88276f6d5e1d3ad62d5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/877
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index b2f3d86..9290482 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -71,7 +71,7 @@
  * Generate a data channel key pair from the epoch key
  * @param key           Destination for the generated data key
  * @param epoch_key     Epoch key to be used
- * @parm kt             Cipher information to generate the data channel key for
+ * @param kt            Cipher information to generate the data channel key for
  */
 void
 epoch_data_key_derive(struct key_parameters *key,
@@ -100,6 +100,7 @@
  * - recv key matches the epoch index provided
  * - send key epoch is equal or higher than recv_key epoch
  *
+ * @param co        crypto_options to update
  * @param new_epoch the new epoch to use for the receive key
  */
 void

