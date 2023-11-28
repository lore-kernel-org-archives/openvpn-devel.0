From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 11:43:59 +0100
Message-Id: <20231128104359.62967-1-frank@...2641...>
In-Reply-To: <gerrit.1700694723000.Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d@...2715...>
References: <gerrit.1700694723000.Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix check_session_buf_not_used using
 wrong index
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

The inner loop used i instead of j when iterating through the buffers.
Since i is always between 0 and 2 and ks->send_reliable->size is
(when it is defined) always 6 (TLS_RELIABLE_N_SEND_BUFFERS) this does not
cause an index of out bounds. So while the check is not doing anything
really useful with i instead of  j, it at least is not crashing or
anything similar.

Noticed-By: Jon Williams (braindead-bf) on Github issue #449
Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/459
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400230c..b5d24b5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3207,7 +3207,7 @@
 
         for (int j = 0; j < ks->send_reliable->size; j++)
         {
-            if (ks->send_reliable->array[i].buf.data == dataptr)
+            if (ks->send_reliable->array[j].buf.data == dataptr)
             {
                 msg(M_INFO, "Warning buffer of freed TLS session is still in"
                     " use (session->key[%d].send_reliable->array[%d])",

