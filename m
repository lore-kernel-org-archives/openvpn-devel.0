From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 15:32:29 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <de82f9dcbc25c9384a7e58d4cfd76002b77728b2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SOndQkFVdAo="; charset=UTF-8
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

--SOndQkFVdAo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Enable per-socket bind_dev via --local
......................................................................

Enable per-socket bind_dev via --local

A bind device can now be specified within a
--local statement allowing to bind
different sockets to different devices.

While at it, improved the man-section for
--local.

Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
5 files changed, 29 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1625/3

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index edda1ca..0c4df71 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -111,12 +111,17 @@
   Valid syntax:
   ::

-     local host|* [port] [protocol]
+     local host|* [port] [protocol] [bind device]

   Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on=
 what
   is returned by the OS).
+
+  The optional arguments correspond to existing options: ``port`` to
+  ``--lport``, ``protocol`` to ``--proto``, and ``bind device`` to
+  ``--bind-dev``.
+
   On a client, or in point-to-point mode, this can only be specified once =
(1 socket).

   On an OpenVPN setup running as ``--server``, this can be specified multi=
ple times
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
index 70af6d2..63db6db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -128,10 +128,12 @@
     "--version       : Show copyright and version information.\n"
     "\n"
     "Tunnel Options:\n"
-    "--local host|* [port]: Local host name or IP address and port for bin=
d.\n"
+    "--local host|* [port] [protocol] [bind-dev]: Local host name or IP ad=
dress and port for bind.\n"
     "                        If specified, OpenVPN will bindto this addres=
s. If unspecified,\n"
     "                        OpenVPN will bind to all interfaces. '*' can =
be used as hostname\n"
     "                        and means 'any host' (OpenVPN will listen on =
what is returned by the OS).\n"
+    "                        The optional arguments correspond to existing=
 options: ``port`` to ``--lport``,\n"
+    "                        ``protocol`` to ``--proto``, and ``bind devic=
e`` to --bind-dev``.\n"
     "                        On a client, or in point-to-point mode, this =
can only be specified once (1 socket).\n"
     "                        On an OpenVPN setup running as ``--server``, =
this can be specified multiple times\n"
     "                        to open multiple listening sockets on differe=
nt addresses and/or different ports.\n"
@@ -3830,6 +3832,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->proto =3D o->ce.proto;
+        e->bind_dev =3D o->bind_dev;
     }

     /* use the same listen list for every outgoing connection */
