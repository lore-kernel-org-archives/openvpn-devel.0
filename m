From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 12:28:19 +0000
In-Reply-To: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
References: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <05a2fccbe03b4351c676b556feb8a8fb8eb57af5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ucLNehebRng="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix some formatting
 related to if/else and macros
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

--ucLNehebRng=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix some formatting related to if/else and macros
......................................................................

Fix some formatting related to if/else and macros

Make it clearer where the blocks are.

Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/helper.c
M src/openvpn/manage.c
M src/openvpn/openvpn.c
M src/openvpn/route.c
M src/openvpn/socket.c
M src/openvpn/ssl.c
M src/openvpn/tun.c
7 files changed, 29 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/821/2

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index bbdbc04..9e28e87 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -500,7 +500,7 @@
             push_option(o, print_opt_route_gateway_dhcp(&o->gc), M_USAGE);
         }
     }
-    else
+
     /*
      * HELPER DIRECTIVE:
      *
@@ -511,7 +511,7 @@
      * pull
      * tls-client
      */
-    if (o->client)
+    else if (o->client)
     {
         o->pull =3D true;
         o->tls_client =3D true;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f296788..e79a118 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1822,7 +1822,9 @@
     }
     else
 #endif
-    man->connection.sd_cli =3D socket_do_accept(man->connection.sd_top, &a=
ct, false);
+    {
+        man->connection.sd_cli =3D socket_do_accept(man->connection.sd_top=
, &act, false);
+    }

     if (socket_defined(man->connection.sd_cli))
     {
@@ -1971,9 +1973,11 @@
         }
         else
 #endif
-        msg(D_LINK_ERRORS | M_ERRNO,
-            "MANAGEMENT: connect to %s failed",
-            print_sockaddr(man->settings.local->ai_addr, &gc));
+        {
+            msg(D_LINK_ERRORS | M_ERRNO,
+                "MANAGEMENT: connect to %s failed",
+                print_sockaddr(man->settings.local->ai_addr, &gc));
+        }
         throw_signal_soft(SIGTERM, "management-connect-failed");
         goto done;
     }
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 1db5422..c52540c 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -274,10 +274,10 @@

             /* Query passwords before becoming a daemon if we don't use the
              * management interface to get them. */
-#ifdef ENABLE_MANAGEMENT
             if (!(c.options.management_flags & MF_QUERY_PASSWORDS))
-#endif
-            init_query_passwords(&c);
+            {
+                init_query_passwords(&c);
+            }

             /* become a daemon if --daemon */
             if (c.first_time)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c7..3d33844 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3861,8 +3861,9 @@
         }
         else
 #endif
-
-        rgi6->gateway.addr_ipv6 =3D gw;
+        {
+            rgi6->gateway.addr_ipv6 =3D gw;
+        }
         rgi6->flags |=3D RGI_ADDR_DEFINED;

         if (ifp)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index efd742c..01874fe 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3389,8 +3389,10 @@
     }
     else
 #endif
-    buf->len =3D recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), =
0,
-                        &from->dest.addr.sa, &fromlen);
+    {
+        buf->len =3D recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(bu=
f), 0,
+                            &from->dest.addr.sa, &fromlen);
+    }
     /* FIXME: won't do anything when sock->info.af =3D=3D AF_UNSPEC */
     if (buf->len >=3D 0 && expectedlen && fromlen !=3D expectedlen)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1f8eb1e..33c22b4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -327,7 +327,9 @@
         }
         else
 #endif /* ifdef ENABLE_MANAGEMENT */
-        get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, flags);
+        {
+            get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, flags);
+        }
     }
 }

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 29d823d..f1aead2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3438,7 +3438,9 @@
     }
     else
 #endif
-    return write(tt->fd, buf, len);
+    {
+        return write(tt->fd, buf, len);
+    }
 }

 int
@@ -3451,7 +3453,9 @@
     }
     else
 #endif
-    return read(tt->fd, buf, len);
+    {
+        return read(tt->fd, buf, len);
+    }
 }
