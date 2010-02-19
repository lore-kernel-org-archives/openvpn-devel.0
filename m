From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 19 Feb 2010 23:57:30 +0100
Message-Id: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
	addresses in getaddr()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

(I'm withdrawing the first version, and suggesting this patch to be used instead,
as this one follows the new feature deprecation process.)

Based on a discussion on the mailing list and in the IRC meeting Feb 18,
it was decided to remove get_random() from the getaddr() function as that
can conflict with round-robin/randomization done by DNS servers.

For now this feature is enabled by default, but can be disabled by running
./configure with --disable-depr-random-resolv.  In the future this will be
changed to being disabled by default before getting removed.

Signed-off-by: David Sommerseth <dazo@...384...>

---
 configure.ac |   17 +++++++++++++++++
 socket.c     |   14 +++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 116ff7c..7ffa903 100644
--- a/configure.ac
+++ b/configure.ac
@@ -911,6 +911,23 @@ if test -z "${htmldir}"; then
 fi
 # end workaround
 
+#
+# Deprecated features
+#
+# See http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentation
+# for more info about the feature deprecation process.
+#
+
+AC_ARG_ENABLE(depr-random-resolv,
+   [  --disable-depr-random-resolv   Deprecated feature: Randomization of hostname resolving when more than one IP address],
+   [DEPRECATE_RANDRESOLV="$enableval"],
+   [DEPRECATE_RANDRESOLV="yes"]
+)
+if test "$DEPRECATE_RANDRESOLV" = "yes"; then
+        AC_DEFINE(DEPRECATED_RANDOM_RESOLV, 1, [Deprecated feature: Randomization of hostname resolving when more than one IP address])
+fi
+
+
 AC_OUTPUT([
 	Makefile
 	openvpn.spec
diff --git a/socket.c b/socket.c
index fecc398..c963a21 100644
--- a/socket.c
+++ b/socket.c
@@ -205,6 +205,10 @@ getaddr (unsigned int flags,
 	{
 	  if (h->h_addr_list[1]) /* more than one address returned */
 	    {
+#ifdef DEPRECATED_RANDOM_RESOLV
+#warning
+#warning **** DEPRECATED FEATURE ****   DEPRECATED_RANDOM_RESOLV is enabled
+#warning
 	      int n = 0;
 
 	      /* count address list */
@@ -212,12 +216,16 @@ getaddr (unsigned int flags,
 		++n;
 	      ASSERT (n >= 2);
 
-	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one by random",
-		   hostname,
-		   n);
+	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one by random."
+                   " [DEPRECATED FEATURE]", hostname, n);
 
 	      /* choose address randomly, for basic load-balancing capability */
 	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
+
+#else /* preferred solution */
+	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to more than one IP address, will "
+                   "use the first resolved address", hostname);
+#endif /* ENABLE_RANDOM_RESOLV */
 	    }
 	}
 
-- 
1.6.6


