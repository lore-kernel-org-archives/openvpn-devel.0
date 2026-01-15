From: Gert Doering <gert@...1296...>
Date: Thu, 15 Jan 2026 10:25:47 +0100
Message-ID: <20260115092552.25011-1-gert@...1296...>
In-Reply-To: <gerrit.1768318939000.I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b@...2715...>
References: <gerrit.1768318939000.I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] error: Remove our implementation of
 static_assert
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

It is C11, so it should be present in all our
compilers.

Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1471
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1471
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 44572b4..1198994 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -245,14 +245,6 @@
 #endif
     ;
 
-/* Poor-man's static_assert() for when not supplied by assert.h, taken from
- * Linux's sys/cdefs.h under GPLv2 */
-#ifndef static_assert
-#define static_assert(expr, diagnostic)            \
-    extern int (*__OpenVPN_static_assert_function( \
-        void))[!!sizeof(struct { int __error_if_negative : (expr) ? 2 : -1; })]
-#endif
-
 /* Inline functions */
 
 static inline bool

