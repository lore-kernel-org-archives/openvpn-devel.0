From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Dec 2024 07:17:22 +0000
In-Reply-To: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
References: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <c1adb48c1fb7147ca9afbe29b6a2bfbadb4f35ea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fpp/qyi7VSA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fpp/qyi7VSA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: Fix some formatting related to if/else and macros
......................................................................

Fix some formatting related to if/else and macros

Make it clearer where the blocks are.

Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20241205214158.23542-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
027.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/helper.c
M src/openvpn/manage.c
M src/openvpn/openvpn.c
M src/openvpn/route.c
M src/openvpn/socket.c
M src/openvpn/ssl.c
6 files changed, 23 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/821/4

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
index df06fdf..d17b285 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3914,8 +3914,9 @@
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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Gerrit-Change-Number: 821
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--fpp/qyi7VSA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/821?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix some formatting related to if/else and macros<br=
><br>Make it clearer where the blocks are.<br><br>Change-Id: If645c3faf149b=
ac82167a91be13541b30a1b8d6a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Mess=
age-Id: &lt;20241205214158.23542-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30027.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/help=
er.c<br>M src/openvpn/manage.c<br>M src/openvpn/openvpn.c<br>M src/openvpn/=
route.c<br>M src/openvpn/socket.c<br>M src/openvpn/ssl.c<br>6 files changed=
, 23 insertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/21/821/4</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/h=
elper.c b/src/openvpn/helper.c</span><br><span>index bbdbc04..9e28e87 10064=
4</span><br><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/open=
vpn/helper.c</span><br><span>@@ -500,7 +500,7 @@</span><br><span>          =
   push_option(o, print_opt_route_gateway_dhcp(&amp;o-&gt;gc), M_USAGE);</s=
pan><br><span>         }</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     /*</span><br><span>      * HELPER DIRE=
CTIVE:</span><br><span>      *</span><br><span>@@ -511,7 +511,7 @@</span><b=
r><span>      * pull</span><br><span>      * tls-client</span><br><span>   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;cl=
ient)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (o=
-&gt;client)</span><br><span>     {</span><br><span>         o-&gt;pull =3D=
 true;</span><br><span>         o-&gt;tls_client =3D true;</span><br><span>=
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>in=
dex f296788..e79a118 100644</span><br><span>--- a/src/openvpn/manage.c</spa=
n><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -1822,7 +1822,9 @=
@</span><br><span>     }</span><br><span>     else</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    man-&gt;connection=
.sd_cli =3D socket_do_accept(man-&gt;connection.sd_top, &amp;act, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        man-&gt;connection.sd_cli =
=3D socket_do_accept(man-&gt;connection.sd_top, &amp;act, false);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span>     if (socket_defined(man-&gt;connection.sd_cli))</span><br><s=
pan>     {</span><br><span>@@ -1971,9 +1973,11 @@</span><br><span>         =
}</span><br><span>         else</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(D_LINK_ERRORS | M_ERRNO,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;MANAGEME=
NT: connect to %s failed&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            print_sockaddr(man-&gt;settings.local-&gt;ai_addr, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LIN=
K_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;MANAGEMENT: connect to %s failed&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                print_sockaddr(ma=
n-&gt;settings.local-&gt;ai_addr, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         throw_signal_so=
ft(SIGTERM, &quot;management-connect-failed&quot;);</span><br><span>       =
  goto done;</span><br><span>     }</span><br><span>diff --git a/src/openvp=
n/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index 1db5422..c52540c =
100644</span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++ b/sr=
c/openvpn/openvpn.c</span><br><span>@@ -274,10 +274,10 @@</span><br><span> =
</span><br><span>             /* Query passwords before becoming a daemon i=
f we don&#39;t use the</span><br><span>              * management interface=
 to get them. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_MANAGEMENT</span><br><span>             if (!(c.options.management=
_flags &amp; MF_QUERY_PASSWORDS))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         init_query_passwords(&amp;c);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                init_query_passwords(&amp;c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> </spa=
n><br><span>             /* become a daemon if --daemon */</span><br><span>=
             if (c.first_time)</span><br><span>diff --git a/src/openvpn/rou=
te.c b/src/openvpn/route.c</span><br><span>index df06fdf..d17b285 100644</s=
pan><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/r=
oute.c</span><br><span>@@ -3914,8 +3914,9 @@</span><br><span>         }</sp=
an><br><span>         else</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        rgi6-&gt;gateway.addr_ipv6 =3D gw;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            rgi6-&gt;gateway.addr_ipv6 =3D gw;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
        rgi6-&gt;flags |=3D RGI_ADDR_DEFINED;</span><br><span> </span><br><=
span>         if (ifp)</span><br><span>diff --git a/src/openvpn/socket.c b/=
src/openvpn/socket.c</span><br><span>index efd742c..01874fe 100644</span><b=
r><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket=
.c</span><br><span>@@ -3389,8 +3389,10 @@</span><br><span>     }</span><br>=
<span>     else</span><br><span> #endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    buf-&gt;len =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_=
forward_capacity(buf), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        &amp;from-&gt;dest.addr.sa, &amp;fromlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len =3D recvfrom(sock-=
&gt;sd, BPTR(buf), buf_forward_capacity(buf), 0,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            &amp;from-&gt;dest=
.addr.sa, &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     /* FIXME: won&#39;t do anything when sock-&=
gt;info.af =3D=3D AF_UNSPEC */</span><br><span>     if (buf-&gt;len &gt;=3D=
 0 &amp;&amp; expectedlen &amp;&amp; fromlen !=3D expectedlen)</span><br><s=
pan>     {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl=
.c</span><br><span>index 1f8eb1e..33c22b4 100644</span><br><span>--- a/src/=
openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -3=
27,7 +327,9 @@</span><br><span>         }</span><br><span>         else</sp=
an><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        get_user_pass(&amp;auth_user_pass, aut=
h_file, UP_TYPE_AUTH, flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            get_user_pass(&amp;auth_user_pass, auth_file, UP_TYPE_AUTH, fla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/821?usp=3Demail">change 821</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If645c3faf149bac82167a91be13=
541b30a1b8d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 821 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fpp/qyi7VSA=--

