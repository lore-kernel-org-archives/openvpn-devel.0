From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 16:00:41 +0000
In-Reply-To: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
References: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <4d4da3d43c5e168bdbd202892123918e898e2a23-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="upRa6bq7/rg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sitnl: Clean up type
 handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--upRa6bq7/rg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
51?usp=3Demail )

Change subject: sitnl: Clean up type handling
......................................................................

sitnl: Clean up type handling

- Make some type casts explicit. Due to the types used
  in our networking API and the netlink APIs respectively
  this can't be avoided.
- In many cases just use correct types from the start, e.g.
  where we use constants anyway.

Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1251
Message-Id: <20251007122747.16064-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243289/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 46 insertions(+), 49 deletions(-)




diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 1815faf..b3adb16 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -59,9 +59,9 @@
         _nest;                                          \
     })

-#define SITNL_NEST_END(_msg, _nest)                                      \
-    {                                                                    \
-        _nest->rta_len =3D (void *)sitnl_nlmsg_tail(_msg) - (void *)_nest;=
 \
+#define SITNL_NEST_END(_msg, _nest)                                       =
                 \
+    {                                                                     =
                 \
+        _nest->rta_len =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg)=
 - (void *)_nest); \
     }

 /* This function was originally implemented as a macro, but compiling with
@@ -131,29 +131,24 @@
     inet_address_t gw;
 };

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Helper function used to easily add attributes to a rtnl message
  */
 static int
