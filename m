From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 18:05:13 +0000
In-Reply-To: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
References: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4e3bc911e6e14d4182b366e77757bfdd47e3da32-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TGT+xM/Y6o8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change '--multihome'
 behaviour regarding egress interface selection.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TGT+xM/Y6o8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
83?usp=3Demail )

Change subject: Change '--multihome' behaviour regarding egress interface s=
election.
......................................................................

Change '--multihome' behaviour regarding egress interface selection.

Traditional OpenVPN ``--multihome`` behaviour is to send packets out the
same interface that they were received on (copy ipi_ifindex from ingress
to egress packet info).  For some scenarios this makes sense, for other
scenarios it is breaking connectivity when there are no routes pointing
out the ingress interface (intentionally asymmetric traffic).

For 2.7.0, change the default(!) to always send out packets with
ipi_ifindex =3D 0, to follow normal system interface selection rules.

Add a flag ``--multihome same-interface`` to restore the pre-2.7 behavior
of copying ipi_ifindex from ingress to egress packets.  There are use
cases for this, and we want to give users a chance to read the release
notes and adjust their setups to "not break after upgrading to 2.7.0".

Github: OpenVPN/openvpn#855
Github: OpenVPN/openvpn#554

v2: fix whitespace
v3: turn logic around - new default is "egress ifindex 0" now
v4: typo fixed in commit message
v5: fix invalid rst in Changes.rst

Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1383
Message-Id: <20251126130410.19091-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
709.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/socket.h
5 files changed, 33 insertions(+), 10 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 9077064..40984f5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -326,6 +326,12 @@
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
   change the default adapter type created to `ovpn-dco`.

+- the default for ``multihome`` egress interface handling has changed.
+  2.7.0 will default to ipi_ifindex=3D0, that is, leave the decision to the
+  routing/policy setup of the operating system.  The pre-2.7 behaviour
+  (force egress =3D ingress interface) can be achieved with the new
+  ``--multihome same-interface`` sub-option.
+
 Deprecated features
 -------------------
 ``--opt-verify`` feature removed
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 739be22..3760694 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -342,7 +342,7 @@
   by ``--ifconfig-ipv6``, OpenVPN will install a /128 host route for the
   ``ipv6addr`` IP address.

---multihome
+--multihome [same-interface]
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
   secondary IP addresses), and is not using ``--local`` to force binding
@@ -353,12 +353,18 @@
   default.

   *Notes:*
-    -  This option is only relevant for UDP servers.
-    -  If you do an IPv6+IPv4 dual-stack bind on a Linux machine with
-       multiple IPv4 address, connections to IPv4 addresses will not
-       work right on kernels before 3.15, due to missing kernel
-       support for the IPv4-mapped case (some distributions have
-       ported this to earlier kernel versions, though).
+    - This option is only relevant for UDP servers.
+    - Starting with 2.7.0, OpenVPN will ignore the incoming interface of
+      the packet, and leave selection of the outgoing interface to the
+      normal routing/policy mechanisms of the OS ("set ipi_ifindex=3D0").
+    - if the ``same-interface`` flag is added, OpenVPN will copy the
+      incoming interface index to the outgoing interface index,
+      trying to send the packet out over the same interface where it came
+      in on (=3D restoring earlier OpenVPN behaviour). This might not work
+      if there are no usable routes on that interface.
+    - the \*BSD systems use a different API for IPv4 that does not provide
+      the interface index anyway (IP_RECVDSTADDR), so there the difference
+      applies only to IPv6.

 --iroute args
   Generate an internal route to a specific client. The ``netmask``
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..62f84dd 100644
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
+        if (p[1] && streq(p[1], "same-interface"))
+        {
+            options->sockflags |=3D SF_PKTINFO_COPY_IIF;
+        }
+        else if (p[1])
+        {
+            msg(msglevel, "Unknown parameter to --multihome: %s", p[1]);
+        }
     }
 #endif
     else if (streq(p[0], "verb") && p[1] && !p[2])
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8b6e35e..747c7a7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2393,7 +2393,8 @@
         {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
             struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cms=
g);
-            from->pi.in4.ipi_ifindex =3D pkti->ipi_ifindex;
+            from->pi.in4.ipi_ifindex =3D
+                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifinde=
x : 0;
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
+                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifin=
dex : 0;
             from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
         }
         else if (cmsg !=3D NULL)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 832d62e..7cf5b72 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -195,6 +195,7 @@
 #define SF_GETADDRINFO_DGRAM (1 << 4)
 #define SF_DCO_WIN           (1 << 5)
 #define SF_PREPEND_SA        (1 << 6)
