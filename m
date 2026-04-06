From: Gert Doering <gert@...1296...>
Date: Mon,  6 Apr 2026 09:47:24 +0200
Message-ID: <20260406074729.29903-1-gert@...1296...>
In-Reply-To: <gerrit.1775426608000.I64da2328591ef2b9ee7502e574c878651cdf356a@...2715...>
References: <gerrit.1775426608000.I64da2328591ef2b9ee7502e574c878651cdf356a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_packet_id: Add a check after malloc
 to ensure value is valid
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

cppcheck complains about a potential null pointer dereference
in reliable_get_num_output_sequenced_available. That is mostly
theoretical, but still add a check.

Change-Id: I64da2328591ef2b9ee7502e574c878651cdf356a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1621
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1621
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index b7538bd..5dfd319 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -164,6 +164,7 @@
 test_get_num_output_sequenced_available(void **state)
 {
     struct reliable *rel = malloc(sizeof(struct reliable));
+    assert_non_null(rel);
     reliable_init(rel, 100, 50, 8, false);
 
     rel->array[5].active = true;

