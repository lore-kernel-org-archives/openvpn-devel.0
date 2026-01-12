From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 12 Jan 2026 18:00:46 +0000
In-Reply-To: <gerrit.1768227561000.I0aca7e7d9aa190541f11745cf72193cb6b39540a@...2715...>
References: <gerrit.1768227561000.I0aca7e7d9aa190541f11745cf72193cb6b39540a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c6e6fbd3d5a1fc9e1f227653f62d87c65c8ed47b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gZdFCeEnL2I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socks: Replace magic
 "10" for socks header with macro
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gZdFCeEnL2I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: socks: Replace magic "10" for socks header with macro
......................................................................

socks: Replace magic "10" for socks header with macro

So that it is easier to check that we indeed
have reserved this prior to assuming we have.

Github: openvpn-private-issues#4
Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1467
Message-Id: <20260112171122.3994-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
214.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/socks.c
4 files changed, 14 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1467/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b690dff..4c23170 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2927,7 +2927,7 @@
     headroom +=3D 4;

     /* socks proxy header */
-    headroom +=3D 10;
+    headroom +=3D SOCKS_UDPv4_HEADROOM;

     /* compression header and fragment header (part of the encrypted paylo=
ad) */
     headroom +=3D 1 + 1;
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 67ae67f..e5db8ab 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -66,11 +66,11 @@

     bool tlsmode =3D options->tls_server || options->tls_client;

-    /* A socks proxy adds 10 byte of extra header to each packet
+    /* A socks proxy adds extra header to each packet
      * (we only support Socks with IPv4, this value is different for IPv6)=
 */
     if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto))
     {
-        header_size +=3D 10;
+        header_size +=3D SOCKS_UDPv4_HEADROOM;
     }

     /* TCP stream based packets have a 16 bit length field */
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 29a7d04..ca8109c 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -94,6 +94,11 @@
  */
 #define PAYLOAD_ALIGN 4

+/*
+ * How many bytes we prepend for a SOCKS UDP proxy.
+ * This only handles IPv4 right now.
+ */
+#define SOCKS_UDPv4_HEADROOM 10

 /*************************************************************************=
*/
 /**
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ed2d9e9..671d33c 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -434,7 +434,7 @@
 }

 /*
- * Remove the 10 byte socks5 header from an incoming
+ * Remove the socks5 header from an incoming
  * UDP packet, setting *from to the source address.
  *
  * Run after UDP read.
@@ -444,7 +444,7 @@
 {
     int atyp;

-    if (BLEN(buf) < 10)
+    if (BLEN(buf) < SOCKS_UDPv4_HEADROOM)
     {
         goto error;
     }
@@ -471,7 +471,7 @@
 }

 /*
- * Add a 10 byte socks header prior to UDP write.
+ * Add a socks header prior to UDP write.
  * *to is the destination address.
  *
  * Run before UDP write.
@@ -481,11 +481,11 @@
 socks_process_outgoing_udp(struct buffer *buf, const struct link_socket_ac=
tual *to)
 {
     /*
-     * Get a 10 byte subset buffer prepended to buf --
+     * Get a subset buffer prepended to buf --
      * we expect these bytes will be here because
      * we always allocate space for these bytes
      */
-    struct buffer head =3D buf_sub(buf, 10, true);
+    struct buffer head =3D buf_sub(buf, SOCKS_UDPv4_HEADROOM, true);

     /* crash if not enough headroom in buf */
     ASSERT(buf_defined(&head));
@@ -496,5 +496,5 @@
     buf_write(&head, &to->dest.addr.in4.sin_addr, sizeof(to->dest.addr.in4=
.sin_addr));
     buf_write(&head, &to->dest.addr.in4.sin_port, sizeof(to->dest.addr.in4=
.sin_port));

-    return 10;
+    return SOCKS_UDPv4_HEADROOM;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a
Gerrit-Change-Number: 1467
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gZdFCeEnL2I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">socks: Replace magic &quot;10&q=
uot; for socks header with macro<br><br>So that it is easier to check that =
we indeed<br>have reserved this prior to assuming we have.<br><br>Github: o=
penvpn-private-issues#4<br>Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39=
540a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-=
by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://ger=
rit.openvpn.net/c/openvpn/+/1467<br>Message-Id: &lt;20260112171122.3994-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35214.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvpn/mtu.c<br>M src/o=
penvpn/mtu.h<br>M src/openvpn/socks.c<br>4 files changed, 14 insertions(+),=
 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/67/1467/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ini=
