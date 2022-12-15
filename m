From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:38 +0100
Message-Id: <20221215190143.2107896-4-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/8] Ensure that argument to parse_line has
 always space for final sentinel
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

This fixes two places were we do not have enough space in the array
of parameters given to parse_line for the final NULL parameter that
signal the end of the parsed argument errors.

Both these cases can lead to a buffer overflow. But both of these
cases require root/admin access to OpenVPN:

- parse_argv, only able to trigger if starting openvpn from the command
  line, at this point you cannot  gain more privileges than you already
  have.

  Way to reproduce, compile with ASAN and run:

       openvpn --tls-verify a a a a a a a a a a a a a a a

- remove_iroutes_from_push_route_list

	This operates on the list of pushed entries that is generated
	by the server itself. So trigger this, you need to have control
	over config, management interface, a plugin or cdd files.

The parse_argv problem was found by Trial of Bits. I found the
remove_iroutes_from_push_route_list problem by looking for similar
problems.

Reported-By: Trial of Bits (TOB-OVPN-4)
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 9 ++++-----
 src/openvpn/push.c    | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e48e4b459..1d6c0572c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5310,8 +5310,6 @@ parse_argv(struct options *options,
            unsigned int *option_types_found,
            struct env_set *es)
 {
-    int i, j;
-
     /* usage message */
     if (argc <= 1)
     {
@@ -5321,7 +5319,7 @@ parse_argv(struct options *options,
     /* config filename specified only? */
     if (argc == 2 && strncmp(argv[1], "--", 2))
     {
-        char *p[MAX_PARMS];
+        char *p[MAX_PARMS+1];
         CLEAR(p);
         p[0] = "config";
         p[1] = argv[1];
@@ -5331,9 +5329,9 @@ parse_argv(struct options *options,
     else
     {
         /* parse command line */
-        for (i = 1; i < argc; ++i)
+        for (int i = 1; i < argc; ++i)
         {
-            char *p[MAX_PARMS];
+            char *p[MAX_PARMS+1];
             CLEAR(p);
             p[0] = argv[i];
             if (strncmp(p[0], "--", 2))
@@ -5345,6 +5343,7 @@ parse_argv(struct options *options,
                 p[0] += 2;
             }
 
+            int j;
             for (j = 1; j < MAX_PARMS; ++j)
             {
                 if (i + j < argc)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f8c747d44..ad2f3c656 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1096,13 +1096,13 @@ remove_iroutes_from_push_route_list(struct options *o)
         /* cycle through the push list */
         while (e)
         {
-            char *p[MAX_PARMS];
+            char *p[MAX_PARMS+1];
             bool enable = true;
 
             /* parse the push item */
             CLEAR(p);
             if (e->enable
-                && parse_line(e->option, p, SIZE(p), "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
+                && parse_line(e->option, p, SIZE(p)-1, "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
             {
                 /* is the push item a route directive? */
                 if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
-- 
2.37.1 (Apple Git-137.1)


