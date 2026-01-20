From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 20 Jan 2026 14:10:56 +0000
References: <gerrit.1768911679000.Idbb5c0fff759a2e645a8b4f62266509e32e3a44e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <373655878fd451a628da65fc9981bd5d54488c71-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9UKE0naOlhQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: Fix
 conversion warnings on BSDs
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

--9UKE0naOlhQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1481?usp=3Demail

to review the following change.


Change subject: route: Fix conversion warnings on BSDs
......................................................................

route: Fix conversion warnings on BSDs

Mostly just use better types. And in
some places remove overloading of
variables with nicer C11 code.

Change-Id: Idbb5c0fff759a2e645a8b4f62266509e32e3a44e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 33 insertions(+), 50 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1481/3

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d90c84b..93f61a1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1762,11 +1762,6 @@
     return (status !=3D RTA_ERROR);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 route_ipv6_clear_host_bits(struct route_ipv6 *r6)
 {
@@ -1833,7 +1828,7 @@
     if (r6->iface !=3D NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway)) /* fe80::...%intf */
     {
-        int len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        size_t len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp =3D gc_malloc(len, true, &gc);
         snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway =3D tmp;
@@ -2253,7 +2248,7 @@
     if (r6->iface !=3D NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway)) /* fe80::...%intf */
     {
-        int len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        size_t len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp =3D gc_malloc(len, true, &gc);
         snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway =3D tmp;
@@ -2374,10 +2369,6 @@
     net_ctx_reset(ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * The --redirect-gateway option requires OS-specific code below
  * to get the current default gateway.
@@ -3354,19 +3345,19 @@
 #define NEXTADDR(w, u)        \
     if (rtm_addrs & (w))      \
     {                         \
-        l =3D sizeof(u);        \
+        size_t l =3D sizeof(u); \
         memmove(cp, &(u), l); \
         cp +=3D ROUNDUP(l);     \
     }

 #define ADVANCE(x, n) (x +=3D ROUNDUP(sizeof(struct sockaddr_in)))
 #else /* if defined(TARGET_SOLARIS) */
-#define NEXTADDR(w, u)                         \
-    if (rtm_addrs & (w))                       \
-    {                                          \
-        l =3D ((struct sockaddr *)&(u))->sa_len; \
-        memmove(cp, &(u), l);                  \
-        cp +=3D ROUNDUP(l);                      \
+#define NEXTADDR(w, u)                                \
+    if (rtm_addrs & (w))                              \
+    {                                                 \
+        size_t l =3D ((struct sockaddr *)&(u))->sa_len; \
+        memmove(cp, &(u), l);                         \
+        cp +=3D ROUNDUP(l);                             \
     }

 #define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
@@ -3374,19 +3365,13 @@

 #define max(a, b) ((a) > (b) ? (a) : (b))

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     struct gc_arena gc =3D gc_new();
     struct rtmsg m_rtmsg;
     int sockfd =3D -1;
-    int seq, l, pid, rtm_addrs;
-    unsigned int i;
+    int rtm_addrs;
     struct sockaddr so_dst, so_mask;
     char *cp =3D m_rtmsg.m_space;
     struct sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;
@@ -3397,8 +3382,8 @@
     CLEAR(*rgi);

     /* setup data to send to routing socket */
-    pid =3D getpid();
-    seq =3D 0;
+    const int pid =3D getpid();
+    int seq =3D 0;
 #ifdef TARGET_OPENBSD
     rtm_addrs =3D RTA_DST | RTA_NETMASK; /* Kernel refuses RTA_IFP */
 #else
@@ -3415,7 +3400,7 @@
     rtm.rtm_version =3D RTM_VERSION;
     rtm.rtm_seq =3D ++seq;
 #ifdef TARGET_OPENBSD
-    rtm.rtm_tableid =3D getrtable();
+    rtm.rtm_tableid =3D (u_short)getrtable();
 #endif
     rtm.rtm_addrs =3D rtm_addrs;

@@ -3430,7 +3415,8 @@
     NEXTADDR(RTA_DST, so_dst);
     NEXTADDR(RTA_NETMASK, so_mask);

-    rtm.rtm_msglen =3D l =3D cp - (char *)&m_rtmsg;
+    /* sizeof(struct rt_msghdr) + padding */
+    rtm.rtm_msglen =3D (u_short)(cp - (char *)&m_rtmsg);

     /* transact with routing socket */
     sockfd =3D socket(PF_ROUTE, SOCK_RAW, 0);
@@ -3439,24 +3425,25 @@
         msg(M_WARN, "GDG: socket #1 failed");
         goto done;
     }
-    if (write(sockfd, (char *)&m_rtmsg, l) < 0)
+    if (write(sockfd, (char *)&m_rtmsg, rtm.rtm_msglen) < 0)
     {
         msg(M_WARN | M_ERRNO, "GDG: problem writing to routing socket");
         goto done;
     }
+    ssize_t ret;
     do
     {
-        l =3D read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
-    } while (l > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));
+        ret =3D read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
+    } while (ret > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));
     close(sockfd);
     sockfd =3D -1;

     /* extract return data from routing socket */
     rtm_aux =3D &rtm;