+#define SF_PKTINFO_COPY_IIF  (1 << 7)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Gerrit-Change-Number: 1383
Gerrit-PatchSet: 6
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TGT+xM/Y6o8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1383?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change &#39;--multihome&#39; behaviour regarding=
 egress interface selection.<br><br>Traditional OpenVPN ``--multihome`` beh=
aviour is to send packets out the<br>same interface that they were received=
 on (copy ipi_ifindex from ingress<br>to egress packet info).  For some sce=
narios this makes sense, for other<br>scenarios it is breaking connectivity=
 when there are no routes pointing<br>out the ingress interface (intentiona=
lly asymmetric traffic).<br><br>For 2.7.0, change the default(!) to always =
send out packets with<br>ipi_ifindex =3D 0, to follow normal system interfa=
ce selection rules.<br><br>Add a flag ``--multihome same-interface`` to res=
tore the pre-2.7 behavior<br>of copying ipi_ifindex from ingress to egress =
packets.  There are use<br>cases for this, and we want to give users a chan=
ce to read the release<br>notes and adjust their setups to &quot;not break =
after upgrading to 2.7.0&quot;.<br><br>Github: OpenVPN/openvpn#855<br>Githu=
b: OpenVPN/openvpn#554<br><br>v2: fix whitespace<br>v3: turn logic around -=
 new default is &quot;egress ifindex 0&quot; now<br>v4: typo fixed in commi=
t message<br>v5: fix invalid rst in Changes.rst<br><br>Change-Id: Id429241e=
1b17a8ff51d9019efc357c910f3bde4c<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1383<br>Message-Id: &lt;202=
51126130410.19091-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg34709.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sectio=
ns/server-options.rst<br>M src/openvpn/options.c<br>M src/openvpn/socket.c<=
br>M src/openvpn/socket.h<br>5 files changed, 33 insertions(+), 10 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 9077064..40=
984f5 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -326,6 +326,12 @@</span><br><span>   Win-DCO as we=
ll), add printing of the hwid to all adapter outputs, and</span><br><span> =
  change the default adapter type created to `ovpn-dco`.</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+- the default for ``=
multihome`` egress interface handling has changed.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  2.7.0 will default to ipi_ifindex=3D0, tha=
t is, leave the decision to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  routing/policy setup of the operating system.  The pre-2.7 be=
haviour</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (force egr=
ess =3D ingress interface) can be achieved with the new</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``--multihome same-interface`` sub-op=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> Deprecated features</span><br><span> -------------------</span><br><spa=
n> ``--opt-verify`` feature removed</span><br><span>diff --git a/doc/man-se=
ctions/server-options.rst b/doc/man-sections/server-options.rst</span><br><=
span>index 739be22..3760694 100644</span><br><span>--- a/doc/man-sections/s=
erver-options.rst</span><br><span>+++ b/doc/man-sections/server-options.rst=
</span><br><span>@@ -342,7 +342,7 @@</span><br><span>   by ``--ifconfig-ipv=
6``, OpenVPN will install a /128 host route for the</span><br><span>   ``ip=
v6addr`` IP address.</span><br><span> </span><br><span>---multihome</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+--multihome [same-interface=
]</span><br><span>   Configure a multi-homed UDP server. This option needs =
to be used when a</span><br><span>   server has more than one IP address (e=
.g. multiple interfaces, or</span><br><span>   secondary IP addresses), and=
 is not using ``--local`` to force binding</span><br><span>@@ -353,12 +353,=
