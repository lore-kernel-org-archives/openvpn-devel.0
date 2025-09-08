From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Sep 2025 10:17:25 +0000
In-Reply-To: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
References: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <4fa01483a4e636fb10c2399f25f8c0a39b1de900-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MIb5MqP6jVU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dco: support
 float notifications on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: ralf_lici <ralf@...2726...>, mandree <matthias.andree@...68...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MIb5MqP6jVU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
70?usp=3Demail )

Change subject: dco: support float notifications on FreeBSD
......................................................................

dco: support float notifications on FreeBSD

this is a backport of commit b66b80b2ab and 796ad2c559
(squashed, as the second commit undoes quite a bit of #ifdef from the first)

See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D289303 for all
the epic details...

Change-Id: I53e6d1b31c4f673cb646716dce774ef3210f36bd
Signed-off-by: Kristof Provost <kprovost@...2661...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
(cherry picked from commit b66b80b2ab73bb422826911b675798e6b789ef03)
(cherry picked from commit 796ad2c55951635382e48ea5b71d13bbb83ebfb1)
Message-Id: <20250908083354.19811-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
827.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/multi.c
M src/openvpn/ovpn_dco_freebsd.h
4 files changed, 78 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ed7ea92..25532d4 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,6 +72,61 @@
     return (nvl);
 }

+static bool
+nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
+{
+    if (!nvlist_exists_number(nvl, "af"))
+    {
+        return (false);
+    }
+    if (!nvlist_exists_binary(nvl, "address"))
+    {
+        return (false);
+    }
+    if (!nvlist_exists_number(nvl, "port"))
+    {
+        return (false);
+    }
+
+    ss->ss_family =3D nvlist_get_number(nvl, "af");
+
+    switch (ss->ss_family)
+    {
+        case AF_INET:
+        {
+            struct sockaddr_in *in =3D (struct sockaddr_in *)ss;
+            const void *data;
+            size_t len;
+
+            in->sin_len =3D sizeof(*in);
+            data =3D nvlist_get_binary(nvl, "address", &len);
+            assert(len =3D=3D sizeof(in->sin_addr));
+            memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
+            in->sin_port =3D nvlist_get_number(nvl, "port");
+            break;
+        }
+
+        case AF_INET6:
+        {
+            struct sockaddr_in6 *in6 =3D (struct sockaddr_in6 *)ss;
+            const void *data;
+            size_t len;
+
+            in6->sin6_len =3D sizeof(*in6);
+            data =3D nvlist_get_binary(nvl, "address", &len);
+            assert(len =3D=3D sizeof(in6->sin6_addr));
+            memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
+            in6->sin6_port =3D nvlist_get_number(nvl, "port");
+            break;
+        }
+
+        default:
+            return (false);
+    }
+
+    return (true);
+}
+
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
@@ -571,6 +626,25 @@
             dco->dco_message_type =3D OVPN_CMD_SWAP_KEYS;
             break;

