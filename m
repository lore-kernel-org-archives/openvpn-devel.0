From: David Sommerseth <davids@...515...>
Date: Tue, 25 Jul 2017 17:07:23 +0200
Message-Id: <20170725150723.14919-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] cleanup: Move init_random_seed() to where
 it is being used
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

The init_random_seed() function is only used by the init_static() in
init.c.  As this function was pretty basic and it is only being called
once, it was merged into init_static() instead of keeping it as a separate
function.

(I agree that calling functions often makes the code more readable, but
I would rather see that as a part of cleaning up the whole init_static()
function - in fact when moving all "unit tests" in init_static() to cmocka,
it will not be too bad in the end.)

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/init.c | 17 +++++++++++++++--
 src/openvpn/misc.c | 19 -------------------
 src/openvpn/misc.h |  3 ---
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bc3b81e3..860df774 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -610,6 +610,7 @@ init_port_share(struct context *c)
 
 #endif /* if PORT_SHARE */
 
+
 bool
 init_static(void)
 {
@@ -619,8 +620,20 @@ init_static(void)
     crypto_init_dmalloc();
 #endif
 
-    init_random_seed();         /* init random() function, only used as
-                                 * source for weak random numbers */
+
+    /*
+     * Initialize random number seed.  random() is only used
+     * when "weak" random numbers are acceptable.
+     * SSL library routines are always used when cryptographically
+     * strong random numbers are required.
+     */
+    struct timeval tv;
+    if (!gettimeofday(&tv, NULL))
+    {
+        const unsigned int seed = (unsigned int) tv.tv_sec ^ tv.tv_usec;
+        srandom(seed);
+    }
+
     error_reset();              /* initialize error.c */
     reset_check_status();       /* initialize status check code in socket.c */
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 8a76bba8..aff1bb2e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -405,25 +405,6 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
 
 
 /*
- * Initialize random number seed.  random() is only used
- * when "weak" random numbers are acceptable.
- * OpenSSL routines are always used when cryptographically
- * strong random numbers are required.
- */
-
-void
-init_random_seed(void)
-{
-    struct timeval tv;
-
-    if (!gettimeofday(&tv, NULL))
-    {
-        const unsigned int seed = (unsigned int) tv.tv_sec ^ tv.tv_usec;
-        srandom(seed);
-    }
-}
-
-/*
  * Set environmental variable (int or string).
  *
  * On Posix, we use putenv for portability,
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 734e679c..a7aa7622 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -100,9 +100,6 @@ void set_std_files_to_null(bool stdin_only);
 extern int inetd_socket_descriptor;
 void save_inetd_socket_descriptor(void);
 
-/* init random() function, only used as source for weak random numbers, when !ENABLE_CRYPTO */
-void init_random_seed(void);
-
 /* set/delete environmental variable */
 void setenv_str_ex(struct env_set *es,
                    const char *name,
-- 
2.11.0


