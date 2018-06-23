Date: Sat, 23 Jun 2018 14:09:10 +0200 (CEST)
Message-Id: <201806231209.w5NC9AhF028415@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180623021147.22792-1-a@...2181...>
References: <20180623021147.22792-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: add support for %lu in
 argv_printf and prevent ASSERT
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

The code is trivially correct, and it does what it says on the lid :-)
- and to verify, I've added a unit test to test_argv.c - attached below, 
we might consider adding something like this, or something more elaborate
for all supported argv*() arguments...

Your patch has been applied to the master and release/2.4 branch
("someone will fix something else some day, relying on the existance
of %lu, and then 2.4 will surprisingly explode").

commit e38d3a004195f33c5c04fe7c04db5d66c53241bc (master)
commit 61dcf1513d69ddf1261402744496436923ec14bb (release/2.4)
Author: Antonio Quartulli
Date:   Sat Jun 23 10:11:47 2018 +0800

     add support for %lu in argv_printf and prevent ASSERT

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180623021147.22792-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17115.html
     Signed-off-by: Gert Doering <gert@...1296...>


----------
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 4a3ba559..0e7a4513 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -116,8 +116,12 @@ argv_str__multiple_argv__correct_output(void **state)
     argv_printf(&a, "%s%sc", PATH1, PATH2);
     argv_printf_cat(&a, "%s", PARAM1);
     argv_printf_cat(&a, "%s", PARAM2);
+    argv_printf_cat(&a, "%d", -1);
+    argv_printf_cat(&a, "%u", -1);
+    argv_printf_cat(&a, "%lu", (unsigned long) (1L<<33) );
     output = argv_str(&a, &gc, PA_BRACKET);
-    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]");
+    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]"
+				" [-1] [4294967295] [8589934592]");
 
     argv_reset(&a);
     gc_free(&gc);


--
kind regards,

Gert Doering


