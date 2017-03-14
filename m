From: Stephan Kunz <Stephan.Kunz@...2254...>
Date: Tue, 14 Mar 2017 12:27:18 +0100
Message-ID: <1489490838-6570-1-git-send-email-Stephan.Kunz@...2254...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] This patch implements the command kill
	addr:port for mixed ipv4 and ipv6.
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

The old command was only working for ipv4 and we needed the possibility to
also kill other addresses. I did throw away the old parsing by ':' and now
search for the last occurrence of a colon. If a colon is found the part after
the colon is parsed and checked if it is a valid port. If this is the case I
check via pton if the address is v4 or v6 and fill the openvpn_sockaddr
accordingly. If not I assume we have a cn.

The patch supports following kill-commands:
kill ipv6:port, kill ::ffff:ipv4:port, kill ipv4:port, kill cn

Signed-off-by: Stephan Kunz <Stephan.Kunz@...2254...>
---
 src/openvpn/buffer.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/buffer.h | 27 +++++++++++++++
 src/openvpn/manage.c | 89 ++++++++++++++++++++++++++++++-------------------
 src/openvpn/manage.h |  2 +-
 src/openvpn/multi.c  | 18 ++++------
 5 files changed, 183 insertions(+), 47 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 2defd18..1c0ac81 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -828,6 +828,100 @@ buf_parse(struct buffer *buf, const int delim, char *line, const int size)
 }
 
 /*
+ * parses string for the last occurance of a given delim
+ */
+int
+find_last_occurence_of_delim(struct buffer *buf, const int delim)
+{
+    bool found = false;
+
+    int idx = buf->len;
+    int delim_index = 0;
+
+    while (idx > 0 && !found)
+    {
+        delim_index = buf_read_u8_at_idx(buf, --idx);
+        if (delim_index == delim)
+        {
+            found = true;
+        }
+    }
+
+    if (!found)
+    {
+        return -1;
+    }
+
+    return idx;
+}
+
+/*
+ * String parsing from a given index to the eol
+ */
+bool
+buf_parse_from_idx(struct buffer *buf, const int start_idx, char *line, const int size)
+{
+    bool eol = false;
+
+    int idx = start_idx;
+    int n = 0;
+    int c;
+
+    ASSERT (size > 0);
+
+    do
+    {
+        c = buf_read_u8_at_idx(buf, idx++);
+        if (c < 0)
+        {
+            eol = true;
+            c = 0;
+        }
+        if (n >= size)
+        {
+            break;
+        }
+        line[n++] = c;
+    }
+    while (c);
+
+    line[size-1] = '\0';
+    return !(eol && !strlen (line));
+}
+
+/*
+ * String parsing from beginning to given index
+ */
+bool
+buf_parse_to_idx(struct buffer *buf, const int stop_idx, char *line, const int size)
+{
+    bool eol = false;
+    int n = 0;
+    int c;
+
+    ASSERT (size > 0);
+
+    do
+    {
+        c = buf_read_u8(buf);
+        if (c < 0)
+        {
+            eol = true;
+            c = 0;
+        }
+        if (n >= size)
+        {
+            break;
+        }
+        line[n++] = c;
+    }
+    while (c && buf->offset < stop_idx);
+
+    line[buf->offset] = '\0';
+    return !(eol && !strlen (line));
+}
+
+/*
  * Print a string which might be NULL
  */
 const char *
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 28b224e..851e923 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -486,6 +486,21 @@ void convert_to_one_line(struct buffer *buf);
 bool buf_parse(struct buffer *buf, const int delim, char *line, const int size);
 
 /*
+ * Parse a string from end to beginning based on a given delimiter char
+ */
+bool buf_parse_from_idx (struct buffer *buf, const int start_idx, char *line, const int size);
+
+/*
+ * String parsing from beginning to given index
+ */
+bool buf_parse_to_idx (struct buffer *buf, const int stop_idx, char *line, const int size);
+
+/*
+ * looks for the last occurence of a given delimiter char
+ */
+int find_last_occurence_of_delim (struct buffer *buf, const int delim);
+
+/*
  * Hex dump -- Output a binary buffer to a hex string and return it.
  */
 #define FHE_SPACE_BREAK_MASK 0xFF /* space_break parameter in lower 8 bits */
@@ -782,6 +797,18 @@ buf_read(struct buffer *src, void *dest, int size)
 }
 
 static inline int