t.c b/src/openvpn/init.c</span><br><span>index b690dff..4c23170 100644</spa=
n><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init=
.c</span><br><span>@@ -2927,7 +2927,7 @@</span><br><span>     headroom +=3D=
 4;</span><br><span> </span><br><span>     /* socks proxy header */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    headroom +=3D 10;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    headroom +=3D SOCKS_UDP=
v4_HEADROOM;</span><br><span> </span><br><span>     /* compression header a=
nd fragment header (part of the encrypted payload) */</span><br><span>     =
headroom +=3D 1 + 1;</span><br><span>diff --git a/src/openvpn/mtu.c b/src/o=
penvpn/mtu.c</span><br><span>index 67ae67f..e5db8ab 100644</span><br><span>=
--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</span><br><=
span>@@ -66,11 +66,11 @@</span><br><span> </span><br><span>     bool tlsmod=
e =3D options-&gt;tls_server || options-&gt;tls_client;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* A socks proxy ad=
ds 10 byte of extra header to each packet</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* A socks proxy adds extra header to each packet=
</span><br><span>      * (we only support Socks with IPv4, this value is di=
fferent for IPv6) */</span><br><span>     if (options-&gt;ce.socks_proxy_se=
rver &amp;&amp; proto_is_udp(options-&gt;ce.proto))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        header_size +=
=3D 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        head=
er_size +=3D SOCKS_UDPv4_HEADROOM;</span><br><span>     }</span><br><span> =
</span><br><span>     /* TCP stream based packets have a 16 bit length fiel=
d */</span><br><span>diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</sp=
an><br><span>index 29a7d04..ca8109c 100644</span><br><span>--- a/src/openvp=
n/mtu.h</span><br><span>+++ b/src/openvpn/mtu.h</span><br><span>@@ -94,6 +9=
4,11 @@</span><br><span>  */</span><br><span> #define PAYLOAD_ALIGN 4</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * How many bytes we pre=
pend for a SOCKS UDP proxy.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * This only handles IPv4 right now.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define SOCKS_UDPv4_HEADROOM 10</span><br><span> </span><br><span>=
 /*************************************************************************=
*/</span><br><span> /**</span><br><span>diff --git a/src/openvpn/socks.c b/=
src/openvpn/socks.c</span><br><span>index ed2d9e9..671d33c 100644</span><br=
><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c<=
/span><br><span>@@ -434,7 +434,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * R=
emove the 10 byte socks5 header from an incoming</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Remove the socks5 header from an incoming</=
span><br><span>  * UDP packet, setting *from to the source address.</span><=
br><span>  *</span><br><span>  * Run after UDP read.</span><br><span>@@ -44=
4,7 +444,7 @@</span><br><span> {</span><br><span>     int atyp;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (BLEN(bu=
f) &lt; 10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
BLEN(buf) &lt; SOCKS_UDPv4_HEADROOM)</span><br><span>     {</span><br><span=
>         goto error;</span><br><span>     }</span><br><span>@@ -471,7 +471=
,7 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Add a 10 byte socks header prio=
r to UDP write.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A=
dd a socks header prior to UDP write.</span><br><span>  * *to is the destin=
ation address.</span><br><span>  *</span><br><span>  * Run before UDP write=
.</span><br><span>@@ -481,11 +481,11 @@</span><br><span> socks_process_outg=
oing_udp(struct buffer *buf, const struct link_socket_actual *to)</span><br=
><span> {</span><br><span>     /*</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * Get a 10 byte subset buffer prepended to buf --</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * Get a subset buffer p=
repended to buf --</span><br><span>      * we expect these bytes will be he=
re because</span><br><span>      * we always allocate space for these bytes=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct buffer head =3D buf_sub(buf, 10, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer head =3D buf_sub(buf, =
SOCKS_UDPv4_HEADROOM, true);</span><br><span> </span><br><span>     /* cras=
h if not enough headroom in buf */</span><br><span>     ASSERT(buf_defined(=
&amp;head));</span><br><span>@@ -496,5 +496,5 @@</span><br><span>     buf_w=
rite(&amp;head, &amp;to-&gt;dest.addr.in4.sin_addr, sizeof(to-&gt;dest.addr=
.in4.sin_addr));</span><br><span>     buf_write(&amp;head, &amp;to-&gt;dest=
.addr.in4.sin_port, sizeof(to-&gt;dest.addr.in4.sin_port));</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 10;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return SOCKS_UDPv4_H=
EADROOM;</span><br><span> }</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail">chan=
ge 1467</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0aca7e7d9aa190541f11745cf72=
193cb6b39540a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1467 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gZdFCeEnL2I=--