-    cp =3D ((char *)(rtm_aux + 1));
+    cp =3D (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
     {
-        for (i =3D 1; i; i <<=3D 1)
+        for (unsigned int i =3D 1; i; i <<=3D 1)
         {
             if (i & rtm_aux->rtm_addrs)
             {
@@ -3604,8 +3591,7 @@
 {
     struct rtmsg m_rtmsg;
     int sockfd =3D -1;
-    int seq, l, pid, rtm_addrs;
-    unsigned int i;
+    int rtm_addrs;
     struct sockaddr_in6 so_dst, so_mask;
     char *cp =3D m_rtmsg.m_space;
     struct sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;
@@ -3614,8 +3600,8 @@
     CLEAR(*rgi6);

     /* setup data to send to routing socket */
-    pid =3D getpid();
-    seq =3D 0;
+    const int pid =3D getpid();
+    int seq =3D 0;
 #ifdef TARGET_OPENBSD
     rtm_addrs =3D RTA_DST | RTA_NETMASK; /* Kernel refuses RTA_IFP */
 #else
@@ -3632,7 +3618,7 @@
     rtm.rtm_version =3D RTM_VERSION;
     rtm.rtm_seq =3D ++seq;
 #ifdef TARGET_OPENBSD
-    rtm.rtm_tableid =3D getrtable();
+    rtm.rtm_tableid =3D (u_short)getrtable();
 #endif

     so_dst.sin6_family =3D AF_INET6;
@@ -3656,7 +3642,8 @@
     NEXTADDR(RTA_DST, so_dst);
     NEXTADDR(RTA_NETMASK, so_mask);

-    rtm.rtm_msglen =3D l =3D cp - (char *)&m_rtmsg;
+    /* sizeof(struct rt_msghdr) + padding */
+    rtm.rtm_msglen =3D (u_short)(cp - (char *)&m_rtmsg);

     /* transact with routing socket */
     sockfd =3D socket(PF_ROUTE, SOCK_RAW, 0);
@@ -3665,26 +3652,26 @@
         msg(M_WARN, "GDG6: socket #1 failed");
         goto done;
     }
-    if (write(sockfd, (char *)&m_rtmsg, l) < 0)
+    if (write(sockfd, (char *)&m_rtmsg, rtm.rtm_msglen) < 0)
     {
         msg(M_WARN | M_ERRNO, "GDG6: problem writing to routing socket");
         goto done;
     }
-
+    ssize_t ret;
     do
     {
-        l =3D read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
-    } while (l > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));
+        ret =3D read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
+    } while (ret > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));

     close(sockfd);
     sockfd =3D -1;

     /* extract return data from routing socket */
     rtm_aux =3D &rtm;
-    cp =3D ((char *)(rtm_aux + 1));
+    cp =3D (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
     {
-        for (i =3D 1; i; i <<=3D 1)
+        for (unsigned int i =3D 1; i; i <<=3D 1)
         {
             if (i & rtm_aux->rtm_addrs)
             {
@@ -3752,10 +3739,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #undef max

 #elif defined(TARGET_HAIKU)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1481?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idbb5c0fff759a2e645a8b4f62266509e32e3a44e
Gerrit-Change-Number: 1481
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9UKE0naOlhQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1481?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">route: Fix conversion warnings on BSDs<br><=
br>Mostly just use better types. And in<br>some places remove overloading o=
f<br>variables with nicer C11 code.<br><br>Change-Id: Idbb5c0fff759a2e645a8=
b4f62266509e32e3a44e<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 33 insertions(+),=
 50 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/81/1481/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ro=
ute.c b/src/openvpn/route.c</span><br><span>index d90c84b..93f61a1 100644</=
span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/=
route.c</span><br><span>@@ -1762,11 +1762,6 @@</span><br><span>     return =
(status !=3D RTA_ERROR);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> void</span><br><span> route_ipv6_clear_host_b=
its(struct route_ipv6 *r6)</span><br><span> {</span><br><span>@@ -1833,7 +1=
828,7 @@</span><br><span>     if (r6-&gt;iface !=3D NULL &amp;&amp; gateway=
_needed</span><br><span>         &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;r6-&=
gt;gateway)) /* fe80::...%intf */</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        int len =3D strlen(gateway) + 1 =
+ strlen(r6-&gt;iface) + 1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        size_t len =3D strlen(gateway) + 1 + strlen(r6-&gt;iface) +=
 1;</span><br><span>         char *tmp =3D gc_malloc(len, true, &amp;gc);</=
span><br><span>         snprintf(tmp, len, &quot;%s%%%s&quot;, gateway, r6-=
&gt;iface);</span><br><span>         gateway =3D tmp;</span><br><span>@@ -2=
253,7 +2248,7 @@</span><br><span>     if (r6-&gt;iface !=3D NULL &amp;&amp;=
 gateway_needed</span><br><span>         &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&=
amp;r6-&gt;gateway)) /* fe80::...%intf */</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D strlen(gatew=
ay) + 1 + strlen(r6-&gt;iface) + 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        size_t len =3D strlen(gateway) + 1 + strlen(r6-&gt;=
iface) + 1;</span><br><span>         char *tmp =3D gc_malloc(len, true, &am=
p;gc);</span><br><span>         snprintf(tmp, len, &quot;%s%%%s&quot;, gate=
way, r6-&gt;iface);</span><br><span>         gateway =3D tmp;</span><br><sp=
an>@@ -2374,10 +2369,6 @@</span><br><span>     net_ctx_reset(ctx);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * The --redirect-=
gateway option requires OS-specific code below</span><br><span>  * to get t=
he current default gateway.</span><br><span>@@ -3354,19 +3345,19 @@</span><=
br><span> #define NEXTADDR(w, u)        \</span><br><span>     if (rtm_addr=
s &amp; (w))      \</span><br><span>     {                         \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        l =3D sizeof(u);    =
    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t=
 l =3D sizeof(u); \</span><br><span>         memmove(cp, &amp;(u), l); \</s=
pan><br><span>         cp +=3D ROUNDUP(l);     \</span><br><span>     }</sp=
an><br><span> </span><br><span> #define ADVANCE(x, n) (x +=3D ROUNDUP(sizeo=
f(struct sockaddr_in)))</span><br><span> #else /* if defined(TARGET_SOLARIS=
) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define NEXTADDR(=
w, u)                         \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (rtm_addrs &amp; (w))                       \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {                             =
             \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 l =3D ((struct sockaddr *)&amp;(u))-&gt;sa_len; \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        memmove(cp, &amp;(u), l);             =
     \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cp +=3D=
 ROUNDUP(l);                      \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define NEXTADDR(w, u)                                \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rtm_addrs &amp;=
 (w))                              \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {                                                 \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t l =3D (=
(struct sockaddr *)&amp;(u))-&gt;sa_len; \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        memmove(cp, &amp;(u), l);                   =
      \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cp +=
=3D ROUNDUP(l);                             \</span><br><span>     }</span>=
<br><span> </span><br><span> #define ADVANCE(x, n) (x +=3D ROUNDUP((n)-&gt;=
sa_len))</span><br><span>@@ -3374,19 +3365,13 @@</span><br><span> </span><b=
r><span> #define max(a, b) ((a) &gt; (b) ? (a) : (b))</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> get_default_g=
ateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *c=
tx)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span>     struct rtmsg m_rtmsg;</span><br><span>     int sockf=
d =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int seq,=
 l, pid, rtm_addrs;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  unsigned int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int rtm_addrs;</span><br><span>     struct sockaddr so_dst, so_mask;</spa=
