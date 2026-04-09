From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 9 Apr 2026 13:33:36 +0000
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b5943bc16ef7dac20bb380768692d2444747a333-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BAS5GZnLte0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BAS5GZnLte0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail

to review the following change.


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
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
4 files changed, 19 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1625/1

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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b8d0f5a..6958953 100644
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
+            msg(M_WARN | M_ERRNO, "Note: bind_dev is ignored on non-Linux =
systems");
+        }
+#endif
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
@@ -6526,7 +6538,7 @@
             }
         }
     }
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX)
     else if (streq(p[0], "bind-dev") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 422820c..0c4d11c 100644
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
index 624ce4f..9c69ca4 100644
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
+    /* bind_dev from local_list will trump on the global option. */
+    sock->bind_dev =3D bind_dev ? bind_dev : o->bind_dev;
     sock->info.proto =3D proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--BAS5GZnLte0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Enable per-socket bind_dev via --local<br><=
br>A bind device can now be specified within a<br>--local statement allowin=
g to bind<br>different sockets to different devices.<br><br>Change-Id: I631=
9c951327a9b994ffae0ba35270b0887455203<br>Signed-off-by: Gianmarco De Gregor=
i &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/link-options.rs=
t<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/so=
cket.c<br>4 files changed, 19 insertions(+), 4 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25=
/1625/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/doc/man-sections/link-options.rst b/doc/man-se=
ctions/link-options.rst</span><br><span>index edda1ca..4b3200a 100644</span=
><br><span>--- a/doc/man-sections/link-options.rst</span><br><span>+++ b/do=
c/man-sections/link-options.rst</span><br><span>@@ -111,7 +111,7 @@</span><=
br><span>   Valid syntax:</span><br><span>   ::</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     local host|* [port] [proto=
col]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     local host=
|* [port] [protocol] [bind device]</span><br><span> </span><br><span>   Loc=
al host name or IP address and port for bind. If specified, OpenVPN will bi=
nd</span><br><span>   to this address. If unspecified, OpenVPN will bind to=
 all interfaces.</span><br><span>diff --git a/src/openvpn/options.c b/src/o=
penvpn/options.c</span><br><span>index b8d0f5a..6958953 100644</span><br><s=
pan>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c=
</span><br><span>@@ -3830,6 +3830,7 @@</span><br><span>         ASSERT(e);<=
/span><br><span>         e-&gt;port =3D o-&gt;ce.local_port;</span><br><spa=
n>         e-&gt;proto =3D o-&gt;ce.proto;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        e-&gt;bind_dev =3D o-&gt;bind_dev;</span><br=
><span>     }</span><br><span> </span><br><span>     /* use the same listen=
 list for every outgoing connection */</span><br><span>@@ -5972,7 +5973,7 @=
@</span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>   =
      options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot=
;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>     =
    struct local_entry *e;</span><br><span> </span><br><span>@@ -5998,6 +59=
99,17 @@</span><br><span>         {</span><br><span>             e-&gt;prot=
o =3D ascii2proto(p[3]);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            e-&gt;bind_dev =3D p[4];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (p[4])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(M_WARN | M_ERRNO, &quot;Note: bind_dev is ignored =
on non-Linux systems&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span>     }</span><br><span>     else if (streq(p[0], &quo=
t;remote-random&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><=
span>@@ -6526,7 +6538,7 @@</span><br><span>             }</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef TARGET_LINUX</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(TARGET_LINUX)</span><br><span>     else if (streq(p[=
0], &quot;bind-dev&quot;) &amp;&amp; p[1])</span><br><span>     {</span><br=
><span>         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span>diff --=
git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 4=
22820c..0c4d11c 100644</span><br><span>--- a/src/openvpn/options.h</span><b=
r><span>+++ b/src/openvpn/options.h</span><br><span>@@ -101,6 +101,7 @@</sp=
an><br><span>     const char *local;</span><br><span>     const char *port;=
</span><br><span>     int proto;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *bind_dev;</span><br><span> };</span><br><span>=
 </span><br><span> struct connection_entry</span><br><span>diff --git a/src=
/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 624ce4f..9c6=
9ca4 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ =
b/src/openvpn/socket.c</span><br><span>@@ -1349,6 +1349,7 @@</span><br><spa=
n>     const char *host =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;l=
ocal;</span><br><span>     const char *port =3D o-&gt;ce.local_list-&gt;arr=
ay[sock_index]-&gt;port;</span><br><span>     int proto =3D o-&gt;ce.local_=
list-&gt;array[sock_index]-&gt;proto;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *bind_dev =3D o-&gt;ce.local_list-&gt;arra=
y[sock_index]-&gt;bind_dev;</span><br><span>     const char *remote_host =
=3D o-&gt;ce.remote;</span><br><span>     const char *remote_port =3D o-&gt=
;ce.remote_port;</span><br><span> </span><br><span>@@ -1409,7 +1410,8 @@</s=
pan><br><span> #endif</span><br><span> </span><br><span>     sock-&gt;mark =
=3D o-&gt;mark;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    so=
ck-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* bind_dev from local_list will trump on the global op=
tion. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&g=
t;bind_dev =3D bind_dev ? bind_dev : o-&gt;bind_dev;</span><br><span>     s=
ock-&gt;info.proto =3D proto;</span><br><span>     sock-&gt;info.af =3D o-&=
gt;ce.af;</span><br><span>     sock-&gt;info.remote_float =3D o-&gt;ce.remo=
te_float;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">change 1625</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--BAS5GZnLte0=--

