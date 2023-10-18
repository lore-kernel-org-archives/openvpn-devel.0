From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 17:46:58 +0000
In-Reply-To: <gerrit.1692709613000.I052bebe720ddf26340827f25b94705945e470bfa@...2715...>
References: <gerrit.1692709613000.I052bebe720ddf26340827f25b94705945e470bfa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dbfdff5e5082b53bfa9ef00593ca3b3e73835e16-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iBlz37TlZ64="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove last uses of
 inet_ntoa
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

--iBlz37TlZ64=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/32=
6?usp=3Demail )

Change subject: Remove last uses of inet_ntoa
......................................................................

Remove last uses of inet_ntoa

inet_ntoa is officially deprecated and in some places
its use already causes warnings (e.g. Fedora submissions).
Since we mostly use inet_ntop already, just convert the
remaining usages to that.

Change-Id: I052bebe720ddf26340827f25b94705945e470bfa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231008103415.19625-1-frank@...2641...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20231008103415.19625-1=
-frank@...2641...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/route.c
M src/openvpn/socket.c
3 files changed, 17 insertions(+), 15 deletions(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 739ed40..feb62b2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3058,9 +3058,11 @@
         /* listen on our local TUN/TAP IP address */
         struct in_addr ia;
         int ret;
+        char buf[INET_ADDRSTRLEN];

         ia.s_addr =3D htonl(tun_local_ip);
-        ret =3D openvpn_getaddrinfo(GETADDR_PASSIVE, inet_ntoa(ia), NULL, =
0, NULL,
+        inet_ntop(AF_INET, &ia, buf, sizeof(buf));
+        ret =3D openvpn_getaddrinfo(GETADDR_PASSIVE, buf, NULL, 0, NULL,
                                   AF_INET, &man->settings.local);
         ASSERT(ret=3D=3D0);
         man_connection_init(man);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9212186..ff64938 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -342,7 +342,9 @@
             goto fail;
         }
         special.s_addr =3D htonl(special.s_addr);
-        ret =3D openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
+        char buf[INET_ADDRSTRLEN];
+        inet_ntop(AF_INET, &special, buf, sizeof(buf));
+        ret =3D openvpn_getaddrinfo(0, buf, NULL, 0, NULL,
                                   AF_INET, network_list);
     }
     else
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 501e023..903f98b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2901,16 +2901,16 @@
 print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
 {
     struct in_addr ia;
-    struct buffer out =3D alloc_buf_gc(64, gc);
+    char *out =3D gc_malloc(INET_ADDRSTRLEN, true, gc);

     if (addr || !(flags & IA_EMPTY_IF_UNDEF))
     {
         CLEAR(ia);
         ia.s_addr =3D (flags & IA_NET_ORDER) ? addr : htonl(addr);

-        buf_printf(&out, "%s", inet_ntoa(ia));
+        inet_ntop(AF_INET, &ia, out, INET_ADDRSTRLEN);
     }
-    return BSTR(&out);
+    return out;
 }

 /*
@@ -2920,16 +2920,14 @@
 const char *
 print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
 {
-    struct buffer out =3D alloc_buf_gc(64, gc);
-    char tmp_out_buf[64];       /* inet_ntop wants pointer to buffer */
+    char *out =3D gc_malloc(INET6_ADDRSTRLEN, true, gc);

     if (memcmp(&a6, &in6addr_any, sizeof(a6)) !=3D 0
         || !(flags & IA_EMPTY_IF_UNDEF))
     {
-        inet_ntop(AF_INET6, &a6, tmp_out_buf, sizeof(tmp_out_buf)-1);
-        buf_printf(&out, "%s", tmp_out_buf );
+        inet_ntop(AF_INET6, &a6, out, INET6_ADDRSTRLEN);
     }
