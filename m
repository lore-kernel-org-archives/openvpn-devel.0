From: Gert Doering <gert@...1296...>
Date: Tue, 13 Jan 2026 08:27:45 +0100
Message-ID: <20260113072750.16015-1-gert@...1296...>
In-Reply-To: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
References: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Require script-security 2 when using
 unix: tun
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

Since this executes an executable from an arbitrary path, it should follow
the same rules as other scripts/executable.

Reported-By: Petr Simecek, Pavel Kohout and Stanislav Fort from Aisle Research
Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1465
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1465
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index c410480..a67a472 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -61,7 +61,10 @@
 
     argv_printf(&argv, "%s", program);
 
-    tt->afunix.childprocess = openvpn_execve_check(&argv, env, S_NOWAITPID, msgprefix);
+    /* exit when executing fails to easier spot errors here and treat this
+     * command like an external script */
+    int flags = S_NOWAITPID | S_SCRIPT | S_FATAL;
+    tt->afunix.childprocess = openvpn_execve_check(&argv, env, flags, msgprefix);
     if (!openvpn_waitpid_check(tt->afunix.childprocess, msgprefix, M_WARN))
     {
         tt->afunix.childprocess = 0;

