From: Gert Doering <gert@...1296...>
Date: Wed,  2 Jul 2025 17:04:27 +0200
Message-ID: <20250702150433.3871-1-gert@...1296...>
In-Reply-To: <gerrit.1747748031000.Ia2b3eda18bd6dbce6c470037c7a01097e8147c29@...2715...>
References: <gerrit.1747748031000.Ia2b3eda18bd6dbce6c470037c7a01097e8147c29@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix new doxygen warnings about using
 @return in void functions
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

These seem to have been added in a more recent doxygen version
than I previously tested with.

Change-Id: Ia2b3eda18bd6dbce6c470037c7a01097e8147c29
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1029
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5bd1ad5..68ad901 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -467,12 +467,12 @@
  * If an error occurs during processing, then the \a buf %buffer is set to
  * empty.
  *
- * @param buf          - The %buffer containing the packet on which to
+ * @param[in,out] buf  - The %buffer containing the packet on which to
  *                       perform security operations.
  * @param work         - An initialized working %buffer.
  * @param opt          - The security parameter state for this VPN tunnel.
  *
- * @return This function returns void.\n On return, the \a buf argument
+ * @note On return, the \a buf argument
  *     will point to the resulting %buffer.  This %buffer will either
  *     contain the processed packet ready for sending, or be empty if an
  *     error occurred.
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 5003c96..cc96057 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -309,7 +309,7 @@
  *
  * @param f            - The \c fragment_master structure for this VPN
  *                       tunnel.
- * @param buf          - A pointer to the buffer structure containing the
+ * @param[in,out] buf  - A pointer to the buffer structure containing the
  *                       incoming packet.  This pointer will have been
  *                       modified on return either to point to a
  *                       completely reassembled packet, or to have length
@@ -317,7 +317,8 @@
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
  *
- * @return Void.\n On return, the \a buf argument will point to a buffer.
+ * @note On return the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     The buffer will have nonzero length if the incoming packet passed
  *     to this function was whole and unfragmented, or if it was the final
  *     part of a fragmented packet thereby completing reassembly.  On the
@@ -363,14 +364,15 @@
  *
  * @param f            - The \c fragment_master structure for this VPN
  *                       tunnel.
- * @param buf          - A pointer to the buffer structure containing the
+ * @param[in,out] buf  - A pointer to the buffer structure containing the
  *                       outgoing packet.  This pointer will be modified
  *                       to point to a whole unfragmented packet or to the
  *                       first part of a fragmented packet on return.
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
  *
- * @return Void.\n On return, the \a buf argument will point to a buffer.
+ * @note On return the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     This buffer contains either the whole original outgoing packet if
  *     fragmentation was not necessary, or the first part of the
  *     fragmented outgoing packet if fragmentation was necessary. In both
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index fe289f1..ad8fa3d7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -582,8 +582,6 @@
  * @param tls_multi     tls multi context of VPN tunnel
  * @param gc            gc arena for allocating push options
  * @param push_list     push list to where options are added
- *
- * @return true on success, false on failure.
  */
 void
 prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,

