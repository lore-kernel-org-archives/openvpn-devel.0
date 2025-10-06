From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 15:55:29 +0000
In-Reply-To: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
References: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d95a8cfd0f8450bf7aef7f85e0015879ea1db7b1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vmDyOJEEsgg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vmDyOJEEsgg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail

to look at the new patch set (#2).


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
---
M src/openvpn/networking_sitnl.c
1 file changed, 45 insertions(+), 49 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1251/2

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 1815faf..bb1ec6a 100644
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
@@ -131,29 +131,23 @@
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
+    rta->rta_len =3D (unsigned short)len;

     if (!data)
     {
@@ -252,11 +246,10 @@
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
@@ -275,7 +268,11 @@
     nladdr.nl_pid =3D peer;
     nladdr.nl_groups =3D groups;

-    payload->nlmsg_seq =3D seq =3D time(NULL);
+    /* NB: We currently do not verify seq and pid on answers.
+       If we ever want to start with that we probably need to come up
+       with something better than "seconds since epoch"...
+     */
+    payload->nlmsg_seq =3D (uint32_t)time(NULL);

     /* no need to send reply */
     if (!cb)
@@ -290,16 +287,14 @@
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
@@ -318,8 +313,8 @@
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
@@ -350,8 +345,8 @@
         h =3D (struct nlmsghdr *)buf;
         while (rcv_len >=3D (int)sizeof(*h))
         {
-            len =3D h->nlmsg_len;
-            rem_len =3D len - sizeof(*h);
+            uint32_t len =3D h->nlmsg_len;
+            ssize_t rem_len =3D len - sizeof(*h);

             if ((rem_len < 0) || (len > rcv_len))
             {
@@ -361,7 +356,7 @@
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
@@ -388,7 +383,7 @@
             if (h->nlmsg_type =3D=3D NLMSG_ERROR)
             {
                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < (int)sizeof(struct nlmsgerr))
+                if (rem_len < sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret =3D -EIO;
@@ -443,7 +438,7 @@

         if (rcv_len)
         {
-            msg(M_WARN, "%s: rtnl: %d not parsed bytes", __func__, rcv_len=
);
+            msg(M_WARN, "%s: rtnl: %zd not parsed bytes", __func__, rcv_le=
n);
             ret =3D -1;
             goto out;
         }
@@ -456,7 +451,7 @@

 typedef struct
 {
-    int addr_size;
+    size_t addr_size;
     inet_address_t gw;
     char iface[IFNAMSIZ];
     bool default_only;
@@ -469,7 +464,7 @@
     route_res_t *res =3D arg;
     struct rtmsg *r =3D NLMSG_DATA(n);
     struct rtattr *rta =3D RTM_RTA(r);
-    int len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
+    size_t len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
     void *gw =3D NULL;

@@ -547,7 +542,8 @@
     req.n.nlmsg_type =3D RTM_GETROUTE;
     req.n.nlmsg_flags =3D NLM_F_REQUEST;

-    req.r.rtm_family =3D af_family;
+    ASSERT(af_family <=3D UCHAR_MAX);
+    req.r.rtm_family =3D (unsigned char)af_family;

     switch (af_family)
     {
@@ -761,7 +757,7 @@
 }

 static int
-sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,
                const inet_address_t *local, const inet_address_t *remote, =
int prefixlen)
 {
     struct sitnl_addr_req req;
@@ -775,7 +771,8 @@
     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;

     req.i.ifa_index =3D ifindex;
-    req.i.ifa_family =3D af_family;
+    ASSERT(af_family <=3D UINT8_MAX);
+    req.i.ifa_family =3D (uint8_t)af_family;

     switch (af_family)
     {
@@ -797,7 +794,8 @@
     {
         prefixlen =3D size * 8;
     }
-    req.i.ifa_prefixlen =3D prefixlen;
+    ASSERT(prefixlen <=3D UINT8_MAX);
+    req.i.ifa_prefixlen =3D (uint8_t)prefixlen;

     if (remote)
     {
@@ -890,9 +888,9 @@
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
@@ -917,15 +915,17 @@
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
@@ -1348,7 +1348,7 @@
 }

 static int
-sitnl_parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,=
 int len,
+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len,
                          unsigned short flags)
 {
     unsigned short type;
@@ -1369,14 +1369,14 @@

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
@@ -1474,10 +1474,6 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc
Gerrit-Change-Number: 1251
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--vmDyOJEEsgg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">sitnl: Clean up type handling<br><br>- Make some=
 type casts explicit. Due to the types used<br>  in our networking API and =
the netlink APIs respectively<br>  this can&#39;t be avoided.<br>- In many =
cases just use correct types from the start, e.g.<br>  where we use constan=
ts anyway.<br><br>Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/op=
envpn/networking_sitnl.c<br>1 file changed, 45 insertions(+), 49 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/51/1251/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=
.c b/src/openvpn/networking_sitnl.c</span><br><span>index 1815faf..bb1ec6a =
100644</span><br><span>--- a/src/openvpn/networking_sitnl.c</span><br><span=
>+++ b/src/openvpn/networking_sitnl.c</span><br><span>@@ -59,9 +59,9 @@</sp=
an><br><span>         _nest;                                          \</sp=
an><br><span>     })</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define SITNL_NEST_END(_msg, _nest)                       =
               \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
                                                                    \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        _nest-&gt;rta_len =
=3D (void *)sitnl_nlmsg_tail(_msg) - (void *)_nest; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SITNL_NEST_END(_msg, _nest)      =
                                                  \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {                                    =
                                                  \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        _nest-&gt;rta_len =3D (unsigned s=
hort)((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \</span><br><span>  =
   }</span><br><span> </span><br><span> /* This function was originally imp=
lemented as a macro, but compiling with</span><br><span>@@ -131,29 +131,23 =
@@</span><br><span>     inet_address_t gw;</span><br><span> };</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * H=
elper function used to easily add attributes to a rtnl message</span><br><s=
pan>  */</span><br><span> static int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-sitnl_addattr(struct nlmsghdr *n, int maxlen, int type, cons=
t void *data, int alen)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+sitnl_addattr(struct nlmsghdr *n, size_t maxlen, unsigned short type, c=
onst void *data, size_t alen)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int len =3D RTA_LENGTH(alen);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct rtattr *rta;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D RTA_LENGTH(al=
en);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if ((int)(NLMSG_ALIGN(n-&gt;nlmsg_len) + RTA_ALIGN(len)) &gt; maxlen)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((NLMSG_ALIGN=
(n-&gt;nlmsg_len) + RTA_ALIGN(len)) &gt; maxlen)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot=
;%s: rtnl: message exceeded bound of %d&quot;, __func__, maxlen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s:=
 rtnl: message exceeded bound of %zu&quot;, __func__, maxlen);</span><br><s=
pan>         return -EMSGSIZE;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    rta =3D sitnl_nlmsg_t=
ail(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct r=
tattr *rta =3D sitnl_nlmsg_tail(n);</span><br><span>     rta-&gt;rta_type =
=3D type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rta-&gt;=
rta_len =3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rta-&gt;rta_len =3D (unsigned short)len;</span><br><span> </span><br><span=
>     if (!data)</span><br><span>     {</span><br><span>@@ -252,11 +246,10 =
@@</span><br><span> sitnl_send(struct nlmsghdr *payload, pid_t peer, unsign=
ed int groups, sitnl_parse_reply_cb cb,</span><br><span>            void *a=
rg_cb)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int len, rem_len, fd, ret, rcv_len;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int fd, ret;</span><br><span>     struct sockad=
dr_nl nladdr;</span><br><span>     struct nlmsgerr *err;</span><br><span>  =
   struct nlmsghdr *h;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int seq;</span><br><span>     char buf[1024 * 16];</span><br>=
<span>     struct iovec iov =3D {</span><br><span>         .iov_base =3D pa=
yload,</span><br><span>@@ -275,7 +268,11 @@</span><br><span>     nladdr.nl_=
pid =3D peer;</span><br><span>     nladdr.nl_groups =3D groups;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    payload-&gt=
;nlmsg_seq =3D seq =3D time(NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* NB: We currently do not verify seq and pid on answers=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       If we ever =
want to start with that we probably need to come up</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       with something better than &quot;s=
econds since epoch&quot;...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
payload-&gt;nlmsg_seq =3D (uint32_t)time(NULL);</span><br><span> </span><br=
><span>     /* no need to send reply */</span><br><span>     if (!cb)</span=
><br><span>@@ -290,16 +287,14 @@</span><br><span>         return -errno;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ret =3D sitnl_bind(fd, 0);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (sitnl_bind(fd, 0) &lt; 0)</span><br><span=
>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: can&#39;t =
bind rtnl socket&quot;, __func__);</span><br><span>         ret =3D -errno;=
</span><br><span>         goto out;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D sendmsg(=
fd, &amp;nlmsg, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sendmsg(fd, &amp;nlmsg, 0) &lt; 0)</span><br><span>     {</span><br><=
span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: error on sendmsg()&quot=
;, __func__);</span><br><span>         ret =3D -errno;</span><br><span>@@ -=
318,8 +313,8 @@</span><br><span>          */</span><br><span>         msg(D=
_RTNL, &quot;%s: checking for received messages&quot;, __func__);</span><br=
><span>         iov.iov_len =3D sizeof(buf);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        rcv_len =3D recvmsg(fd, &amp;nlmsg, 0);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_RTNL, &quot;=
%s: rtnl: received %d bytes&quot;, __func__, rcv_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ssize_t rcv_len =3D recvmsg(fd, =
&amp;nlmsg, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_RTNL, &quot;%s: rtnl: received %zd bytes&quot;, __func__, rcv_len=
);</span><br><span>         if (rcv_len &lt; 0)</span><br><span>         {<=
/span><br><span>             if ((errno =3D=3D EINTR) || (errno =3D=3D EAGA=
IN))</span><br><span>@@ -350,8 +345,8 @@</span><br><span>         h =3D (st=
ruct nlmsghdr *)buf;</span><br><span>         while (rcv_len &gt;=3D (int)s=
izeof(*h))</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            len =3D h-&gt;nlmsg_len;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            rem_len =3D len - sizeof(*h);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint32_t =
len =3D h-&gt;nlmsg_len;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ssize_t rem_len =3D len - sizeof(*h);</span><br><span> </s=
pan><br><span>             if ((rem_len &lt; 0) || (len &gt; rcv_len))</spa=
n><br><span>             {</span><br><span>@@ -361,7 +356,7 @@</span><br><s=
pan>                     ret =3D -EIO;</span><br><span>                    =
 goto out;</span><br><span>                 }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;%s: malformed mes=
sage: len=3D%d&quot;, __func__, len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(M_WARN, &quot;%s: malformed message: =
len=3D%u&quot;, __func__, len);</span><br><span>                 ret =3D -E=
IO;</span><br><span>                 goto out;</span><br><span>            =
 }</span><br><span>@@ -388,7 +383,7 @@</span><br><span>             if (h-&=
gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br><span>             {</span><br>=
<span>                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                if (rem_len &lt;=
 (int)sizeof(struct nlmsgerr))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (rem_len &lt; sizeof(struct nlmsgerr))</span>=
<br><span>                 {</span><br><span>                     msg(M_WAR=
N, &quot;%s: ERROR truncated&quot;, __func__);</span><br><span>            =
         ret =3D -EIO;</span><br><span>@@ -443,7 +438,7 @@</span><br><span>=
 </span><br><span>         if (rcv_len)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
%s: rtnl: %d not parsed bytes&quot;, __func__, rcv_len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: rtnl=
: %zd not parsed bytes&quot;, __func__, rcv_len);</span><br><span>         =
    ret =3D -1;</span><br><span>             goto out;</span><br><span>    =
     }</span><br><span>@@ -456,7 +451,7 @@</span><br><span> </span><br><spa=
n> typedef struct</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int addr_size;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t addr_size;</span><br><span>     inet_address_t gw;=
</span><br><span>     char iface[IFNAMSIZ];</span><br><span>     bool defau=
lt_only;</span><br><span>@@ -469,7 +464,7 @@</span><br><span>     route_res=
_t *res =3D arg;</span><br><span>     struct rtmsg *r =3D NLMSG_DATA(n);</s=
pan><br><span>     struct rtattr *rta =3D RTM_RTA(r);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int len =3D n-&gt;nlmsg_len - NLMSG_LEN=
GTH(sizeof(*r));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size_t len =3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r));</span><br><span=
>     unsigned int table, ifindex =3D 0;</span><br><span>     void *gw =3D =
NULL;</span><br><span> </span><br><span>@@ -547,7 +542,8 @@</span><br><span=
>     req.n.nlmsg_type =3D RTM_GETROUTE;</span><br><span>     req.n.nlmsg_f=
lags =3D NLM_F_REQUEST;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    req.r.rtm_family =3D af_family;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(af_family &lt;=3D UCHAR_MAX)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_fami=
ly =3D (unsigned char)af_family;</span><br><span> </span><br><span>     swi=
tch (af_family)</span><br><span>     {</span><br><span>@@ -761,7 +757,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(int cmd, uint32_t=
 flags, int ifindex, sa_family_t af_family,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t flags, int if=
index, sa_family_t af_family,</span><br><span>                const inet_ad=
dress_t *local, const inet_address_t *remote, int prefixlen)</span><br><spa=
n> {</span><br><span>     struct sitnl_addr_req req;</span><br><span>@@ -77=
5,7 +771,8 @@</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST | fl=
ags;</span><br><span> </span><br><span>     req.i.ifa_index =3D ifindex;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    req.i.ifa_family =3D=
 af_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    req.i.ifa_family =3D (uint8_t)af_family;</span><br><span> =
</span><br><span>     switch (af_family)</span><br><span>     {</span><br><=
span>@@ -797,7 +794,8 @@</span><br><span>     {</span><br><span>         pr=
efixlen =3D size * 8;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    req.i.ifa_prefixlen =3D prefixlen;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(prefixlen &lt;=3D UINT=
8_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.i.if=
a_prefixlen =3D (uint8_t)prefixlen;</span><br><span> </span><br><span>     =
if (remote)</span><br><span>     {</span><br><span>@@ -890,9 +888,9 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(int cmd, uint32_t fl=
ags, int ifindex, sa_family_t af_family, const void *dst,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(uint16_t cmd, uint16_=
t flags, int ifindex, sa_family_t af_family, const void *dst,</span><br><sp=
an>                 int prefixlen, const void *gw, enum rt_class_t table, i=
nt metric,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     enum rt_scope_t scope, int protocol, int type)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                enum rt_scope_t scope, un=
signed char protocol, unsigned char type)</span><br><span> {</span><br><spa=
n>     struct sitnl_route_req req;</span><br><span>     int ret =3D -1, siz=
e;</span><br><span>@@ -917,15 +915,17 @@</span><br><span>     req.n.nlmsg_t=
ype =3D cmd;</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST | fla=
gs;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    req.r.rtm_family =3D af_family;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    req.r.rtm_scope =3D scope;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(af_family &lt;=3D UCHAR_MAX);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_family =3D (uns=
igned char)af_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    req.r.rtm_scope =3D (unsigned char)scope;</span><br><span>     req.r.=
rtm_protocol =3D protocol;</span><br><span>     req.r.rtm_type =3D type;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    req.r.rtm_dst_len =
=3D prefixlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(prefixlen &gt;=3D 0 &amp;&amp; prefixlen &lt;=3D UCHAR_MAX);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_dst_len =3D (u=
nsigned char)prefixlen;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (table &lt; 256)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (table &lt;=3D UCHAR_MAX)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        req.r.rtm=
_table =3D table;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      req.r.rtm_table =3D (unsigned char)table;</span><br><span>     }</spa=
n><br><span>     else</span><br><span>     {</span><br><span>@@ -1348,7 +13=
48,7 @@</span><br><span> }</span><br><span> </span><br><span> static int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr_flags=
(struct rtattr *tb[], int max, struct rtattr *rta, int len,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr_flags(struct rta=
ttr *tb[], size_t max, struct rtattr *rta, size_t len,</span><br><span>    =
                      unsigned short flags)</span><br><span> {</span><br><s=
pan>     unsigned short type;</span><br><span>@@ -1369,14 +1369,14 @@</span=
><br><span> </span><br><span>     if (len)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_ROUTE, &quot;%s: =
%d bytes not parsed! (rta_len=3D%d)&quot;, __func__, len, rta-&gt;rta_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE=
, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&quot;, __func__, len, rta-=
&gt;rta_len);</span><br><span>     }</span><br><span> </span><br><span>    =
 return 0;</span><br><span> }</span><br><span> </span><br><span> static int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr(st=
ruct rtattr *tb[], int max, struct rtattr *rta, int len)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr(struct rtattr *tb[]=
, size_t max, struct rtattr *rta, size_t len)</span><br><span> {</span><br>=
<span>     return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);</span><br=
><span> }</span><br><span>@@ -1474,10 +1474,6 @@</span><br><span>     retur=
n sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #endif /* !ENABLE_SITNL */</span><br><span> </span><br><span>=
 #endif /* TARGET_LINUX */</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail">chang=
e 1251</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f3=
99961f5b74fcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1251 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--vmDyOJEEsgg=--