18 @@</span><br><span>   default.</span><br><span> </span><br><span>   *Not=
es:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    -  This optio=
n is only relevant for UDP servers.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    -  If you do an IPv6+IPv4 dual-stack bind on a Linux mach=
ine with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       multip=
le IPv4 address, connections to IPv4 addresses will not</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-       work right on kernels before 3.15,=
 due to missing kernel</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-       support for the IPv4-mapped case (some distributions have</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-       ported this to earlier k=
ernel versions, though).</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    - This option is only relevant for UDP servers.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    - Starting with 2.7.0, OpenVPN wil=
l ignore the incoming interface of</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      the packet, and leave selection of the outgoing interf=
ace to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      nor=
mal routing/policy mechanisms of the OS (&quot;set ipi_ifindex=3D0&quot;).<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - if the ``same-=
interface`` flag is added, OpenVPN will copy the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      incoming interface index to the outgoing=
 interface index,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    trying to send the packet out over the same interface where it came</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      in on (=3D restor=
ing earlier OpenVPN behaviour). This might not work</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      if there are no usable routes on th=
at interface.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - =
the \*BSD systems use a different API for IPv4 that does not provide</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      the interface index =
anyway (IP_RECVDSTADDR), so there the difference</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      applies only to IPv6.</span><br><span> <=
/span><br><span> --iroute args</span><br><span>   Generate an internal rout=
e to a specific client. The ``netmask``</span><br><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index 4794315..62f8=
4dd 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -6335,10 +6335,18 @@</span><br><=
span>         options-&gt;mlock =3D true;</span><br><span>     }</span><br>=
<span> #if ENABLE_IP_PKTINFO</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (streq(p[0], &quot;multihome&quot;) &amp;&amp; !p[1])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0=
], &quot;multihome&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>        =
 options-&gt;sockflags |=3D SF_USE_IP_PKTINFO;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p[1] &amp;&amp; streq(p[1], &quot;sa=
me-interface&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   options-&gt;sockflags |=3D SF_PKTINFO_COPY_IIF;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else if (p[1])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel, &quot;Unknown parameter to --multih=
ome: %s&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>     }</span><br><span> #endif</span><br><span>=
     else if (streq(p[0], &quot;verb&quot;) &amp;&amp; p[1] &amp;&amp; !p[2=
])</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c=
</span><br><span>index 8b6e35e..747c7a7 100644</span><br><span>--- a/src/op=
envpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@=
@ -2393,7 +2393,8 @@</span><br><span>         {</span><br><span> #if define=
d(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span>  =
           struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cmsg)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            from-&gt=
;pi.in4.ipi_ifindex =3D pkti-&gt;ipi_ifindex;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            from-&gt;pi.in4.ipi_ifindex =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                (sock-&gt=
;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkti-&gt;ipi_ifindex : 0;</span><br=
><span>             from-&gt;pi.in4.ipi_spec_dst =3D pkti-&gt;ipi_spec_dst;=
</span><br><span> #elif defined(IP_RECVDSTADDR)</span><br><span>           =
  from-&gt;pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);</span><br><span>@=
@ -2406,7 +2407,8 @@</span><br><span>                  &amp;&amp; cmsg-&gt;=
cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br><span>    =
     {</span><br><span>             struct in6_pktinfo *pkti6 =3D (struct i=
n6_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            from-&gt;pi.in6.ipi6_ifindex =3D pkti6-&gt;ipi6_ifindex=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            from-&=
gt;pi.in6.ipi6_ifindex =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkt=
i6-&gt;ipi6_ifindex : 0;</span><br><span>             from-&gt;pi.in6.ipi6_=
addr =3D pkti6-&gt;ipi6_addr;</span><br><span>         }</span><br><span>  =
       else if (cmsg !=3D NULL)</span><br><span>diff --git a/src/openvpn/so=
cket.h b/src/openvpn/socket.h</span><br><span>index 832d62e..7cf5b72 100644=
</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openv=
pn/socket.h</span><br><span>@@ -195,6 +195,7 @@</span><br><span> #define SF=
_GETADDRINFO_DGRAM (1 &lt;&lt; 4)</span><br><span> #define SF_DCO_WIN      =
     (1 &lt;&lt; 5)</span><br><span> #define SF_PREPEND_SA        (1 &lt;&l=
t; 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SF_PKT=
INFO_COPY_IIF  (1 &lt;&lt; 7)</span><br><span>     unsigned int sockflags;<=
/span><br><span>     int mark;</span><br><span>     const char *bind_dev;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1383?usp=3Demail">change 1383</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1383?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc3=
57c910f3bde4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1383 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--TGT+xM/Y6o8=--