@@ -5972,7 +5975,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[4])
+    else if (streq(p[0], "local") && p[1] && !p[5])
     {
         struct local_entry *e;

@@ -5998,6 +6001,17 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--SOndQkFVdAo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Enable per-socket bind_dev v=
ia --local<br><br>A bind device can now be specified within a<br>--local st=
atement allowing to bind<br>different sockets to different devices.<br><br>=
While at it, improved the man-section for<br>--local.<br><br>Change-Id: I63=
19c951327a9b994ffae0ba35270b0887455203<br>Signed-off-by: Gianmarco De Grego=
ri &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/link-options.r=
st<br>M doc/man-sections/vpn-network-options.rst<br>M src/openvpn/options.c=
<br>M src/openvpn/options.h<br>M src/openvpn/socket.c<br>5 files changed, 2=
9 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/25/1625/3</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst</spa=
n><br><span>index edda1ca..0c4df71 100644</span><br><span>--- a/doc/man-sec=
tions/link-options.rst</span><br><span>+++ b/doc/man-sections/link-options.=
rst</span><br><span>@@ -111,12 +111,17 @@</span><br><span>   Valid syntax:<=
/span><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     local host|* [port] [protocol]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     local host|* [port] [protocol] [bind=
 device]</span><br><span> </span><br><span>   Local host name or IP address=
 and port for bind. If specified, OpenVPN will bind</span><br><span>   to t=
his address. If unspecified, OpenVPN will bind to all interfaces.</span><br=
><span>   &#39;*&#39; can be used as hostname and means &#39;any host&#39; =
(OpenVPN will listen on what</span><br><span>   is returned by the OS).</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The optional arguments correspond to ex=
isting options: ``port`` to</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  ``--lport``, ``protocol`` to ``--proto``, and ``bind device`` to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--bind-dev``.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   On=
 a client, or in point-to-point mode, this can only be specified once (1 so=
cket).</span><br><span> </span><br><span>   On an OpenVPN setup running as =
``--server``, this can be specified multiple times</span><br><span>diff --g=
it a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-networ=
k-options.rst</span><br><span>index 33ebedb..3b30ed9 100644</span><br><span=
>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>+++ b/doc/m=
an-sections/vpn-network-options.rst</span><br><span>@@ -6,8 +6,10 @@</span>=
<br><span> routing.</span><br><span> </span><br><span> --bind-dev device</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  (Linux only) Set ``dev=
ice`` to bind the server socket to a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  (Linux only) Set ``device`` to bind all the server socke=
ts to a</span><br><span>   `Virtual Routing and Forwarding`_ device</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  This option can also be u=
sed inside a ``--local`` statement</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  allowing to bind a single socket to specific device.</span=
><br><span> </span><br><span> --block-ipv6</span><br><span>   On the client=
, instead of sending IPv6 packets over the VPN tunnel, all</span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index 70af6d2..63db6db 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -128,10 +128,=
12 @@</span><br><span>     &quot;--version       : Show copyright and versi=
on information.\n&quot;</span><br><span>     &quot;\n&quot;</span><br><span=
>     &quot;Tunnel Options:\n&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &quot;--local host|* [port]: Local host name or IP addres=
s and port for bind.\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;--local host|* [port] [protocol] [bind-dev]: Local host =
name or IP address and port for bind.\n&quot;</span><br><span>     &quot;  =
                      If specified, OpenVPN will bindto this address. If un=
specified,\n&quot;</span><br><span>     &quot;                        OpenV=
PN will bind to all interfaces. &#39;*&#39; can be used as hostname\n&quot;=
</span><br><span>     &quot;                        and means &#39;any host=
&#39; (OpenVPN will listen on what is returned by the OS).\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  =
      The optional arguments correspond to existing options: ``port`` to ``=
--lport``,\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;                        ``protocol`` to ``--proto``, and ``bind de=
vice`` to --bind-dev``.\n&quot;</span><br><span>     &quot;                =
        On a client, or in point-to-point mode, this can only be specified =
once (1 socket).\n&quot;</span><br><span>     &quot;                       =
 On an OpenVPN setup running as ``--server``, this can be specified multipl=
e times\n&quot;</span><br><span>     &quot;                        to open =
multiple listening sockets on different addresses and/or different ports.\n=
&quot;</span><br><span>@@ -3830,6 +3832,7 @@</span><br><span>         ASSER=
T(e);</span><br><span>         e-&gt;port =3D o-&gt;ce.local_port;</span><b=
r><span>         e-&gt;proto =3D o-&gt;ce.proto;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        e-&gt;bind_dev =3D o-&gt;bind_dev;</sp=
an><br><span>     }</span><br><span> </span><br><span>     /* use the same =
listen list for every outgoing connection */</span><br><span>@@ -5972,7 +59=
75,7 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><sp=
an>         options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0],=
 &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span=
>         struct local_entry *e;</span><br><span> </span><br><span>@@ -5998=
,6 +6001,17 @@</span><br><span>         {</span><br><span>             e-&g=
t;proto =3D ascii2proto(p[3]);</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            e-&gt;bind_dev =3D p[4];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_WARN, &quot;Note: bind_dev is ignored on n=
on-Linux systems&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;re=
mote-random&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span=
>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span=
>index a111cf8..c9f61d1 100644</span><br><span>--- a/src/openvpn/options.h<=
/span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -101,6 +101,=
7 @@</span><br><span>     const char *local;</span><br><span>     const cha=
r *port;</span><br><span>     int proto;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *bind_dev;</span><br><span> };</span><b=
r><span> </span><br><span> struct connection_entry</span><br><span>diff --g=
it a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 624c=
e4f..018d12d 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><s=
pan>+++ b/src/openvpn/socket.c</span><br><span>@@ -1349,6 +1349,7 @@</span>=
<br><span>     const char *host =3D o-&gt;ce.local_list-&gt;array[sock_inde=
x]-&gt;local;</span><br><span>     const char *port =3D o-&gt;ce.local_list=
-&gt;array[sock_index]-&gt;port;</span><br><span>     int proto =3D o-&gt;c=
e.local_list-&gt;array[sock_index]-&gt;proto;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *bind_dev =3D o-&gt;ce.local_list-=
&gt;array[sock_index]-&gt;bind_dev;</span><br><span>     const char *remote=
_host =3D o-&gt;ce.remote;</span><br><span>     const char *remote_port =3D=
 o-&gt;ce.remote_port;</span><br><span> </span><br><span>@@ -1409,7 +1410,8=
 @@</span><br><span> #endif</span><br><span> </span><br><span>     sock-&gt=
;mark =3D o-&gt;mark;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* bind_dev from local_list will trump the global=
 option */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-=
&gt;bind_dev =3D bind_dev ? bind_dev : o-&gt;bind_dev;</span><br><span>    =
 sock-&gt;info.proto =3D proto;</span><br><span>     sock-&gt;info.af =3D o=
-&gt;ce.af;</span><br><span>     sock-&gt;info.remote_float =3D o-&gt;ce.re=
mote_float;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">change 1625</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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

--SOndQkFVdAo=--

