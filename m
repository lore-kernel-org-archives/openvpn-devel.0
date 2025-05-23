From: Gert Doering <gert@...1296...>
Date: Fri, 23 May 2025 09:38:41 +0200
Message-ID: <20250523073848.20848-1-gert@...1296...>
In-Reply-To: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
References: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco_linux: avoid bogus text when netlink
 message is not parsed
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

From: Antonio Quartulli <antonio@...2726...>

We may bail out parsing an incoming DCO message because it may
concern a different interface.
In that case we print the following debug messages:

    dco_do_read
    ovpn-dco: ignoring message (type=5) for foreign ifindex 313
    process_incoming_dco: received message of type 0 - ignoring

However, the last message is confusing, because there is no message
of type 0 being received, but the message_type was simply not
initialized.

Bail out parsing earlier and avoid printing any bogus text.

Change-Id: I568faa12a5960e8b69de23c2df413b70b231592c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1027
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ed4cdb4..7134f30 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1251,6 +1251,12 @@
 
     dco_do_read(dco);
 
+    /* no message for us to handle - platform specific code has logged details */
+    if (dco->dco_message_type == 0)
+    {
+        return;
+    }
+
     /* FreeBSD currently sends us removal notifcation with the old peer-id in
      * p2p mode with the ping timeout reason, so ignore that one to not shoot
      * ourselves in the foot and removing the just established session */

