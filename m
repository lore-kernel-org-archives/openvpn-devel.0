From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 12:04:52 +0000
References: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1ac4bc9594683e61799818a8b3779e43f679368d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hhbCorQ3JQs="; charset=UTF-8
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

--hhbCorQ3JQs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail

to review the following change.


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
3 files changed, 13 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/821/1

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Gerrit-Change-Number: 821
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--hhbCorQ3JQs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/821?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix some formatting related to if/else and macros<br><br>Make=
 it clearer where the blocks are.<br><br>Change-Id: If645c3faf149bac82167a9=
1be13541b30a1b8d6a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M src/openvpn/helper.c<br>M src/openvpn/manage.c<br>M src/op=
envpn/openvpn.c<br>3 files changed, 13 insertions(+), 9 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/821/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c</span><br><=
span>index bbdbc04..9e28e87 100644</span><br><span>--- a/src/openvpn/helper=
.c</span><br><span>+++ b/src/openvpn/helper.c</span><br><span>@@ -500,7 +50=
0,7 @@</span><br><span>             push_option(o, print_opt_route_gateway_=
dhcp(&amp;o-&gt;gc), M_USAGE);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</s=
pan><br><span>      * HELPER DIRECTIVE:</span><br><span>      *</span><br><=
span>@@ -511,7 +511,7 @@</span><br><span>      * pull</span><br><span>     =
 * tls-client</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (o-&gt;client)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (o-&gt;client)</span><br><span>     {</span>=
<br><span>         o-&gt;pull =3D true;</span><br><span>         o-&gt;tls_=
client =3D true;</span><br><span>diff --git a/src/openvpn/manage.c b/src/op=
envpn/manage.c</span><br><span>index f296788..e79a118 100644</span><br><spa=
n>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</sp=
an><br><span>@@ -1822,7 +1822,9 @@</span><br><span>     }</span><br><span> =
    else</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    man-&gt;connection.sd_cli =3D socket_do_accept(man-&gt;conne=
ction.sd_top, &amp;act, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      man-&gt;connection.sd_cli =3D socket_do_accept(man-&gt;connection.sd_=
top, &amp;act, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> </span><br><span>     if (socket_defined(man-&gt;=
connection.sd_cli))</span><br><span>     {</span><br><span>@@ -1971,9 +1973=
,11 @@</span><br><span>         }</span><br><span>         else</span><br><=
span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            &quot;MANAGEMENT: connect to %s failed&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            print_sockaddr(man-&g=
t;settings.local-&gt;ai_addr, &amp;gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;MANAGEMENT: connect=
 to %s failed&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                print_sockaddr(man-&gt;settings.local-&gt;ai_addr, &amp;gc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span>         throw_signal_soft(SIGTERM, &quot;management-connect-fail=
ed&quot;);</span><br><span>         goto done;</span><br><span>     }</span=
><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span=
><br><span>index 1db5422..c52540c 100644</span><br><span>--- a/src/openvpn/=
openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -2=
74,10 +274,10 @@</span><br><span> </span><br><span>             /* Query pa=
sswords before becoming a daemon if we don&#39;t use the</span><br><span>  =
            * management interface to get them. */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span>     =
        if (!(c.options.management_flags &amp; MF_QUERY_PASSWORDS))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            init_query_passwords(&amp;c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                init_query_=
passwords(&amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span> </span><br><span>             /* become a dae=
mon if --daemon */</span><br><span>             if (c.first_time)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/821?usp=3Demail">change 821</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
21?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If645c3faf149bac82167a91be13=
541b30a1b8d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 821 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--hhbCorQ3JQs=--

