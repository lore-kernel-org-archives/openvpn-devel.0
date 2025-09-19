From: Gert Doering <gert@...1296...>
Date: Fri, 19 Sep 2025 13:31:58 +0200
Message-ID: <20250919113207.25440-1-gert@...1296...>
In-Reply-To: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
References: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Makefile: fix "make dist"
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

From: Lev Stipakov <lev@...515...>

Commit

  6c3afe5 ("Validate DNS domain name before powershell invocation")

has introduced a new header file but didn't add it to Makefile's
SOURCES, breaking "make dist".

Change-Id: I93406dd91694974df4ea087b9312ae2fafbc7fe7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1201
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1201
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4492c15..e80179c 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -57,6 +57,7 @@
 	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
+	domain_helper.h \
 	env_set.c env_set.h \
 	errlevel.h \
 	error.c error.h \

