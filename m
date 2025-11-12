From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 15:13:28 +0100
Message-ID: <20251112141335.17417-1-gert@...1296...>
In-Reply-To: <gerrit.1762954807000.Ided1ac7c804487055b175d8766535bead257b7d5@...2715...>
References: <gerrit.1762954807000.Ided1ac7c804487055b175d8766535bead257b7d5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix construction of invalid pointer in
 tls_pre_decrypt
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

In tls_pre_decrypt we construct a pointer ks with an invalid i if i is TM_SIZE
doing a out-of-bounds access in multi->session.

This is a something that exists at least since 2.3.0 (I didn't go further
back but probalby exists in earlier version as well as the commits date
back to SVN beta21 branch).

So we construct the pointer but do not do anything with it if it is inval
id as we check i *after* we construct the pointer `ks`.

I suspect that the compiler optimises the bug away in any higher optimisation
level.

Assuming there is no optimisation, let's check what is possible.
Since we never use the value `ks` if it is invalid, we do not have
worry if it ends up invalid or not. The only thing that we have to
worry about is whether
`session + offsetof(struct tls_session, key[KS_PRIMARY])` is pointing
to memory that is valid to read to construct the `ks` pointer.
This is outside the tls_multi struct, so this is not guaranteed to be
allocated memory but at the same time it is also only few bytes (or few
tens/houndred) after the struct, so it will with an extremely high
probably be in a memory region that will not cause a segfault.

Every time this condition is hit and we construct the invalid pointer,
the log message "TLS Error: Unroutable control packet received" is
printed at `verb 1` or higher. And this is a quite common log message,
which serves as indication as well that a crash is not something that
typically happens but either the optimisation fixes or the memory
region of the invalid access is valid to read from.

Change-Id: Ided1ac7c804487055b175d8766535bead257b7d5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1373
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1373
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 398c9ae..e21ac78 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3729,9 +3729,6 @@
     }
     else
     {
-        struct tls_session *session = &multi->session[i];
-        struct key_state *ks = &session->key[KS_PRIMARY];
-
         /*
          * Packet must belong to an existing session.
          */
@@ -3742,6 +3739,8 @@
             goto error;
         }
 
+        struct tls_session *session = &multi->session[i];
+        struct key_state *ks = &session->key[KS_PRIMARY];
         /*
          * Verify remote IP address
          */

