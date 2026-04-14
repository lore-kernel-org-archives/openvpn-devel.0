From: Gert Doering <gert@...1296...>
Date: Tue, 14 Apr 2026 07:57:59 +0200
Message-ID: <20260414055805.16974-1-gert@...1296...>
In-Reply-To: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add unit tests for 'auth-user-pass
 username-only'
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

Input from stdin is tested.

Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1602
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1602
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 16e0535..c0a0866 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -282,6 +282,17 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
+    flags = GET_USER_PASS_USERNAME_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Username:");
+    will_return(query_user_exec_builtin, "cuser");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "cuser");
+    assert_string_equal(up.password, "[[BLANK]]");
 }
 
 /* NOTE: expect_assert_failure does not seem to work with MSVC */

