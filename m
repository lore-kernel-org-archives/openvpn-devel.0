From: Gert Doering <gert@...1296...>
Date: Tue,  2 Sep 2025 18:45:15 +0200
Message-ID: <20250902164521.23145-1-gert@...1296...>
In-Reply-To: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
References: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: validate tun interface before
 fetching stats
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

From: Ralf Lici <ralf@...2726...>

If dco_get_peer_stats() is called with an uninitialized c->c1.tuntap it
results in a segfault. This issue happens when a client who has not
connected to any server:
  - has --management and exits,
  - has --management and a management interface client issues either
    `bytecount` or `status` or
  - if SIGUSR2 is sent to it.

Add a check to ensure the tun interface was set up before attempting to
retrieve peer statistics.

Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1166
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a3907fe..e70b74d 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1139,6 +1139,8 @@
 static int
 dco_get_peer(dco_context_t *dco, int peer_id, const bool raise_sigusr1_on_err)
 {
+    ASSERT(dco);
+
     /* peer_id == -1 means "dump all peers", but this is allowed in MP mode only.
      * If it happens in P2P mode it means that the DCO peer was deleted and we
      * can simply bail out
@@ -1182,6 +1184,11 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
+    if (!c->c1.tuntap || c->c1.tuntap->dco.ifindex == 0)
+    {
+        return -1;
+    }
+
     return dco_get_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id, raise_sigusr1_on_err);
 }
 

