From: Gert Doering <gert@...1296...>
Date: Wed, 14 Jan 2026 12:23:49 +0100
Message-ID: <20260114112403.7046-1-gert@...1296...>
In-Reply-To: <gerrit.1768377240000.Idbd0a47ba4d297a833a350611a23f19fd9a797b5@...2715...>
References: <gerrit.1768377240000.Idbd0a47ba4d297a833a350611a23f19fd9a797b5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Repair interaction between DCO and
 persist-tun after reconnection
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

When --persist-tun is active, openvpn userland on Linux and FreeBSD fails
to re-enable "poll for DCO events" after a reconnect (e.g. triggered by
a ping timeout).  The reconnect will still work fine, but the *next*
DCO event notification from the kernel will not be received by OpenVPN
userland, and so the system will get into an inconsistent state (Userland
assumes "all is well", kernel DCO has disconnected the peer, connection
is broken until the next tls-renegotion and/or manual restart, *and* the
next DCO key setup might fail due to "peer id gone").

This only affects client side, --server tun is always "persistent", and
there is no "full restart" (and the code path in question is also
only used for client and p2p server).

The root cause is an incorrect check for "is this interface up?" when
calling dco_event_set() in forard.c::io_wait() - "c2.did_open_tun" is
only true if the tun interface was actually configured on this reconnect,
which it isn't if --persist-tun is active.  Replace with a check for
"do we have a tuntap structure, and if yes, do we have active DCO?"
which reflects the original intent much better.

The original code also had a check for "out_socket & EVENT_READ" there,
which did to some extend avoid calling dco_event_set() for every single
UDP packet sent and received by userland - but this only worked on initial
connection, and is always true on reconnect, so this condition was removed
for simplicity.  We should come back here...

v2:
  - some language fixes on the commit message
  - do not check ->dco.open in forward.c, as this is not available if
    not on FreeBSD, or if compiled with --disable-dco.
    FreeBSD DCO does the "if (!dco || !dco->open)" check in dco_event_set()
    anyway, so it's not needed, and Linux DCO has "dco->nl_sock", which is
    also reliably set/unset, and checked by dco_event_set() already.

Github: OpenVPN/openvpn#947

Change-Id: Idbd0a47ba4d297a833a350611a23f19fd9a797b5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1473
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1473
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d208c21..39ac3b3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2197,7 +2197,7 @@
     multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tuntap);
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (out_socket & EVENT_READ && c->c2.did_open_tun)
+    if (c->c1.tuntap)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shift);
     }

