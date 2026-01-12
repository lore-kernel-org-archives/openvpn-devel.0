From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 12 Jan 2026 14:19:26 +0000
References: <gerrit.1768227561000.I0aca7e7d9aa190541f11745cf72193cb6b39540a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a19ad8888857e6e4306f18a072ba378953ca82d1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ETOleRJ6ObU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ETOleRJ6ObU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail

to review the following change.


Change subject: socks: Replace magic "10" for socks header with macro
......................................................................

socks: Replace magic "10" for socks header with macro

So that it is easier to check that we indeed
have reserved this prior to assuming we have.

Github: openvpn-private-issues#4
Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/init.c
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/socks.c
4 files changed, 14 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1467/1

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
index 1e99c9a..078b4e1 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a
Gerrit-Change-Number: 1467
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ETOleRJ6ObU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1467?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socks: Replace magic &quot;10&quot; for soc=
ks header with macro<br><br>So that it is easier to check that we indeed<br=
>have reserved this prior to assuming we have.<br><br>Github: openvpn-priva=
te-issues#4<br>Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openv=
pn/init.c<br>M src/openvpn/mtu.c<br>M src/openvpn/mtu.h<br>M src/openvpn/so=
cks.c<br>4 files changed, 14 insertions(+), 9 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/=
1467/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><=
br><span>index b690dff..4c23170 100644</span><br><span>--- a/src/openvpn/in=
it.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2927,7 +2=
927,7 @@</span><br><span>     headroom +=3D 4;</span><br><span> </span><br>=
<span>     /* socks proxy header */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    headroom +=3D 10;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    headroom +=3D SOCKS_UDPv4_HEADROOM;</span><br><span> </=
span><br><span>     /* compression header and fragment header (part of the =
encrypted payload) */</span><br><span>     headroom +=3D 1 + 1;</span><br><=
span>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>ind=
ex 67ae67f..e5db8ab 100644</span><br><span>--- a/src/openvpn/mtu.c</span><b=
r><span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -66,11 +66,11 @@</span><=
br><span> </span><br><span>     bool tlsmode =3D options-&gt;tls_server || =
options-&gt;tls_client;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* A socks proxy adds 10 byte of extra header to ea=
ch packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A s=
ocks proxy adds extra header to each packet</span><br><span>      * (we onl=
y support Socks with IPv4, this value is different for IPv6) */</span><br><=
span>     if (options-&gt;ce.socks_proxy_server &amp;&amp; proto_is_udp(opt=
ions-&gt;ce.proto))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        header_size +=3D 10;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        header_size +=3D SOCKS_UDPv4_HEADROOM=
;</span><br><span>     }</span><br><span> </span><br><span>     /* TCP stre=
am based packets have a 16 bit length field */</span><br><span>diff --git a=
/src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index 29a7d04..ca810=
9c 100644</span><br><span>--- a/src/openvpn/mtu.h</span><br><span>+++ b/src=
/openvpn/mtu.h</span><br><span>@@ -94,6 +94,11 @@</span><br><span>  */</spa=
n><br><span> #define PAYLOAD_ALIGN 4</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * How many bytes we prepend for a SOCKS UDP proxy.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This only handles IPv4=
 right now.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SOCKS_UDPv4_HEAD=
ROOM 10</span><br><span> </span><br><span> /*******************************=
*******************************************/</span><br><span> /**</span><br=
><span>diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><sp=
an>index 1e99c9a..078b4e1 100644</span><br><span>--- a/src/openvpn/socks.c<=
/span><br><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -434,7 +434,7 =
@@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Remove the 10 byte socks5 header f=
rom an incoming</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * R=
emove the socks5 header from an incoming</span><br><span>  * UDP packet, se=
tting *from to the source address.</span><br><span>  *</span><br><span>  * =
Run after UDP read.</span><br><span>@@ -444,7 +444,7 @@</span><br><span> {<=
/span><br><span>     int atyp;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (BLEN(buf) &lt; 10)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; SOCKS_UDPv4_HEADRO=
OM)</span><br><span>     {</span><br><span>         goto error;</span><br><=
span>     }</span><br><span>@@ -471,7 +471,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Add a 10 byte socks header prior to UDP write.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Add a socks header prior to UDP wr=
ite.</span><br><span>  * *to is the destination address.</span><br><span>  =
*</span><br><span>  * Run before UDP write.</span><br><span>@@ -481,11 +481=
,11 @@</span><br><span> socks_process_outgoing_udp(struct buffer *buf, cons=
t struct link_socket_actual *to)</span><br><span> {</span><br><span>     /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Get a 10 byte =
subset buffer prepended to buf --</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * Get a subset buffer prepended to buf --</span><br><spa=
n>      * we expect these bytes will be here because</span><br><span>      =
* we always allocate space for these bytes</span><br><span>      */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer head =3D bu=
f_sub(buf, 10, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer head =3D buf_sub(buf, SOCKS_UDPv4_HEADROOM, true);</spa=
n><br><span> </span><br><span>     /* crash if not enough headroom in buf *=
/</span><br><span>     ASSERT(buf_defined(&amp;head));</span><br><span>@@ -=
496,5 +496,5 @@</span><br><span>     buf_write(&amp;head, &amp;to-&gt;dest.=
addr.in4.sin_addr, sizeof(to-&gt;dest.addr.in4.sin_addr));</span><br><span>=
     buf_write(&amp;head, &amp;to-&gt;dest.addr.in4.sin_port, sizeof(to-&gt=
;dest.addr.in4.sin_port));</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return 10;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return SOCKS_UDPv4_HEADROOM;</span><br><span> }</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1467?usp=3Demail">change 1467</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1467?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0aca7e7d9aa190541f11745cf72=
193cb6b39540a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1467 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ETOleRJ6ObU=--

