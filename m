Date: Sun, 30 Aug 2015 00:23:36 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20150830002336.32791c7b.movrax-dev@...2061...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Privileges not being dropped if the first
 connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Author: Lukasz Kutyla <movrax-dev@...2061...>

Interruption in first connection will prevent further privilege dropping

OpenVPN does not drop privileges (UID/GID/chroot) as requested
according to the configuration file and/or passed arguments if the first
connection is not established successfully, this also includes applying
SELinux context. Signals and restarts are processed after
"context.first_time" is set to "false" which results in omitting entire
block in do_uid_gid_chroot() when another (successful) connection is
made, everything is initialized correctly and said function called.

Reproducing is easy, one of the ways is to use the same host with
different ports (first one unused, so it fails):
  # reduce timeout to trigger reset faster
  keepalive 10 30
  # unused PORT (to trigger reset when it fails)
  remote VPN_IP 29999
  # correct PORT
  remote VPN_IP 1194
Any later connections made will be associated with no attempts to drop
privileges and the process will keep the ones it has been started with.

A lot of versions seem to be affected by that (including the newest).

Suggested patch removes "c->first_time" from initial checking and
additionally moves it to memstat (which isn't affected by "no_delay",
so the code could be executed twice). "c0 && !c0->uid_gid_set"
expression can handle the job alone and properly even when UID/GID are
not specified ("context_0.uid_gid_set" is set to "true" one way or
another).

Signed-off-by: Lukasz Kutyla <movrax-dev@...2061...>
---
 src/openvpn/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fe00918..21cafb5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -948,7 +948,7 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
   static const char why_not[] = "will be delayed because of --client,
--pull, or --up-delay"; struct context_0 *c0 = c->c0;
 
-  if (c->first_time && c0 && !c0->uid_gid_set)
+  if (c0 && !c0->uid_gid_set)
     {
       /* chroot if requested */
       if (c->options.chroot_dir)
@@ -972,7 +972,7 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
 	}
 
 #ifdef ENABLE_MEMSTATS
-      if (c->options.memstats_fn)
+      if (c->first_time && c->options.memstats_fn)
 	mstats_open(c->options.memstats_fn);
 #endif
 

--

Lukasz

