From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 18:28:50 +0000
In-Reply-To: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
References: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a7972e097a1c8e80b8028dab7acc330806298973-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0H10xAsAWFM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extend '--multihome'
 to selectively ignore the incoming interface index.
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

--0H10xAsAWFM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail

to look at the new patch set (#2).


Change subject: Extend '--multihome' to selectively ignore the incoming int=
erface index.
......................................................................

Extend '--multihome' to selectively ignore the incoming interface index.

Traditional OpenVPN ``--multihome`` behaviour is to send packets out the
same interface that they were received on (copy ipi_ifindex from ingress
to egress packet info).  For some scenarios this makes sense, for other
scenarios it is breaking connectivity when there are no routes pointing
out the ingress interface (intentionally asymmetric traffic).

Add a flag ``--multihome ignore-iif`` to always send out packets with
ipi_ifindex =3D 0, to follow normal system interface selection rules.

Github: OpenVPN/openvpn#855
Github: OpenVPN/openvpn#554

Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/server-options.rst
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/socket.h
4 files changed, 22 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1383/2

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 739be22..562783b 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -342,7 +342,7 @@
   by ``--ifconfig-ipv6``, OpenVPN will install a /128 host route for the
   ``ipv6addr`` IP address.

---multihome
+--multihome [ignore-iif]
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
   secondary IP addresses), and is not using ``--local`` to force binding
@@ -354,11 +354,13 @@

   *Notes:*
     -  This option is only relevant for UDP servers.
-    -  If you do an IPv6+IPv4 dual-stack bind on a Linux machine with
-       multiple IPv4 address, connections to IPv4 addresses will not
-       work right on kernels before 3.15, due to missing kernel
-       support for the IPv4-mapped case (some distributions have
-       ported this to earlier kernel versions, though).
+    -  This will copy the "ip_ifindex" from the incoming to the outgoing
+       packet by default, that is, try to send the packet out over the
+       same interface where it came in on.  This might not work if there
+       are not usable routes on that interface.
+    -  if the ``ignore-iif`` flag is added, the outgoing interface index
+       is set to ``0``, which means "do not force a particular outgoing
+       interface, use whatever the system will choose".

 --iroute args
   Generate an internal route to a specific client. The ``netmask``
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..1243e54 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6335,10 +6335,18 @@
         options->mlock =3D true;
     }
 #if ENABLE_IP_PKTINFO
-    else if (streq(p[0], "multihome") && !p[1])
+    else if (streq(p[0], "multihome") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sockflags |=3D SF_USE_IP_PKTINFO;
+        if (p[1] && streq(p[1], "ignore-iif"))
+        {
+            options->sockflags |=3D SF_PKTINFO_IGN_IIF;
+        }
+        else if (p[1])
+        {
+            msg(msglevel, "Unknown parameter to --multihome: %s", p[1]);
+        }
     }
 #endif
     else if (streq(p[0], "verb") && p[1] && !p[2])
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8b6e35e..0217408 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2393,7 +2393,8 @@
         {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
             struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cms=
g);
-            from->pi.in4.ipi_ifindex =3D pkti->ipi_ifindex;
+            from->pi.in4.ipi_ifindex =3D
+                (sock->sockflags & SF_PKTINFO_IGN_IIF) ? 0 : pkti->ipi_ifi=
ndex;
             from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
             from->pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
@@ -2406,7 +2407,8 @@
                  && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in6_pktinfo=
)))
         {
             struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(=
cmsg);
-            from->pi.in6.ipi6_ifindex =3D pkti6->ipi6_ifindex;
+            from->pi.in6.ipi6_ifindex =3D
+                (sock->sockflags & SF_PKTINFO_IGN_IIF) ? 0 : pkti6->ipi6_i=
findex;
             from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
         }
         else if (cmsg !=3D NULL)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 832d62e..d6ff258 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -195,6 +195,7 @@
 #define SF_GETADDRINFO_DGRAM (1 << 4)
 #define SF_DCO_WIN           (1 << 5)
 #define SF_PREPEND_SA        (1 << 6)
+#define SF_PKTINFO_IGN_IIF   (1 << 7)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Gerrit-Change-Number: 1383
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--0H10xAsAWFM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Extend &#39;--multihome&#39; to selectively ignore the =
incoming interface index.<br><br>Traditional OpenVPN ``--multihome`` behavi=
our is to send packets out the<br>same interface that they were received on=
 (copy ipi_ifindex from ingress<br>to egress packet info).  For some scenar=
ios this makes sense, for other<br>scenarios it is breaking connectivity wh=
en there are no routes pointing<br>out the ingress interface (intentionally=
 asymmetric traffic).<br><br>Add a flag ``--multihome ignore-iif`` to alway=
