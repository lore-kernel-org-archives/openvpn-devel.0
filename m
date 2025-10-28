From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 12:59:47 +0100
Message-ID: <20251028115953.22487-1-gert@...1296...>
In-Reply-To: <gerrit.1761601339000.Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e@...2715...>
References: <gerrit.1761601339000.Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add ASSERT to afunix code that dev_node
 is always set up the way we expect
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

The calling code only calls tun_afunix_exec_child if is_tun_afunix is true,
which checks that the path is having unix: as prefix.

But since adding an ASSERT here to ensure that it is really the case
does not cost us anything, just add the ASSERT.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: Zeropath

Change-Id: Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1320
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1320
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 4d48a31..e6f2be1 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -53,6 +53,8 @@
     const char *msgprefix = "ERROR: failure executing process for tun:";
     struct argv argv = argv_new();
 
+    /* we should always called with a proper unix: dev node string */
+    ASSERT(dev_node && strncmp(dev_node, "unix:", strlen("unix:")) == 0);
     /* since we know that dev-node starts with unix: we can just skip that
      * to get the program name */
     const char *program = dev_node + strlen("unix:");

