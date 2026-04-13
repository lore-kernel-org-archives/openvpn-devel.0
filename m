From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 13 Apr 2026 15:17:41 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d5b5ef81075579d4cc014e15b4827d94b544097e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GmrmXsJOldY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable per-socket
 bind_dev via --local
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GmrmXsJOldY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Enable per-socket bind_dev via --local
......................................................................

Enable per-socket bind_dev via --local

A bind device can now be specified within a
--local statement allowing to bind
different sockets to different devices.

Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
5 files changed, 21 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1625/2

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index edda1ca..4b3200a 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -111,7 +111,7 @@
   Valid syntax:
   ::

-     local host|* [port] [protocol]
+     local host|* [port] [protocol] [bind device]

   Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 33ebedb..3b30ed9 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -6,8 +6,10 @@
 routing.

 --bind-dev device
-  (Linux only) Set ``device`` to bind the server socket to a
+  (Linux only) Set ``device`` to bind all the server sockets to a
   `Virtual Routing and Forwarding`_ device
+  This option can also be used inside a ``--local`` statement
+  allowing to bind a single socket to specific device.

 --block-ipv6
   On the client, instead of sending IPv6 packets over the VPN tunnel, all
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70af6d2..e1c3b7d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3830,6 +3830,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->proto =3D o->ce.proto;
+        e->bind_dev =3D o->bind_dev;
     }

     /* use the same listen list for every outgoing connection */
@@ -5972,7 +5973,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[4])
+    else if (streq(p[0], "local") && p[1] && !p[5])
     {
         struct local_entry *e;

@@ -5998,6 +5999,17 @@
         {
             e->proto =3D ascii2proto(p[3]);
         }
+#if defined(TARGET_LINUX)
+        if (p[4])
+        {
+            e->bind_dev =3D p[4];
+        }
+#else
+        if (p[4])
+        {
+            msg(M_WARN, "Note: bind_dev is ignored on non-Linux systems");
+        }
+#endif
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a111cf8..c9f61d1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -101,6 +101,7 @@
     const char *local;
     const char *port;
     int proto;
+    const char *bind_dev;
 };

 struct connection_entry
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 624ce4f..018d12d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1349,6 +1349,7 @@
     const char *host =3D o->ce.local_list->array[sock_index]->local;
     const char *port =3D o->ce.local_list->array[sock_index]->port;
     int proto =3D o->ce.local_list->array[sock_index]->proto;
+    const char *bind_dev =3D o->ce.local_list->array[sock_index]->bind_dev;
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;
=20
@@ -1409,7 +1410,8 @@
 #endif

     sock->mark =3D o->mark;
-    sock->bind_dev =3D o->bind_dev;
+    /* bind_dev from local_list will trump the global option */
+    sock->bind_dev =3D bind_dev ? bind_dev : o->bind_dev;
     sock->info.proto =3D proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--GmrmXsJOldY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Enable per-socket bind_dev v=
ia --local<br><br>A bind device can now be specified within a<br>--local st=
atement allowing to bind<br>different sockets to different devices.<br><br>=
Change-Id: I6319c951327a9b994ffae0ba35270b0887455203<br>Signed-off-by: Gian=
marco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/=
link-options.rst<br>M doc/man-sections/vpn-network-options.rst<br>M src/ope=
nvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/socket.c<br>5 fi=
les changed, 21 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1625/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-op=
tions.rst</span><br><span>index edda1ca..4b3200a 100644</span><br><span>---=
 a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections=
/link-options.rst</span><br><span>@@ -111,7 +111,7 @@</span><br><span>   Va=
lid syntax:</span><br><span>   ::</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     local host|* [port] [protocol]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     local host|* [port] [p=
rotocol] [bind device]</span><br><span> </span><br><span>   Local host name=
 or IP address and port for bind. If specified, OpenVPN will bind</span><br=