-    return BSTR(&out);
+    return out;
 }

 /*
@@ -2978,7 +2976,7 @@
 {
     char name_buf[256];

-    char buf[128];
+    char buf[INET6_ADDRSTRLEN];
     switch (addr->addr.sa.sa_family)
     {
         case AF_INET:
@@ -2991,7 +2989,8 @@
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s", name_pr=
efix);
             }

-            setenv_str(es, name_buf, inet_ntoa(addr->addr.in4.sin_addr));
+            inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
+            setenv_str(es, name_buf, buf);

             if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
             {
@@ -3007,13 +3006,12 @@
                 memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12],
                        sizeof(ia.s_addr));
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name=
_prefix);
-                openvpn_snprintf(buf, sizeof(buf), "%s", inet_ntoa(ia) );
+                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
             }
             else
             {
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip6", nam=
e_prefix);
-                getnameinfo(&addr->addr.sa, sizeof(struct sockaddr_in6),
-                            buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
+                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof=
(buf));
             }
             setenv_str(es, name_buf, buf);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/326?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I052bebe720ddf26340827f25b94705945e470bfa
Gerrit-Change-Number: 326
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--iBlz37TlZ64=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/326?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove last uses of inet_ntoa<br><br>inet_ntoa=
 is officially deprecated and in some places<br>its use already causes warn=
ings (e.g. Fedora submissions).<br>Since we mostly use inet_ntop already, j=
ust convert the<br>remaining usages to that.<br><br>Change-Id: I052bebe720d=
df26340827f25b94705945e470bfa<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<b=
r>Message-Id: &lt;20231008103415.19625-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/search?l=3Dmid&amp;q=3D20231008103415.19625-1-frank=
@...2641...<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/manage.c<br>M src/openvpn/route.c<br>M src/openvpn/socket.c=
<br>3 files changed, 17 insertions(+), 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 739ed40..feb62b2 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -3058,9 +3058,=
11 @@</span><br><span>         /* listen on our local TUN/TAP IP address */=
</span><br><span>         struct in_addr ia;</span><br><span>         int r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char buf=
[INET_ADDRSTRLEN];</span><br><span> </span><br><span>         ia.s_addr =3D=
 htonl(tun_local_ip);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ret =3D openvpn_getaddrinfo(GETADDR_PASSIVE, inet_ntoa(ia), NULL, 0=
, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        inet=
_ntop(AF_INET, &amp;ia, buf, sizeof(buf));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ret =3D openvpn_getaddrinfo(GETADDR_PASSIVE,=
 buf, NULL, 0, NULL,</span><br><span>                                   AF_=
INET, &amp;man-&gt;settings.local);</span><br><span>         ASSERT(ret=3D=
=3D0);</span><br><span>         man_connection_init(man);</span><br><span>d=
iff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index=
 9212186..ff64938 100644</span><br><span>--- a/src/openvpn/route.c</span><b=
r><span>+++ b/src/openvpn/route.c</span><br><span>@@ -342,7 +342,9 @@</span=
><br><span>             goto fail;</span><br><span>         }</span><br><sp=
an>         special.s_addr =3D htonl(special.s_addr);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ret =3D openvpn_getaddrinfo(0, inet=
_ntoa(special), NULL, 0, NULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        char buf[INET_ADDRSTRLEN];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        inet_ntop(AF_INET, &amp;special, buf, siz=
eof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
et =3D openvpn_getaddrinfo(0, buf, NULL, 0, NULL,</span><br><span>         =
                          AF_INET, network_list);</span><br><span>     }</s=
pan><br><span>     else</span><br><span>diff --git a/src/openvpn/socket.c b=
/src/openvpn/socket.c</span><br><span>index 501e023..903f98b 100644</span><=
br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socke=
t.c</span><br><span>@@ -2901,16 +2901,16 @@</span><br><span> print_in_addr_=
t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)</span><br><span>=
 {</span><br><span>     struct in_addr ia;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(64, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *out =3D gc_mallo=
c(INET_ADDRSTRLEN, true, gc);</span><br><span> </span><br><span>     if (ad=
dr || !(flags &amp; IA_EMPTY_IF_UNDEF))</span><br><span>     {</span><br><s=
pan>         CLEAR(ia);</span><br><span>         ia.s_addr =3D (flags &amp;=
 IA_NET_ORDER) ? addr : htonl(addr);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;%s&quot=
;, inet_ntoa(ia));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       inet_ntop(AF_INET, &amp;ia, out, INET_ADDRSTRLEN);</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(=
&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n out;</span><br><span> }</span><br><span> </span><br><span> /*</span><br><=
span>@@ -2920,16 +2920,14 @@</span><br><span> const char *</span><br><span>=
 print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer out =3D alloc_buf_gc(64, gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char tmp_out_buf[64];       /* inet_ntop wants=
 pointer to buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *out =3D gc_malloc(INET6_ADDRSTRLEN, true, gc);</span><br><span>=
 </span><br><span>     if (memcmp(&amp;a6, &amp;in6addr_any, sizeof(a6)) !=
=3D 0</span><br><span>         || !(flags &amp; IA_EMPTY_IF_UNDEF))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  inet_ntop(AF_INET6, &amp;a6, tmp_out_buf, sizeof(tmp_out_buf)-1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, =
&quot;%s&quot;, tmp_out_buf );</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        inet_ntop(AF_INET6, &amp;a6, out, INET6_ADDRSTRLEN);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return BSTR(&amp;out);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return out;</span><br><span> }</span><br><span> </span><br><span> =
/*</span><br><span>@@ -2978,7 +2976,7 @@</span><br><span> {</span><br><span=
>     char name_buf[256];</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    char buf[128];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char buf[INET6_ADDRSTRLEN];</span><br><span>     s=
witch (addr-&gt;addr.sa.sa_family)</span><br><span>     {</span><br><span> =
        case AF_INET:</span><br><span>@@ -2991,7 +2989,8 @@</span><br><span=
>                 openvpn_snprintf(name_buf, sizeof(name_buf), &quot;%s&quo=
t;, name_prefix);</span><br><span>             }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            setenv_str(es, nam=
e_buf, inet_ntoa(addr-&gt;addr.in4.sin_addr));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            inet_ntop(AF_INET, &amp;addr-&gt;add=
r.in4.sin_addr, buf, sizeof(buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            setenv_str(es, name_buf, buf);</span><br><span> =
</span><br><span>             if ((flags &amp; SA_IP_PORT) &amp;&amp; addr-=
&gt;addr.in4.sin_port)</span><br><span>             {</span><br><span>@@ -3=
007,13 +3006,12 @@</span><br><span>                 memcpy(&amp;ia.s_addr, =
&amp;addr-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span>             =
           sizeof(ia.s_addr));</span><br><span>                 openvpn_snp=
rintf(name_buf, sizeof(name_buf), &quot;%s_ip&quot;, name_prefix);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                openvpn_snprin=
tf(buf, sizeof(buf), &quot;%s&quot;, inet_ntoa(ia) );</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                inet_ntop(AF_INET, &amp;i=
a, buf, sizeof(buf));</span><br><span>             }</span><br><span>      =
       else</span><br><span>             {</span><br><span>                =
 openvpn_snprintf(name_buf, sizeof(name_buf), &quot;%s_ip6&quot;, name_pref=
ix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                g=
etnameinfo(&amp;addr-&gt;addr.sa, sizeof(struct sockaddr_in6),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                            buf, s=
izeof(buf), NULL, 0, NI_NUMERICHOST);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                inet_ntop(AF_INET6, &amp;addr-&gt;addr.in=
6.sin6_addr, buf, sizeof(buf));</span><br><span>             }</span><br><s=
pan>             setenv_str(es, name_buf, buf);</span><br><span> </span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/326?usp=3Demail">change 326</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
26?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I052bebe720ddf26340827f25b94=
705945e470bfa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 326 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--iBlz37TlZ64=--