=20
 #elif defined(TARGET_AIX)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Gerrit-Change-Number: 821
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--ucLNehebRng=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Fix some formatting related to if/else and macros<br><br>Make it c=
learer where the blocks are.<br><br>Change-Id: If645c3faf149bac82167a91be13=
541b30a1b8d6a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/openvpn/helper.c<br>M src/openvpn/manage.c<br>M src/openvpn=
/openvpn.c<br>M src/openvpn/route.c<br>M src/openvpn/socket.c<br>M src/open=
vpn/ssl.c<br>M src/openvpn/tun.c<br>7 files changed, 29 insertions(+), 16 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/21/821/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/helper.c b/src/openvpn/he=
lper.c</span><br><span>index bbdbc04..9e28e87 100644</span><br><span>--- a/=
src/openvpn/helper.c</span><br><span>+++ b/src/openvpn/helper.c</span><br><=
span>@@ -500,7 +500,7 @@</span><br><span>             push_option(o, print_=
opt_route_gateway_dhcp(&amp;o-&gt;gc), M_USAGE);</span><br><span>         }=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     /*</span><br><span>      * HELPER DIRECTIVE:</span><br><span> =
     *</span><br><span>@@ -511,7 +511,7 @@</span><br><span>      * pull</sp=
an><br><span>      * tls-client</span><br><span>      */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;client)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (o-&gt;client)</span><br><=
span>     {</span><br><span>         o-&gt;pull =3D true;</span><br><span> =
        o-&gt;tls_client =3D true;</span><br><span>diff --git a/src/openvpn=
/manage.c b/src/openvpn/manage.c</span><br><span>index f296788..e79a118 100=
644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/op=
envpn/manage.c</span><br><span>@@ -1822,7 +1822,9 @@</span><br><span>     }=
</span><br><span>     else</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    man-&gt;connection.sd_cli =3D socket_do_ac=
cept(man-&gt;connection.sd_top, &amp;act, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        man-&gt;connection.sd_cli =3D socket_do_accept(man-=
&gt;connection.sd_top, &amp;act, false);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if (socke=
t_defined(man-&gt;connection.sd_cli))</span><br><span>     {</span><br><spa=
n>@@ -1971,9 +1973,11 @@</span><br><span>         }</span><br><span>       =
  else</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &quot;MANAGEMENT: connect to %s failed&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pri=
nt_sockaddr(man-&gt;settings.local-&gt;ai_addr, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(D_LINK_ERRORS | M_ERRNO,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;MAN=
AGEMENT: connect to %s failed&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                print_sockaddr(man-&gt;settings.local-&gt;=
ai_addr, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span>         throw_signal_soft(SIGTERM, &quot;managem=
ent-connect-failed&quot;);</span><br><span>         goto done;</span><br><s=
pan>     }</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn=
/openvpn.c</span><br><span>index 1db5422..c52540c 100644</span><br><span>--=
- a/src/openvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span=
><br><span>@@ -274,10 +274,10 @@</span><br><span> </span><br><span>        =
     /* Query passwords before becoming a daemon if we don&#39;t use the</s=
pan><br><span>              * management interface to get them. */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span=
><br><span>             if (!(c.options.management_flags &amp; MF_QUERY_PAS=
SWORDS))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            init_query_passw=
ords(&amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    init_query_passwords(&amp;c);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span> </span><br><span>             =
/* become a daemon if --daemon */</span><br><span>             if (c.first_=
time)</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.=
c</span><br><span>index 2e584c7..3d33844 100644</span><br><span>--- a/src/o=
penvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@=
 -3861,8 +3861,9 @@</span><br><span>         }</span><br><span>         els=
e</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rgi6-&gt;=
gateway.addr_ipv6 =3D gw;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        rgi6-&gt;gateway.addr_ipv6 =3D gw;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>         rgi6-&gt;flags |=
=3D RGI_ADDR_DEFINED;</span><br><span> </span><br><span>         if (ifp)</=
span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</sp=
an><br><span>index efd742c..01874fe 100644</span><br><span>--- a/src/openvp=
n/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -3=
389,8 +3389,10 @@</span><br><span>     }</span><br><span>     else</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bu=
f-&gt;len =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_forward_capacity(buf), 0=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    &amp;from-&gt;dest.addr.sa, &amp;fromlen);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf-&gt;len =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_f=
orward_capacity(buf), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            &amp;from-&gt;dest.addr.sa, &amp;fromlen);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an>     /* FIXME: won&#39;t do anything when sock-&gt;info.af =3D=3D AF_UNS=
PEC */</span><br><span>     if (buf-&gt;len &gt;=3D 0 &amp;&amp; expectedle=
n &amp;&amp; fromlen !=3D expectedlen)</span><br><span>     {</span><br><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 1f8eb1e..33c22b4 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -327,7 +327,9 @@</span><br=
><span>         }</span><br><span>         else</span><br><span> #endif /* =
ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        get_user_pass(&amp;auth_user_pass, auth_file, UP_TYPE_AUTH, fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            get_user_pas=
s(&amp;auth_user_pass, auth_file, UP_TYPE_AUTH, flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tun=
.c b/src/openvpn/tun.c</span><br><span>index 29d823d..f1aead2 100644</span>=
<br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</=
span><br><span>@@ -3438,7 +3438,9 @@</span><br><span>     }</span><br><span=
>     else</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return write(tt-&gt;fd, buf, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return write(tt-&gt;fd, buf, len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span>@@ -3451,7 +3453,9 @@</span=
><br><span>     }</span><br><span>     else</span><br><span> #endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return read(tt-&gt;fd, bu=
f, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return read(tt-&g=
t;fd, buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span> }</span><br><span> </span><br><span> #elif defined(TARG=
ET_AIX)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail">change 821</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/821?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If645c3faf149bac82167a91be13=
541b30a1b8d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 821 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ucLNehebRng=--