-sitnl_addattr(struct nlmsghdr *n, int maxlen, int type, const void *data, =
int alen)
+sitnl_addattr(struct nlmsghdr *n, size_t maxlen, unsigned short type, cons=
t void *data, size_t alen)
 {
-    int len =3D RTA_LENGTH(alen);
-    struct rtattr *rta;
+    size_t len =3D RTA_LENGTH(alen);

-    if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)
+    if ((NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)
     {
-        msg(M_WARN, "%s: rtnl: message exceeded bound of %d", __func__, ma=
xlen);
+        msg(M_WARN, "%s: rtnl: message exceeded bound of %zu", __func__, m=
axlen);
         return -EMSGSIZE;
     }

-    rta =3D sitnl_nlmsg_tail(n);
+    struct rtattr *rta =3D sitnl_nlmsg_tail(n);
     rta->rta_type =3D type;
-    rta->rta_len =3D len;
+    ASSERT(len <=3D USHRT_MAX);
+    rta->rta_len =3D (unsigned short)len;

     if (!data)
     {
@@ -252,11 +247,10 @@
 sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups, sitn=
l_parse_reply_cb cb,
            void *arg_cb)
 {
-    int len, rem_len, fd, ret, rcv_len;
+    int fd, ret;
     struct sockaddr_nl nladdr;
     struct nlmsgerr *err;
     struct nlmsghdr *h;
-    unsigned int seq;
     char buf[1024 * 16];
     struct iovec iov =3D {
         .iov_base =3D payload,
@@ -275,7 +269,11 @@
     nladdr.nl_pid =3D peer;
     nladdr.nl_groups =3D groups;

-    payload->nlmsg_seq =3D seq =3D time(NULL);
+    /* NB: We currently do not verify seq and pid on answers.
+     * If we ever want to start with that we probably need to come up
+     * with something better than "seconds since epoch"...
+     */
+    payload->nlmsg_seq =3D (uint32_t)time(NULL);

     /* no need to send reply */
     if (!cb)
@@ -290,16 +288,14 @@
         return -errno;
     }

-    ret =3D sitnl_bind(fd, 0);
-    if (ret < 0)
+    if (sitnl_bind(fd, 0) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
         ret =3D -errno;
         goto out;
     }

-    ret =3D sendmsg(fd, &nlmsg, 0);
-    if (ret < 0)
+    if (sendmsg(fd, &nlmsg, 0) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: error on sendmsg()", __func__);
         ret =3D -errno;
@@ -318,8 +314,8 @@
          */
         msg(D_RTNL, "%s: checking for received messages", __func__);
         iov.iov_len =3D sizeof(buf);
-        rcv_len =3D recvmsg(fd, &nlmsg, 0);
-        msg(D_RTNL, "%s: rtnl: received %d bytes", __func__, rcv_len);
+        ssize_t rcv_len =3D recvmsg(fd, &nlmsg, 0);
+        msg(D_RTNL, "%s: rtnl: received %zd bytes", __func__, rcv_len);
         if (rcv_len < 0)
         {
             if ((errno =3D=3D EINTR) || (errno =3D=3D EAGAIN))
@@ -350,8 +346,8 @@
         h =3D (struct nlmsghdr *)buf;
         while (rcv_len >=3D (int)sizeof(*h))
         {
-            len =3D h->nlmsg_len;
-            rem_len =3D len - sizeof(*h);
+            uint32_t len =3D h->nlmsg_len;
+            ssize_t rem_len =3D len - sizeof(*h);

             if ((rem_len < 0) || (len > rcv_len))
             {
@@ -361,7 +357,7 @@
                     ret =3D -EIO;
                     goto out;
                 }
-                msg(M_WARN, "%s: malformed message: len=3D%d", __func__, l=
en);
+                msg(M_WARN, "%s: malformed message: len=3D%u", __func__, l=
en);
                 ret =3D -EIO;
                 goto out;
             }
@@ -388,7 +384,7 @@
             if (h->nlmsg_type =3D=3D NLMSG_ERROR)
             {
                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < (int)sizeof(struct nlmsgerr))
+                if (rem_len < sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret =3D -EIO;
@@ -443,7 +439,7 @@

         if (rcv_len)
         {
-            msg(M_WARN, "%s: rtnl: %d not parsed bytes", __func__, rcv_len=
);
+            msg(M_WARN, "%s: rtnl: %zd not parsed bytes", __func__, rcv_le=
n);
             ret =3D -1;
             goto out;
         }
@@ -456,7 +452,7 @@

 typedef struct
 {
-    int addr_size;
+    size_t addr_size;
     inet_address_t gw;
     char iface[IFNAMSIZ];
     bool default_only;
@@ -469,7 +465,7 @@
     route_res_t *res =3D arg;
     struct rtmsg *r =3D NLMSG_DATA(n);
     struct rtattr *rta =3D RTM_RTA(r);
-    int len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
+    size_t len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
     void *gw =3D NULL;

@@ -547,7 +543,8 @@
     req.n.nlmsg_type =3D RTM_GETROUTE;
     req.n.nlmsg_flags =3D NLM_F_REQUEST;

-    req.r.rtm_family =3D af_family;
+    ASSERT(af_family <=3D UCHAR_MAX);
+    req.r.rtm_family =3D (unsigned char)af_family;

     switch (af_family)
     {
@@ -761,7 +758,7 @@
 }

 static int
-sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,
                const inet_address_t *local, const inet_address_t *remote, =
int prefixlen)
 {
     struct sitnl_addr_req req;
@@ -775,7 +772,8 @@
     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;

     req.i.ifa_index =3D ifindex;
-    req.i.ifa_family =3D af_family;
+    ASSERT(af_family <=3D UINT8_MAX);
+    req.i.ifa_family =3D (uint8_t)af_family;

     switch (af_family)
     {
@@ -797,7 +795,8 @@
     {
         prefixlen =3D size * 8;
     }
-    req.i.ifa_prefixlen =3D prefixlen;
+    ASSERT(prefixlen <=3D UINT8_MAX);
+    req.i.ifa_prefixlen =3D (uint8_t)prefixlen;

     if (remote)
     {
@@ -890,9 +889,9 @@
 }

 static int
-sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_famil=
y, const void *dst,
+sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_=
family, const void *dst,
                 int prefixlen, const void *gw, enum rt_class_t table, int =
metric,
-                enum rt_scope_t scope, int protocol, int type)
+                enum rt_scope_t scope, unsigned char protocol, unsigned ch=
ar type)
 {
     struct sitnl_route_req req;
     int ret =3D -1, size;
@@ -917,15 +916,17 @@
     req.n.nlmsg_type =3D cmd;
     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;

-    req.r.rtm_family =3D af_family;
-    req.r.rtm_scope =3D scope;
+    ASSERT(af_family <=3D UCHAR_MAX);
+    req.r.rtm_family =3D (unsigned char)af_family;
+    req.r.rtm_scope =3D (unsigned char)scope;
     req.r.rtm_protocol =3D protocol;
     req.r.rtm_type =3D type;
-    req.r.rtm_dst_len =3D prefixlen;
+    ASSERT(prefixlen >=3D 0 && prefixlen <=3D UCHAR_MAX);
+    req.r.rtm_dst_len =3D (unsigned char)prefixlen;

-    if (table < 256)
+    if (table <=3D UCHAR_MAX)
     {
-        req.r.rtm_table =3D table;
+        req.r.rtm_table =3D (unsigned char)table;
     }
     else
     {
@@ -1348,7 +1349,7 @@
 }

 static int
-sitnl_parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,=
 int len,
+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len,
                          unsigned short flags)
 {
     unsigned short type;
@@ -1369,14 +1370,14 @@

     if (len)
     {
-        msg(D_ROUTE, "%s: %d bytes not parsed! (rta_len=3D%d)", __func__, =
len, rta->rta_len);
+        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__,=
 len, rta->rta_len);
     }

     return 0;
 }

 static int
-sitnl_parse_rtattr(struct rtattr *tb[], int max, struct rtattr *rta, int l=
en)
+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, si=
ze_t len)
 {
     return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
 }
@@ -1474,10 +1475,6 @@
     return sitnl_send(&req.n, 0, 0, NULL, NULL);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* !ENABLE_SITNL */

 #endif /* TARGET_LINUX */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc
Gerrit-Change-Number: 1251
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--upRa6bq7/rg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1251?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">sitnl: Clean up type handling<br><br>- Make some=
 type casts explicit. Due to the types used<br>  in our networking API and =
the netlink APIs respectively<br>  this can&#39;t be avoided.<br>- In many =
cases just use correct types from the start, e.g.<br>  where we use constan=
ts anyway.<br><br>Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Anton=
io Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: https://gerrit.openv=
pn.net/c/openvpn/+/1251<br>Message-Id: &lt;20251007122747.16064-1-gert@...1386...=
296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/592432=
89/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/networking_sitnl.c<br>1 file changed, 46 insertions(+), 49 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sit=
nl.c</span><br><span>index 1815faf..b3adb16 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_s=
itnl.c</span><br><span>@@ -59,9 +59,9 @@</span><br><span>         _nest;   =
                                       \</span><br><span>     })</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SITNL_=
NEST_END(_msg, _nest)                                      \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {                               =
                                     \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        _nest-&gt;rta_len =3D (void *)sitnl_nlmsg_tail(_ms=
g) - (void *)_nest; \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define SITNL_NEST_END(_msg, _nest)                                      =
                  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {                                                                      =
                \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      _nest-&gt;rta_len =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg)=
 - (void *)_nest); \</span><br><span>     }</span><br><span> </span><br><sp=