s send out packets with<br>ipi_ifindex =3D 0, to follow normal system inter=
face selection rules.<br><br>Github: OpenVPN/openvpn#855<br>Github: OpenVPN=
/openvpn#554<br><br>Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-se=
ctions/server-options.rst<br>M src/openvpn/options.c<br>M src/openvpn/socke=
t.c<br>M src/openvpn/socket.h<br>4 files changed, 22 insertions(+), 9 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/83/1383/2</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server=
-options.rst b/doc/man-sections/server-options.rst</span><br><span>index 73=
9be22..562783b 100644</span><br><span>--- a/doc/man-sections/server-options=
.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</span><br><s=
pan>@@ -342,7 +342,7 @@</span><br><span>   by ``--ifconfig-ipv6``, OpenVPN =
will install a /128 host route for the</span><br><span>   ``ipv6addr`` IP a=
ddress.</span><br><span> </span><br><span>---multihome</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+--multihome [ignore-iif]</span><br><span=
>   Configure a multi-homed UDP server. This option needs to be used when a=
</span><br><span>   server has more than one IP address (e.g. multiple inte=
rfaces, or</span><br><span>   secondary IP addresses), and is not using ``-=
-local`` to force binding</span><br><span>@@ -354,11 +354,13 @@</span><br><=
span> </span><br><span>   *Notes:*</span><br><span>     -  This option is o=
nly relevant for UDP servers.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    -  If you do an IPv6+IPv4 dual-stack bind on a Linux machine wi=
th</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       multiple IPv=
4 address, connections to IPv4 addresses will not</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-       work right on kernels before 3.15, due t=
o missing kernel</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
  support for the IPv4-mapped case (some distributions have</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-       ported this to earlier kernel =
versions, though).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   -  This will copy the &quot;ip_ifindex&quot; from the incoming to the ou=
tgoing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       packet=
 by default, that is, try to send the packet out over the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+       same interface where it came i=
n on.  This might not work if there</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+       are not usable routes on that interface.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    -  if the ``ignore-iif`` fl=
ag is added, the outgoing interface index</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+       is set to ``0``, which means &quot;do not forc=
e a particular outgoing</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+       interface, use whatever the system will choose&quot;.</span><br>=
<span> </span><br><span> --iroute args</span><br><span>   Generate an inter=
nal route to a specific client. The ``netmask``</span><br><span>diff --git =
a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 47943=
15..1243e54 100644</span><br><span>--- a/src/openvpn/options.c</span><br><s=
pan>+++ b/src/openvpn/options.c</span><br><span>@@ -6335,10 +6335,18 @@</sp=
an><br><span>         options-&gt;mlock =3D true;</span><br><span>     }</s=
pan><br><span> #if ENABLE_IP_PKTINFO</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    else if (streq(p[0], &quot;multihome&quot;) &amp;&amp; !=
p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;multihome&quot;) &amp;&amp; !p[2])</span><br><span>     {<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>=
         options-&gt;sockflags |=3D SF_USE_IP_PKTINFO;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p[1] &amp;&amp; streq(p[1], =
&quot;ignore-iif&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       options-&gt;sockflags |=3D SF_PKTINFO_IGN_IIF;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (p[1])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(msglevel, &quot;Unknown parameter to --mul=
tihome: %s&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>     }</span><br><span> #endif</span><br><sp=
an>     else if (streq(p[0], &quot;verb&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socke=
t.c</span><br><span>index 8b6e35e..0217408 100644</span><br><span>--- a/src=
/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><spa=
n>@@ -2393,7 +2393,8 @@</span><br><span>         {</span><br><span> #if def=
ined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span=
>             struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cm=
sg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            from-=
&gt;pi.in4.ipi_ifindex =3D pkti-&gt;ipi_ifindex;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            from-&gt;pi.in4.ipi_ifindex =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                (sock-=
&gt;sockflags &amp; SF_PKTINFO_IGN_IIF) ? 0 : pkti-&gt;ipi_ifindex;</span><=
br><span>             from-&gt;pi.in4.ipi_spec_dst =3D pkti-&gt;ipi_spec_ds=
t;</span><br><span> #elif defined(IP_RECVDSTADDR)</span><br><span>         =
    from-&gt;pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);</span><br><span=
>@@ -2406,7 +2407,8 @@</span><br><span>                  &amp;&amp; cmsg-&g=
t;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br><span>  =
       {</span><br><span>             struct in6_pktinfo *pkti6 =3D (struct=
 in6_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            from-&gt;pi.in6.ipi6_ifindex =3D pkti6-&gt;ipi6_ifind=
ex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            from=
-&gt;pi.in6.ipi6_ifindex =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                (sock-&gt;sockflags &amp; SF_PKTINFO_IGN_IIF) ? 0 =
: pkti6-&gt;ipi6_ifindex;</span><br><span>             from-&gt;pi.in6.ipi6=
_addr =3D pkti6-&gt;ipi6_addr;</span><br><span>         }</span><br><span> =
        else if (cmsg !=3D NULL)</span><br><span>diff --git a/src/openvpn/s=
ocket.h b/src/openvpn/socket.h</span><br><span>index 832d62e..d6ff258 10064=
4</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/open=
vpn/socket.h</span><br><span>@@ -195,6 +195,7 @@</span><br><span> #define S=
F_GETADDRINFO_DGRAM (1 &lt;&lt; 4)</span><br><span> #define SF_DCO_WIN     =
      (1 &lt;&lt; 5)</span><br><span> #define SF_PREPEND_SA        (1 &lt;&=
lt; 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SF_PK=
TINFO_IGN_IIF   (1 &lt;&lt; 7)</span><br><span>     unsigned int sockflags;=
</span><br><span>     int mark;</span><br><span>     const char *bind_dev;<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1383?usp=3Demail">change 1383</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1383?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc3=
57c910f3bde4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1383 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--0H10xAsAWFM=--