+        case OVPN_NOTIF_FLOAT: {
+            const nvlist_t *address;
+
+            if (!nvlist_exists_nvlist(nvl, "address"))
+            {
+                msg(M_WARN, "Float notification without address");
+                break;
+            }
+
+            address =3D nvlist_get_nvlist(nvl, "address");
+            if (!nvlist_to_sockaddr(address, &dco->dco_float_peer_ss))
+            {
+                msg(M_WARN, "Failed to parse float notification");
+                break;
+            }
+            dco->dco_message_type =3D OVPN_CMD_FLOAT_PEER;
+            break;
+        }
+
         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
             break;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e1a054e..ab5891e 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -36,6 +36,7 @@
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_FLOAT_PEER,
 };

 enum ovpn_del_reason_t {
@@ -55,6 +56,7 @@
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index eb5f932..310211c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3313,7 +3313,7 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if 0
+#if defined(TARGET_FREEBSD)
         else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_socket);
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index 53f94df..7eb643b 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -37,6 +37,7 @@
 enum ovpn_notif_type {
     OVPN_NOTIF_DEL_PEER,
     OVPN_NOTIF_ROTATE_KEY,
+    OVPN_NOTIF_FLOAT,
 };

 enum ovpn_del_reason {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I53e6d1b31c4f673cb646716dce774ef3210f36bd
Gerrit-Change-Number: 1170
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--MIb5MqP6jVU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1170?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco: support float notifications on FreeBSD<b=
r><br>this is a backport of commit b66b80b2ab and 796ad2c559<br>(squashed, =
as the second commit undoes quite a bit of #ifdef from the first)<br><br>Se=
e https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D289303 for all<br>the=
 epic details...<br><br>Change-Id: I53e6d1b31c4f673cb646716dce774ef3210f36b=
d<br>Signed-off-by: Kristof Provost &lt;kprovost@...2661...&gt;<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Ralf Lici &lt;ralf=
@...2726...&gt;<br>(cherry picked from commit b66b80b2ab73bb422826911b67579=
8e6b789ef03)<br>(cherry picked from commit 796ad2c55951635382e48ea5b71d13bb=
b83ebfb1)<br>Message-Id: &lt;20250908083354.19811-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
827.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>M src/openvpn/=
multi.c<br>M src/openvpn/ovpn_dco_freebsd.h<br>4 files changed, 78 insertio=
ns(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index ed7ea92..25532d4 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -72,6 +72,61 @@</span><br><span>     return (nvl);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nvlist_to=
_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!nvlist_exists_number(nvl, &quot;af&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return (false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!nvlist_exists_binary(nvl, &quot;addr=
ess&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!nvlist_exists_number(nv=
l, &quot;port&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn (false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ss-&gt;ss_family =3D nvlist_get_numbe=
r(nvl, &quot;af&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (ss-=
&gt;ss_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INE=
T:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct sockaddr=
_in *in =3D (struct sockaddr_in *)ss;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            const void *data;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            size_t len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            in-&gt;sin_len =3D sizeof(*in);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            data =3D nvlist_get_bina=
ry(nvl, &quot;address&quot;, &amp;len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            assert(len =3D=3D sizeof(in-&gt;sin_addr));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(=
&amp;in-&gt;sin_addr, data, sizeof(in-&gt;sin_addr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            in-&gt;sin_port =3D nvlist_ge=
t_number(nvl, &quot;port&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_I=
NET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct socka=
ddr_in6 *in6 =3D (struct sockaddr_in6 *)ss;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            const void *data;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            size_t len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            in6-&gt;sin6_len =3D sizeof(*in6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            data =3D nvlist_g=
et_binary(nvl, &quot;address&quot;, &amp;len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            assert(len =3D=3D sizeof(in6-&gt;sin=
6_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  memcpy(&amp;in6-&gt;sin6_addr, data, sizeof(in6-&gt;sin6_addr));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            in6-&gt;sin6_por=
t =3D nvlist_get_number(nvl, &quot;port&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return (false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (true);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_new_pe=
er(dco_context_t *dco, unsigned int peerid, int sd,</span><br><span>       =
       struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><=
span>@@ -571,6 +626,25 @@</span><br><span>             dco-&gt;dco_message_=
type =3D OVPN_CMD_SWAP_KEYS;</span><br><span>             break;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 OVPN_NOTIF_FLOAT: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            const nvlist_t *address;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (!nvlist_exists_nvlist(nvl, &quot;address&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;Flo=
at notification without address&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          address =3D nvlist_get_nvlist(nvl, &quot;address&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!nvlist_to_s=
ockaddr(address, &amp;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;Failed to parse f=
loat notification&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            dco-&gt;dco_message_type =3D OVPN_CMD_FLOAT_PEER;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         default:</span>=
<br><span>             msg(M_WARN, &quot;Unknown kernel notification %d&quo=
t;, type);</span><br><span>             break;</span><br><span>diff --git a=
/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h</span><br><span>inde=
x e1a054e..ab5891e 100644</span><br><span>--- a/src/openvpn/dco_freebsd.h</=
span><br><span>+++ b/src/openvpn/dco_freebsd.h</span><br><span>@@ -36,6 +36=
,7 @@</span><br><span>     OVPN_CMD_DEL_PEER,</span><br><span>     OVPN_CMD=
_PACKET,</span><br><span>     OVPN_CMD_SWAP_KEYS,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_CMD_FLOAT_PEER,</span><br><span> };<=
/span><br><span> </span><br><span> enum ovpn_del_reason_t {</span><br><span=
>@@ -55,6 +56,7 @@</span><br><span>     int dco_message_type;</span><br><sp=
an>     int dco_message_peer_id;</span><br><span>     int dco_del_peer_reas=
on;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct socka=
ddr_storage dco_float_peer_ss;</span><br><span>     uint64_t dco_read_bytes=
;</span><br><span>     uint64_t dco_write_bytes;</span><br><span> } dco_con=
text_t;</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mult=
i.c</span><br><span>index eb5f932..310211c 100644</span><br><span>--- a/src=
/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>=
@@ -3313,7 +3313,7 @@</span><br><span>         {</span><br><span>          =
   process_incoming_del_peer(m, mi, dco);</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD)</span><br><sp=
an>         else if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</=
span><br><span>         {</span><br><span>             ASSERT(mi-&gt;contex=
t.c2.link_socket);</span><br><span>diff --git a/src/openvpn/ovpn_dco_freebs=
d.h b/src/openvpn/ovpn_dco_freebsd.h</span><br><span>index 53f94df..7eb643b=
 100644</span><br><span>--- a/src/openvpn/ovpn_dco_freebsd.h</span><br><spa=
n>+++ b/src/openvpn/ovpn_dco_freebsd.h</span><br><span>@@ -37,6 +37,7 @@</s=
pan><br><span> enum ovpn_notif_type {</span><br><span>     OVPN_NOTIF_DEL_P=
EER,</span><br><span>     OVPN_NOTIF_ROTATE_KEY,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_NOTIF_FLOAT,</span><br><span> };</spa=
n><br><span> </span><br><span> enum ovpn_del_reason {</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1170?usp=3Demail">change 1170</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53e6d1b31c4f673cb646716dce7=
74ef3210f36bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1170 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--MIb5MqP6jVU=--