><span>   to this address. If unspecified, OpenVPN will bind to all interfa=
ces.</span><br><span>diff --git a/doc/man-sections/vpn-network-options.rst =
b/doc/man-sections/vpn-network-options.rst</span><br><span>index 33ebedb..3=
b30ed9 100644</span><br><span>--- a/doc/man-sections/vpn-network-options.rs=
t</span><br><span>+++ b/doc/man-sections/vpn-network-options.rst</span><br>=
<span>@@ -6,8 +6,10 @@</span><br><span> routing.</span><br><span> </span><b=
r><span> --bind-dev device</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  (Linux only) Set ``device`` to bind the server socket to a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  (Linux only) Set ``device``=
 to bind all the server sockets to a</span><br><span>   `Virtual Routing an=
d Forwarding`_ device</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  This option can also be used inside a ``--local`` statement</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  allowing to bind a single soc=
ket to specific device.</span><br><span> </span><br><span> --block-ipv6</sp=
an><br><span>   On the client, instead of sending IPv6 packets over the VPN=
 tunnel, all</span><br><span>diff --git a/src/openvpn/options.c b/src/openv=
pn/options.c</span><br><span>index 70af6d2..e1c3b7d 100644</span><br><span>=
--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</sp=
an><br><span>@@ -3830,6 +3830,7 @@</span><br><span>         ASSERT(e);</spa=
n><br><span>         e-&gt;port =3D o-&gt;ce.local_port;</span><br><span>  =
       e-&gt;proto =3D o-&gt;ce.proto;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        e-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><sp=
an>     }</span><br><span> </span><br><span>     /* use the same listen lis=
t for every outgoing connection */</span><br><span>@@ -5972,7 +5973,7 @@</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>       =
  options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;loc=
al&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>         =
struct local_entry *e;</span><br><span> </span><br><span>@@ -5998,6 +5999,1=
7 @@</span><br><span>         {</span><br><span>             e-&gt;proto =
=3D ascii2proto(p[3]);</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            e-&gt;bind_dev =3D p[4];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (p[4])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_WARN, &quot;Note: bind_dev is ignored on non-Linux s=
ystems&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;remote-rando=
m&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>diff --gi=
t a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index a11=
1cf8..c9f61d1 100644</span><br><span>--- a/src/openvpn/options.h</span><br>=
<span>+++ b/src/openvpn/options.h</span><br><span>@@ -101,6 +101,7 @@</span=
><br><span>     const char *local;</span><br><span>     const char *port;</=
span><br><span>     int proto;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *bind_dev;</span><br><span> };</span><br><span> <=
/span><br><span> struct connection_entry</span><br><span>diff --git a/src/o=
penvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 624ce4f..018d1=
2d 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/=
src/openvpn/socket.c</span><br><span>@@ -1349,6 +1349,7 @@</span><br><span>=
     const char *host =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;loc=
al;</span><br><span>     const char *port =3D o-&gt;ce.local_list-&gt;array=
[sock_index]-&gt;port;</span><br><span>     int proto =3D o-&gt;ce.local_li=
st-&gt;array[sock_index]-&gt;proto;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *bind_dev =3D o-&gt;ce.local_list-&gt;array[=
sock_index]-&gt;bind_dev;</span><br><span>     const char *remote_host =3D =
o-&gt;ce.remote;</span><br><span>     const char *remote_port =3D o-&gt;ce.=
remote_port;</span><br><span> </span><br><span>@@ -1409,7 +1410,8 @@</span>=
<br><span> #endif</span><br><span> </span><br><span>     sock-&gt;mark =3D =
o-&gt;mark;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&=
gt;bind_dev =3D o-&gt;bind_dev;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* bind_dev from local_list will trump the global option */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;bind_d=
ev =3D bind_dev ? bind_dev : o-&gt;bind_dev;</span><br><span>     sock-&gt;=
info.proto =3D proto;</span><br><span>     sock-&gt;info.af =3D o-&gt;ce.af=
;</span><br><span>     sock-&gt;info.remote_float =3D o-&gt;ce.remote_float=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1625?usp=3Demail">change 1625</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1625?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--GmrmXsJOldY=--