n><br><span>     char *cp =3D m_rtmsg.m_space;</span><br><span>     struct =
sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;</span><br><span>@@ -3397,8 +33=
82,8 @@</span><br><span>     CLEAR(*rgi);</span><br><span> </span><br><span=
>     /* setup data to send to routing socket */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    pid =3D getpid();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    seq =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const int pid =3D getpid();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int seq =3D 0;</span><br><span> #ifde=
f TARGET_OPENBSD</span><br><span>     rtm_addrs =3D RTA_DST | RTA_NETMASK; =
/* Kernel refuses RTA_IFP */</span><br><span> #else</span><br><span>@@ -341=
5,7 +3400,7 @@</span><br><span>     rtm.rtm_version =3D RTM_VERSION;</span>=
<br><span>     rtm.rtm_seq =3D ++seq;</span><br><span> #ifdef TARGET_OPENBS=
D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rtm.rtm_tableid =
=3D getrtable();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rtm.rtm_tableid =3D (u_short)getrtable();</span><br><span> #endif</span><b=
r><span>     rtm.rtm_addrs =3D rtm_addrs;</span><br><span> </span><br><span=
>@@ -3430,7 +3415,8 @@</span><br><span>     NEXTADDR(RTA_DST, so_dst);</spa=
n><br><span>     NEXTADDR(RTA_NETMASK, so_mask);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    rtm.rtm_msglen =3D l =3D c=
p - (char *)&amp;m_rtmsg;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* sizeof(struct rt_msghdr) + padding */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    rtm.rtm_msglen =3D (u_short)(cp - (char =
*)&amp;m_rtmsg);</span><br><span> </span><br><span>     /* transact with ro=
uting socket */</span><br><span>     sockfd =3D socket(PF_ROUTE, SOCK_RAW, =
0);</span><br><span>@@ -3439,24 +3425,25 @@</span><br><span>         msg(M_=
WARN, &quot;GDG: socket #1 failed&quot;);</span><br><span>         goto don=
e;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (write(sockfd, (char *)&amp;m_rtmsg, l) &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (write(sockfd, (char *)&amp;m=
_rtmsg, rtm.rtm_msglen) &lt; 0)</span><br><span>     {</span><br><span>    =
     msg(M_WARN | M_ERRNO, &quot;GDG: problem writing to routing socket&quo=
t;);</span><br><span>         goto done;</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t ret;</span><br><spa=
n>     do</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        l =3D read(sockfd, (char *)&amp;m_rtmsg, sizeof(m_rtmsg)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (l &gt;=
 0 &amp;&amp; (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ret =3D read(sockfd, (ch=
ar *)&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    } while (ret &gt; 0 &amp;&amp; (rtm.rtm_seq !=3D seq |=
| rtm.rtm_pid !=3D pid));</span><br><span>     close(sockfd);</span><br><sp=
an>     sockfd =3D -1;</span><br><span> </span><br><span>     /* extract re=
turn data from routing socket */</span><br><span>     rtm_aux =3D &amp;rtm;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cp =3D ((char *)(=
rtm_aux + 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
p =3D (char *)(rtm_aux + 1);</span><br><span>     if (rtm_aux-&gt;rtm_addrs=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        for (i =3D 1; i; i &lt;&lt;=3D 1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 1; i; i &lt;&lt;=
=3D 1)</span><br><span>         {</span><br><span>             if (i &amp; =
rtm_aux-&gt;rtm_addrs)</span><br><span>             {</span><br><span>@@ -3=
604,8 +3591,7 @@</span><br><span> {</span><br><span>     struct rtmsg m_rtm=
sg;</span><br><span>     int sockfd =3D -1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int seq, l, pid, rtm_addrs;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int i;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int rtm_addrs;</span><br><span>     s=
truct sockaddr_in6 so_dst, so_mask;</span><br><span>     char *cp =3D m_rtm=
sg.m_space;</span><br><span>     struct sockaddr *gate =3D NULL, *ifp =3D N=
ULL, *sa;</span><br><span>@@ -3614,8 +3600,8 @@</span><br><span>     CLEAR(=
*rgi6);</span><br><span> </span><br><span>     /* setup data to send to rou=
ting socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pid=
 =3D getpid();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    seq=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in=
t pid =3D getpid();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int seq =3D 0;</span><br><span> #ifdef TARGET_OPENBSD</span><br><span> =
    rtm_addrs =3D RTA_DST | RTA_NETMASK; /* Kernel refuses RTA_IFP */</span=
><br><span> #else</span><br><span>@@ -3632,7 +3618,7 @@</span><br><span>   =
  rtm.rtm_version =3D RTM_VERSION;</span><br><span>     rtm.rtm_seq =3D ++s=
eq;</span><br><span> #ifdef TARGET_OPENBSD</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    rtm.rtm_tableid =3D getrtable();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    rtm.rtm_tableid =3D (u_short)getr=
table();</span><br><span> #endif</span><br><span> </span><br><span>     so_=
dst.sin6_family =3D AF_INET6;</span><br><span>@@ -3656,7 +3642,8 @@</span><=
br><span>     NEXTADDR(RTA_DST, so_dst);</span><br><span>     NEXTADDR(RTA_=
NETMASK, so_mask);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    rtm.rtm_msglen =3D l =3D cp - (char *)&amp;m_rtmsg;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sizeof(struct rt_=
msghdr) + padding */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    rtm.rtm_msglen =3D (u_short)(cp - (char *)&amp;m_rtmsg);</span><br><sp=
an> </span><br><span>     /* transact with routing socket */</span><br><spa=
n>     sockfd =3D socket(PF_ROUTE, SOCK_RAW, 0);</span><br><span>@@ -3665,2=
6 +3652,26 @@</span><br><span>         msg(M_WARN, &quot;GDG6: socket #1 fa=
iled&quot;);</span><br><span>         goto done;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (write(sockfd, (ch=
ar *)&amp;m_rtmsg, l) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (write(sockfd, (char *)&amp;m_rtmsg, rtm.rtm_msglen) &lt; =
0)</span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &q=
uot;GDG6: problem writing to routing socket&quot;);</span><br><span>       =
  goto done;</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
size_t ret;</span><br><span>     do</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        l =3D read(sockfd, (char *)&am=
p;m_rtmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    } while (l &gt; 0 &amp;&amp; (rtm.rtm_seq !=3D seq || rtm.rtm_pi=
d !=3D pid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ret =3D read(sockfd, (char *)&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    } while (ret &gt; 0 &amp;&am=
p; (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));</span><br><span> </span=
><br><span>     close(sockfd);</span><br><span>     sockfd =3D -1;</span><b=
r><span> </span><br><span>     /* extract return data from routing socket *=
/</span><br><span>     rtm_aux =3D &amp;rtm;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    cp =3D ((char *)(rtm_aux + 1));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    cp =3D (char *)(rtm_aux + 1);</s=
pan><br><span>     if (rtm_aux-&gt;rtm_addrs)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 1; i; i &=
lt;&lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (unsigned int i =3D 1; i; i &lt;&lt;=3D 1)</span><br><span>         {=
</span><br><span>             if (i &amp; rtm_aux-&gt;rtm_addrs)</span><br>=
<span>             {</span><br><span>@@ -3752,10 +3739,6 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #undef max</span><br><=
span> </span><br><span> #elif defined(TARGET_HAIKU)</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1481?usp=3Demail">change 1481</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
481?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idbb5c0fff759a2e645a8b4f6226=
6509e32e3a44e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9UKE0naOlhQ=--

