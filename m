From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 21:32:10 +0100
Message-ID: <20251028203219.11737-1-gert@...1296...>
In-Reply-To: <gerrit.1761676579000.I9118333bb65cd5db0836abefa5d45a729f0142cc@...2715...>
References: <gerrit.1761676579000.I9118333bb65cd5db0836abefa5d45a729f0142cc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] remove redundant PULL_DEFINED() macro
 definition
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

this seems to be a leftover of the time when we had conditional
compilation for "--disable-server" or thus.  Commit d6a0cf599
removed PUSH_DEFINED() nearby but overlooked this one.

Change-Id: I9118333bb65cd5db0836abefa5d45a729f0142cc
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1322
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1322
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 24253af..125e524 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -769,10 +769,6 @@
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
-#ifndef PULL_DEFINED
-#define PULL_DEFINED(opt) (false)
-#endif
-
 #ifdef _WIN32
 #define ROUTE_OPTION_FLAGS(o) ((o)->route_method & ROUTE_METHOD_MASK)
 #else

