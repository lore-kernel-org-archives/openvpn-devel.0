From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 12:14:02 +0000
In-Reply-To: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
References: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <facf0b28d6eb5ef370f8b507a1c17838d8ff664c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p0OXvwk74nM="; charset=UTF-8
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

--p0OXvwk74nM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail

to look at the new patch set (#5).


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
1 file changed, 46 insertions(+), 49 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1251/5

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc
Gerrit-Change-Number: 1251
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <antonio@...2726...>

--p0OXvwk74nM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">sitnl: Clean up type handling<br><br>- Make some=
 type casts explicit. Due to the types used<br>  in our networking API and =
the netlink APIs respectively<br>  this can&#39;t be avoided.<br>- In many =
cases just use correct types from the start, e.g.<br>  where we use constan=
ts anyway.<br><br>Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/op=
envpn/networking_sitnl.c<br>1 file changed, 46 insertions(+), 49 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/51/1251/5</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=
.c b/src/openvpn/networking_sitnl.c</span><br><span>index 1815faf..b3adb16 =
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
lemented as a macro, but compiling with</span><br><span>@@ -131,29 +131,24 =
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
 ASSERT(len &lt;=3D USHRT_MAX);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rta-&gt;rta_len =3D (unsigned short)len;</span><br><span> <=
/span><br><span>     if (!data)</span><br><span>     {</span><br><span>@@ -=
252,11 +247,10 @@</span><br><span> sitnl_send(struct nlmsghdr *payload, pid=
_t peer, unsigned int groups, sitnl_parse_reply_cb cb,</span><br><span>    =
        void *arg_cb)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int len, rem_len, fd, ret, rcv_len;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int fd, ret;</span><br><span>   =
  struct sockaddr_nl nladdr;</span><br><span>     struct nlmsgerr *err;</sp=
an><br><span>     struct nlmsghdr *h;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned int seq;</span><br><span>     char buf[1024 * =
16];</span><br><span>     struct iovec iov =3D {</span><br><span>         .=
iov_base =3D payload,</span><br><span>@@ -275,7 +269,11 @@</span><br><span>=
     nladdr.nl_pid =3D peer;</span><br><span>     nladdr.nl_groups =3D grou=
ps;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    payload-&gt;nlmsg_seq =3D seq =3D time(NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* NB: We currently do not verify seq and=
 pid on answers.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * If we ever want to start with that we probably need to come up</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * with something better=
 than &quot;seconds since epoch&quot;...</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    payload-&gt;nlmsg_seq =3D (uint32_t)time(NULL);</span><br><spa=
n> </span><br><span>     /* no need to send reply */</span><br><span>     i=
f (!cb)</span><br><span>@@ -290,16 +288,14 @@</span><br><span>         retu=
rn -errno;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D sitnl_bind(fd, 0);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (sitnl_bind(fd, 0) &lt; 0)<=
/span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot=
;%s: can&#39;t bind rtnl socket&quot;, __func__);</span><br><span>         =
ret =3D -errno;</span><br><span>         goto out;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D sendmsg(fd, &amp;nlmsg, 0);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (sendmsg(fd, &amp;nlmsg, 0) &lt; 0)</span><br><span>   =
  {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: error on=
 sendmsg()&quot;, __func__);</span><br><span>         ret =3D -errno;</span=
><br><span>@@ -318,8 +314,8 @@</span><br><span>          */</span><br><span=
>         msg(D_RTNL, &quot;%s: checking for received messages&quot;, __fun=
c__);</span><br><span>         iov.iov_len =3D sizeof(buf);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        rcv_len =3D recvmsg(fd, &amp;=
nlmsg, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_RTNL, &quot;%s: rtnl: received %d bytes&quot;, __func__, rcv_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssize_t rcv_len =
=3D recvmsg(fd, &amp;nlmsg, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(D_RTNL, &quot;%s: rtnl: received %zd bytes&quot;, _=
_func__, rcv_len);</span><br><span>         if (rcv_len &lt; 0)</span><br><=
span>         {</span><br><span>             if ((errno =3D=3D EINTR) || (e=
rrno =3D=3D EAGAIN))</span><br><span>@@ -350,8 +346,8 @@</span><br><span>  =
       h =3D (struct nlmsghdr *)buf;</span><br><span>         while (rcv_le=
n &gt;=3D (int)sizeof(*h))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            len =3D h-&gt;nlmsg_len;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            rem_len =3D len =
- sizeof(*h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      uint32_t len =3D h-&gt;nlmsg_len;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            ssize_t rem_len =3D len - sizeof(*h);</span=
><br><span> </span><br><span>             if ((rem_len &lt; 0) || (len &gt;=
 rcv_len))</span><br><span>             {</span><br><span>@@ -361,7 +357,7 =
@@</span><br><span>                     ret =3D -EIO;</span><br><span>     =
                goto out;</span><br><span>                 }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;%s=
: malformed message: len=3D%d&quot;, __func__, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;%s: mal=
formed message: len=3D%u&quot;, __func__, len);</span><br><span>           =
      ret =3D -EIO;</span><br><span>                 goto out;</span><br><s=
pan>             }</span><br><span>@@ -388,7 +384,7 @@</span><br><span>    =
         if (h-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br><span>         =
    {</span><br><span>                 err =3D (struct nlmsgerr *)NLMSG_DAT=
A(h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (rem_len &lt; (int)sizeof(struct nlmsgerr))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                if (rem_len &lt; sizeof(struct n=
lmsgerr))</span><br><span>                 {</span><br><span>              =
       msg(M_WARN, &quot;%s: ERROR truncated&quot;, __func__);</span><br><s=
pan>                     ret =3D -EIO;</span><br><span>@@ -443,7 +439,7 @@<=
/span><br><span> </span><br><span>         if (rcv_len)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_WARN, &quot;%s: rtnl: %d not parsed bytes&quot;, __func__, rcv_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN=
, &quot;%s: rtnl: %zd not parsed bytes&quot;, __func__, rcv_len);</span><br=
><span>             ret =3D -1;</span><br><span>             goto out;</spa=
n><br><span>         }</span><br><span>@@ -456,7 +452,7 @@</span><br><span>=
 </span><br><span> typedef struct</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int addr_size;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t addr_size;</span><br><span>     i=
net_address_t gw;</span><br><span>     char iface[IFNAMSIZ];</span><br><spa=
n>     bool default_only;</span><br><span>@@ -469,7 +465,7 @@</span><br><sp=
an>     route_res_t *res =3D arg;</span><br><span>     struct rtmsg *r =3D =
NLMSG_DATA(n);</span><br><span>     struct rtattr *rta =3D RTM_RTA(r);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D n-&gt;nlms=
g_len - NLMSG_LENGTH(sizeof(*r));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t len =3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r))=
;</span><br><span>     unsigned int table, ifindex =3D 0;</span><br><span> =
    void *gw =3D NULL;</span><br><span> </span><br><span>@@ -547,7 +543,8 @=
@</span><br><span>     req.n.nlmsg_type =3D RTM_GETROUTE;</span><br><span> =
    req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    req.r.rtm_family =3D af_family;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(af_family &=
lt;=3D UCHAR_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   req.r.rtm_family =3D (unsigned char)af_family;</span><br><span> </span><=
br><span>     switch (af_family)</span><br><span>     {</span><br><span>@@ =
-761,7 +758,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(=
int cmd, uint32_t flags, int ifindex, sa_family_t af_family,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_set(uint16_t cmd, uint1=
6_t flags, int ifindex, sa_family_t af_family,</span><br><span>            =
    const inet_address_t *local, const inet_address_t *remote, int prefixle=
n)</span><br><span> {</span><br><span>     struct sitnl_addr_req req;</span=
><br><span>@@ -775,7 +772,8 @@</span><br><span>     req.n.nlmsg_flags =3D N=
LM_F_REQUEST | flags;</span><br><span> </span><br><span>     req.i.ifa_inde=
x =3D ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=
.i.ifa_family =3D af_family;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    req.i.ifa_family =3D (uint8_t)af_family;<=
/span><br><span> </span><br><span>     switch (af_family)</span><br><span> =
    {</span><br><span>@@ -797,7 +795,8 @@</span><br><span>     {</span><br>=
<span>         prefixlen =3D size * 8;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    req.i.ifa_prefixlen =3D prefixl=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(prefi=
xlen &lt;=3D UINT8_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    req.i.ifa_prefixlen =3D (uint8_t)prefixlen;</span><br><span> </spa=
n><br><span>     if (remote)</span><br><span>     {</span><br><span>@@ -890=
,9 +889,9 @@</span><br><span> }</span><br><span> </span><br><span> static i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(int=
 cmd, uint32_t flags, int ifindex, sa_family_t af_family, const void *dst,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(uint=
16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *d=
st,</span><br><span>                 int prefixlen, const void *gw, enum rt=
_class_t table, int metric,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                enum rt_scope_t scope, int protocol, int type)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                enum rt_sc=
ope_t scope, unsigned char protocol, unsigned char type)</span><br><span> {=
</span><br><span>     struct sitnl_route_req req;</span><br><span>     int =
ret =3D -1, size;</span><br><span>@@ -917,15 +916,17 @@</span><br><span>   =
  req.n.nlmsg_type =3D cmd;</span><br><span>     req.n.nlmsg_flags =3D NLM_=
F_REQUEST | flags;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    req.r.rtm_family =3D af_family;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    req.r.rtm_scope =3D scope;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(af_family &lt;=3D UCHAR_=
MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_=
family =3D (unsigned char)af_family;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    req.r.rtm_scope =3D (unsigned char)scope;</span><br><s=
pan>     req.r.rtm_protocol =3D protocol;</span><br><span>     req.r.rtm_ty=
pe =3D type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req.r=
.rtm_dst_len =3D prefixlen;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(prefixlen &gt;=3D 0 &amp;&amp; prefixlen &lt;=3D UCHAR_M=
AX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.r.rtm_d=
st_len =3D (unsigned char)prefixlen;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (table &lt; 256)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (table &lt;=3D UCHAR_MAX)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    req.r.rtm_table =3D table;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        req.r.rtm_table =3D (unsigned char)table;</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span>@=
@ -1348,7 +1349,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse=
_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta, int len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr_fla=
gs(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,</span><=
br><span>                          unsigned short flags)</span><br><span> {=
</span><br><span>     unsigned short type;</span><br><span>@@ -1369,14 +137=
0,14 @@</span><br><span> </span><br><span>     if (len)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_ROUT=
E, &quot;%s: %d bytes not parsed! (rta_len=3D%d)&quot;, __func__, len, rta-=
&gt;rta_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&quot;, __func=
__, len, rta-&gt;rta_len);</span><br><span>     }</span><br><span> </span><=
br><span>     return 0;</span><br><span> }</span><br><span> </span><br><spa=
n> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_pa=
rse_rtattr(struct rtattr *tb[], int max, struct rtattr *rta, int len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_parse_rtattr(struct=
 rtattr *tb[], size_t max, struct rtattr *rta, size_t len)</span><br><span>=
 {</span><br><span>     return sitnl_parse_rtattr_flags(tb, max, rta, len, =
0);</span><br><span> }</span><br><span>@@ -1474,10 +1475,6 @@</span><br><sp=
an>     return sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> #endif /* !ENABLE_SITNL */</span><br><span> </sp=
an><br><span> #endif /* TARGET_LINUX */</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=
=3Demail">change 1251</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1251?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I20205ebd06bbf7cbee8c9be93f3=
99961f5b74fcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1251 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--p0OXvwk74nM=--

