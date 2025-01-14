From: Gert Doering <gert@...1296...>
Date: Tue, 14 Jan 2025 17:52:06 +0100
Message-ID: <20250114165206.13187-1-gert@...1296...>
In-Reply-To: <gerrit.1736860439000.I1918c43202b87f0c987bfd9155c739da7dd02632@...2715...>
References: <gerrit.1736860439000.I1918c43202b87f0c987bfd9155c739da7dd02632@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix some trivial sign-compare compiler
 warnings
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

From: Frank Lichtenheld <frank@...2641...>

Change-Id: I1918c43202b87f0c987bfd9155c739da7dd02632
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/865
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1113663..b594b09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1448,7 +1448,7 @@
 
     while (server)
     {
-        for (int i = 0; i < server->addr_count; ++i)
+        for (size_t i = 0; i < server->addr_count; ++i)
         {
             if (server->addr[i].family == AF_INET)
             {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 234d590..4aeb613 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3131,8 +3131,7 @@
 int
 ascii2proto(const char *proto_name)
 {
-    int i;
-    for (i = 0; i < SIZE(proto_names); ++i)
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3145,8 +3144,7 @@
 sa_family_t
 ascii2af(const char *proto_name)
 {
-    int i;
-    for (i = 0; i < SIZE(proto_names); ++i)
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3159,8 +3157,7 @@
 const char *
 proto2ascii(int proto, sa_family_t af, bool display_form)
 {
-    unsigned int i;
-    for (i = 0; i < SIZE(proto_names); ++i)
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
     {
         if (proto_names[i].proto_af == af && proto_names[i].proto == proto)
         {
@@ -3182,9 +3179,8 @@
 proto2ascii_all(struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
-    int i;
 
-    for (i = 0; i < SIZE(proto_names); ++i)
+    for (size_t i = 0; i < SIZE(proto_names); ++i)
     {
         if (i)
         {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3f2ec4a..22706f3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -631,7 +631,7 @@
 {
     struct gc_arena gc = gc_new();
     struct route_gateway_info rgi;
-    const int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    const unsigned int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
 
     get_default_gateway(&rgi, ctx);
     if ((rgi.flags & needed) == needed)