+buf_read_u8_at_idx(struct buffer *buf, int idx)
+{
+    int ret;
+    if (BLEN (buf) < 1 || BLEN (buf) < idx)
+    {
+        return -1;
+    }
+    ret = *(buf->data+idx);
+    return ret;
+}
+
+static inline int
 buf_read_u8(struct buffer *buf)
 {
     int ret;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 763f6c6..1ea49be 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -508,50 +508,73 @@ man_kill(struct management *man, const char *victim)
     if (man->persist.callback.kill_by_cn && man->persist.callback.kill_by_addr)
     {
         struct buffer buf;
+        struct openvpn_sockaddr saddr;
         char p1[128];
         char p2[128];
         int n_killed;
+        int last_delim;
+        bool cn = false;
+        int port;
 
         buf_set_read(&buf, (uint8_t *) victim, strlen(victim) + 1);
-        buf_parse(&buf, ':', p1, sizeof(p1));
-        buf_parse(&buf, ':', p2, sizeof(p2));
+        last_delim = find_last_occurence_of_delim (&buf, ':');
+        if (last_delim != -1)
+        {
+            // parse from delim+1
+            buf_parse_from_idx(&buf, last_delim+1, p2, sizeof (p2));
+            port = atoi(p2);
+            // Check if port is in range
+            if ((strlen (p2) <= 5) && (port > 0 && port < 65536))
+            {
+                // if port seems correct we parse for ip, need to
+                buf_parse_to_idx(&buf, last_delim, p1, sizeof (p1));
+            }
+            else
+            {
+                // port seems wrong so we might have a cn here
+                buf_parse(&buf, -1, p1, sizeof (p1));
+                cn = true;
+            }
+        }
+        else
+        {
+            // as we do not found a delimiter we assume we have a cn
+            buf_parse(&buf, -1, p1, sizeof (p1));
+            cn = true;
+        }
 
-        if (strlen(p1) && strlen(p2))
+        CLEAR (saddr);
+        // Check if address is v4
+        if (!cn && inet_pton(AF_INET, p1, &(saddr.addr.in4.sin_addr)))
         {
-            /* IP:port specified */
-            bool status;
-            const in_addr_t addr = getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p1, 0, &status, NULL);
-            if (status)
+            saddr.addr.in4.sin_family = AF_INET;
+            saddr.addr.in4.sin_port = htons(port);
+        }
+        // Check if address is v6
+        else if (!cn && inet_pton(AF_INET6, p1, &(saddr.addr.in6.sin6_addr)))
+        {
+            saddr.addr.in6.sin6_family = AF_INET6;
+            saddr.addr.in6.sin6_port = htons(port);
+        }
+
+        if (!cn)
+        {
+            n_killed = (*man->persist.callback.kill_by_addr) (man->persist.callback.arg, &saddr);
+            if (n_killed > 0)
             {
-                const int port = atoi(p2);
-                if (port > 0 && port < 65536)
-                {
-                    n_killed = (*man->persist.callback.kill_by_addr)(man->persist.callback.arg, addr, port);
-                    if (n_killed > 0)
-                    {
-                        msg(M_CLIENT, "SUCCESS: %d client(s) at address %s:%d killed",
-                            n_killed,
-                            print_in_addr_t(addr, 0, &gc),
-                            port);
-                    }
-                    else
-                    {
-                        msg(M_CLIENT, "ERROR: client at address %s:%d not found",
-                            print_in_addr_t(addr, 0, &gc),
-                            port);
-                    }
-                }
-                else
-                {
-                    msg(M_CLIENT, "ERROR: port number is out of range: %s", p2);
-                }
+                msg(M_CLIENT, "SUCCESS: %d client(s) at address %s:%d killed",
+                    n_killed,
+                    p1,
+                    port);
             }
             else
             {
-                msg(M_CLIENT, "ERROR: error parsing IP address: %s", p1);
+                msg(M_CLIENT, "ERROR: client at address %s:%d not found",
+                    p1,
+                    port);
             }
         }
-        else if (strlen(p1))
+        else
         {
             /* common name specified */
             n_killed = (*man->persist.callback.kill_by_cn)(man->persist.callback.arg, p1);
@@ -564,10 +587,6 @@ man_kill(struct management *man, const char *victim)
                 msg(M_CLIENT, "ERROR: common name '%s' not found", p1);
             }
         }
-        else
-        {
-            msg(M_CLIENT, "ERROR: kill parse");
-        }
     }
     else
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 6e5cb9b..e143e2d 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -162,7 +162,7 @@ struct management_callback
     void (*status) (void *arg, const int version, struct status_output *so);
     void (*show_net) (void *arg, const int msglevel);
     int (*kill_by_cn) (void *arg, const char *common_name);
-    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port);
+    int (*kill_by_addr) (void *arg, struct openvpn_sockaddr *saddr);
     void (*delete_event) (void *arg, event_t event);
     int (*n_clients) (void *arg);
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f6f3f5d..93f0f6c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3157,23 +3157,18 @@ management_callback_kill_by_cn(void *arg, const char *del_cn)
 }
 
 static int
-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const int port)
+management_callback_kill_by_addr(void *arg, struct openvpn_sockaddr *saddr)
 {
     struct multi_context *m = (struct multi_context *) arg;
     struct hash_iterator hi;
     struct hash_element *he;
-    struct openvpn_sockaddr saddr;
     struct mroute_addr maddr;
     int count = 0;
 
-    CLEAR(saddr);
-    saddr.addr.in4.sin_family = AF_INET;
-    saddr.addr.in4.sin_addr.s_addr = htonl(addr);
-    saddr.addr.in4.sin_port = htons(port);
-    if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
+    if (mroute_extract_openvpn_sockaddr(&maddr, saddr, true))
     {
-        hash_iterator_init(m->iter, &hi);
-        while ((he = hash_iterator_next(&hi)))
+        hash_iterator_init (m->iter, &hi);
+        while ((he = hash_iterator_next (&hi)))
         {
             struct multi_instance *mi = (struct multi_instance *) he->value;
             if (!mi->halt && mroute_addr_equal(&maddr, &mi->real))
@@ -3182,8 +3177,9 @@ management_callback_kill_by_addr(void *arg, const in_addr_t addr, const int port
                 ++count;
             }
         }
-        hash_iterator_free(&hi);
-    }
+        hash_iterator_free (&hi);
+   }
+
     return count;
 }
 
-- 
1.8.2.3