an> /* This function was originally implemented as a macro, but compiling w=
ith</span><br><span>@@ -131,29 +131,24 @@</span><br><span>     inet_address=
_t gw;</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /**</span><br><span>  * Helper function used to easily add att=
ributes to a rtnl message</span><br><span>  */</span><br><span> static int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addattr(struct n=
lmsghdr *n, int maxlen, int type, const void *data, int alen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+sitnl_addattr(struct nlmsghdr *n,=
 size_t maxlen, unsigned short type, const void *data, size_t alen)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int le=
n =3D RTA_LENGTH(alen);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct rtattr *rta;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t len =3D RTA_LENGTH(alen);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if ((int)(NLMSG_ALIGN(n-&gt;nlms=
g_len) + RTA_ALIGN(len)) &gt; maxlen)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if ((NLMSG_ALIGN(n-&gt;nlmsg_len) + RTA_ALIGN(len)) &=
gt; maxlen)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        msg(M_WARN, &quot;%s: rtnl: message exceeded bound of =
%d&quot;, __func__, maxlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;%s: rtnl: message exceeded bound of %zu&=
quot;, __func__, maxlen);</span><br><span>         return -EMSGSIZE;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    rta =3D sitnl_nlmsg_tail(n);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct rtattr *rta =3D sitnl_nlmsg_tail(n);</=
span><br><span>     rta-&gt;rta_type =3D type;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    rta-&gt;rta_len =3D len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D USHRT_MAX);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rta-&gt;rta_len =3D (u=
nsigned short)len;</span><br><span> </span><br><span>     if (!data)</span>=
<br><span>     {</span><br><span>@@ -252,11 +247,10 @@</span><br><span> sit=
nl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups, sitnl_pa=
rse_reply_cb cb,</span><br><span>            void *arg_cb)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len, rem_le=
n, fd, ret, rcv_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int fd, ret;</span><br><span>     struct sockaddr_nl nladdr;</span><br=
><span>     struct nlmsgerr *err;</span><br><span>     struct nlmsghdr *h;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int seq;<=
/span><br><span>     char buf[1024 * 16];</span><br><span>     struct iovec=
 iov =3D {</span><br><span>         .iov_base =3D payload,</span><br><span>=
@@ -275,7 +269,11 @@</span><br><span>     nladdr.nl_pid =3D peer;</span><br=
><span>     nladdr.nl_groups =3D groups;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    payload-&gt;nlmsg_seq =3D seq =3D =
time(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* N=
B: We currently do not verify seq and pid on answers.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * If we ever want to start with that=
 we probably need to come up</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * with something better than &quot;seconds since epoch&quot;.=
..</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    payload-&gt;nlmsg_seq =3D=
 (uint32_t)time(NULL);</span><br><span> </span><br><span>     /* no need to=
 send reply */</span><br><span>     if (!cb)</span><br><span>@@ -290,16 +28=
8,14 @@</span><br><span>         return -errno;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =
=3D sitnl_bind(fd, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (sitnl_bind(fd, 0) &lt; 0)</span><br><span>     {</span><br><span> =
        msg(M_WARN | M_ERRNO, &quot;%s: can&#39;t bind rtnl socket&quot;, _=
_func__);</span><br><span>         ret =3D -errno;</span><br><span>        =
 goto out;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D sendmsg(fd, &amp;nlmsg, 0);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sendmsg(fd, &amp;=
nlmsg, 0) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_WAR=
N | M_ERRNO, &quot;%s: rtnl: error on sendmsg()&quot;, __func__);</span><br=
><span>         ret =3D -errno;</span><br><span>@@ -318,8 +314,8 @@</span><=
br><span>          */</span><br><span>         msg(D_RTNL, &quot;%s: checki=
ng for received messages&quot;, __func__);</span><br><span>         iov.iov=
_len =3D sizeof(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        rcv_len =3D recvmsg(fd, &amp;nlmsg, 0);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_RTNL, &quot;%s: rtnl: received %d b=
ytes&quot;, __func__, rcv_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ssize_t rcv_len =3D recvmsg(fd, &amp;nlmsg, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_RTNL, &quot;%=
s: rtnl: received %zd bytes&quot;, __func__, rcv_len);</span><br><span>    =
     if (rcv_len &lt; 0)</span><br><span>         {</span><br><span>       =
      if ((errno =3D=3D EINTR) || (errno =3D=3D EAGAIN))</span><br><span>@@=
 -350,8 +346,8 @@</span><br><span>         h =3D (struct nlmsghdr *)buf;</s=
pan><br><span>         while (rcv_len &gt;=3D (int)sizeof(*h))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     len =3D h-&gt;nlmsg_len;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            rem_len =3D len - sizeof(*h);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            uint32_t len =3D h-&gt;nlmsg_len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ssize_t=
 rem_len =3D len - sizeof(*h);</span><br><span> </span><br><span>          =
   if ((rem_len &lt; 0) || (len &gt; rcv_len))</span><br><span>            =
 {</span><br><span>@@ -361,7 +357,7 @@</span><br><span>                    =
 ret =3D -EIO;</span><br><span>                     goto out;</span><br><sp=
an>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                msg(M_WARN, &quot;%s: malformed message: len=3D%d&quot;, __=
func__, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(M_WARN, &quot;%s: malformed message: len=3D%u&quot;, __func__=
, len);</span><br><span>                 ret =3D -EIO;</span><br><span>    =
             goto out;</span><br><span>             }</span><br><span>@@ -3=
88,7 +384,7 @@</span><br><span>             if (h-&gt;nlmsg_type =3D=3D NLM=
SG_ERROR)</span><br><span>             {</span><br><span>                 e=
rr =3D (struct nlmsgerr *)NLMSG_DATA(h);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                if (rem_len &lt; (int)sizeof(struct nlms=
gerr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (rem_len &lt; sizeof(struct nlmsgerr))</span><br><span>              =
   {</span><br><span>                     msg(M_WARN, &quot;%s: ERROR trunc=
ated&quot;, __func__);</span><br><span>                     ret =3D -EIO;</=
span><br><span>@@ -443,7 +439,7 @@</span><br><span> </span><br><span>      =
   if (rcv_len)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: rtnl: %d not parsed =
bytes&quot;, __func__, rcv_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_WARN, &quot;%s: rtnl: %zd not parsed bytes&q=
uot;, __func__, rcv_len);</span><br><span>             ret =3D -1;</span><b=
r><span>             goto out;</span><br><span>         }</span><br><span>@=
@ -456,7 +452,7 @@</span><br><span> </span><br><span> typedef struct</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int a=
ddr_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 addr_size;</span><br><span>     inet_address_t gw;</span><br><span>     ch=
ar iface[IFNAMSIZ];</span><br><span>     bool default_only;</span><br><span=
>@@ -469,7 +465,7 @@</span><br><span>     route_res_t *res =3D arg;</span><=
br><span>     struct rtmsg *r =3D NLMSG_DATA(n);</span><br><span>     struc=
t rtattr *rta =3D RTM_RTA(r);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int len =3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D n-&gt;nl=
msg_len - NLMSG_LENGTH(sizeof(*r));</span><br><span>     unsigned int table=
, ifindex =3D 0;</span><br><span>     void *gw =3D NULL;</span><br><span> <=
/span><br><span>@@ -547,7 +543,8 @@</span><br><span>     req.n.nlmsg_type =
=3D RTM_GETROUTE;</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 req.r.rtm_family =3D af_family;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(af_family &lt;=3D UCHAR_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_family =3D (unsigned char)a=
f_family;</span><br><span> </span><br><span>     switch (af_family)</span><=
br><span>     {</span><br><span>@@ -761,7 +758,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa=
_family_t af_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,</span><br><span>                const inet_address_t *local, const i=
net_address_t *remote, int prefixlen)</span><br><span> {</span><br><span>  =
   struct sitnl_addr_req req;</span><br><span>@@ -775,7 +772,8 @@</span><br=
><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><span> <=
/span><br><span>     req.i.ifa_index =3D ifindex;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    req.i.ifa_family =3D af_family;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(af_family &lt;=3D UI=
NT8_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.i.=
ifa_family =3D (uint8_t)af_family;</span><br><span> </span><br><span>     s=
witch (af_family)</span><br><span>     {</span><br><span>@@ -797,7 +795,8 @=
@</span><br><span>     {</span><br><span>         prefixlen =3D size * 8;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    req.i.ifa_prefixlen =3D prefixlen;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(prefixlen &lt;=3D UINT8_MAX);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    req.i.ifa_prefixlen =3D (uint8_=
t)prefixlen;</span><br><span> </span><br><span>     if (remote)</span><br><=
span>     {</span><br><span>@@ -890,9 +889,9 @@</span><br><span> }</span><b=
r><span> </span><br><span> static int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_fa=
mily_t af_family, const void *dst,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, s=
a_family_t af_family, const void *dst,</span><br><span>                 int=
 prefixlen, const void *gw, enum rt_class_t table, int metric,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                enum rt_scope_t sc=
ope, int protocol, int type)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                enum rt_scope_t scope, unsigned char protocol, uns=
igned char type)</span><br><span> {</span><br><span>     struct sitnl_route=
_req req;</span><br><span>     int ret =3D -1, size;</span><br><span>@@ -91=
7,15 +916,17 @@</span><br><span>     req.n.nlmsg_type =3D cmd;</span><br><s=
pan>     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    req.r.rtm_family =3D =
af_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req.r.r=
tm_scope =3D scope;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(af_family &lt;=3D UCHAR_MAX);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    req.r.rtm_family =3D (unsigned char)af_family;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_scope =3D=
 (unsigned char)scope;</span><br><span>     req.r.rtm_protocol =3D protocol=
;</span><br><span>     req.r.rtm_type =3D type;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    req.r.rtm_dst_len =3D prefixlen;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(prefixlen &gt;=3D 0 &=
amp;&amp; prefixlen &lt;=3D UCHAR_MAX);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    req.r.rtm_dst_len =3D (unsigned char)prefixlen;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(table &lt; 256)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (table &lt;=3D UCHAR_MAX)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        req.r.rtm_table =3D table;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        req.r.rtm_table =3D =
(unsigned char)table;</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span>@@ -1348,7 +1349,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-sitnl_parse_rtattr_flags(struct rtattr *tb[], int =
max, struct rtattr *rta, int len,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, str=
uct rtattr *rta, size_t len,</span><br><span>                          unsi=
gned short flags)</span><br><span> {</span><br><span>     unsigned short ty=
pe;</span><br><span>@@ -1369,14 +1370,14 @@</span><br><span> </span><br><sp=
an>     if (len)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(D_ROUTE, &quot;%s: %d bytes not parsed! (rta_=
len=3D%d)&quot;, __func__, len, rta-&gt;rta_len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;%s: %zu bytes not =
parsed! (rta_len=3D%u)&quot;, __func__, len, rta-&gt;rta_len);</span><br><s=
pan>     }</span><br><span> </span><br><span>     return 0;</span><br><span=
> }</span><br><span> </span><br><span> static int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr(struct rtattr *tb[], int max=
, struct rtattr *rta, int len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtatt=
r *rta, size_t len)</span><br><span> {</span><br><span>     return sitnl_pa=
rse_rtattr_flags(tb, max, rta, len, 0);</span><br><span> }</span><br><span>=
@@ -1474,10 +1475,6 @@</span><br><span>     return sitnl_send(&amp;req.n, 0=
, 0, NULL, NULL);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* !E=
NABLE_SITNL */</span><br><span> </span><br><span> #endif /* TARGET_LINUX */=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1251?usp=3Demail">change 1251</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1251?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f3=
99961f5b74fcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1251 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--upRa6bq7/rg=--

