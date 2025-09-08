From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Sep 2025 10:17:23 +0000
In-Reply-To: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
References: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., ralf@...2726...
Message-ID: <4fa01483a4e636fb10c2399f25f8c0a39b1de900-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H1gSilw/P1E="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, ralf_lici <ralf@...2726...>, mandree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H1gSilw/P1E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, mandree, plaisthos, ralf_lici,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by ralf_lici, Code-Review-1 by mandree


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1170/2

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
Gerrit-MessageType: newpatchset

--H1gSilw/P1E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ralf_lici, Code-Review-1 by mandree</p><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">dco: support float not=
ifications on FreeBSD<br><br>this is a backport of commit b66b80b2ab and 79=
6ad2c559<br>(squashed, as the second commit undoes quite a bit of #ifdef fr=
om the first)<br><br>See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=
=3D289303 for all<br>the epic details...<br><br>Change-Id: I53e6d1b31c4f673=
cb646716dce774ef3210f36bd<br>Signed-off-by: Kristof Provost &lt;kprovost@...1186...=
.2661...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acke=
d-by: Ralf Lici &lt;ralf@...2726...&gt;<br>(cherry picked from commit b66b8=
0b2ab73bb422826911b675798e6b789ef03)<br>(cherry picked from commit 796ad2c5=
5951635382e48ea5b71d13bbb83ebfb1)<br>Message-Id: &lt;20250908083354.19811-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg32827.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_fre=
ebsd.h<br>M src/openvpn/multi.c<br>M src/openvpn/ovpn_dco_freebsd.h<br>4 fi=
les changed, 78 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/70/1170/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index ed=
7ea92..25532d4 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span=
><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -72,6 +72,61 =
@@</span><br><span>     return (nvl);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+nvlist_to_sockaddr(const nvl=
ist_t *nvl, struct sockaddr_storage *ss)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!nvlist_exists_number(nvl, &quot;af&quot;))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return (false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!nvlist_exists_binary(nvl, &quot;address&quot;))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return (false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!nvlist_exists_number(nvl, &quot;port&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return (false);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ss-&gt;ss_family =3D nvlist_get_number(nvl, &quot;af&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    switch (ss-&gt;ss_family)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            struct sockaddr_in *in =3D (struct=
 sockaddr_in *)ss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           const void *data;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            size_t len;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      in-&gt;sin_len =3D sizeof(*in);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            data =3D nvlist_get_binary(nvl, &quot;address=
&quot;, &amp;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           assert(len =3D=3D sizeof(in-&gt;sin_addr));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;in-&gt;sin_addr,=
 data, sizeof(in-&gt;sin_addr));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            in-&gt;sin_port =3D nvlist_get_number(nvl, &quot;p=
ort&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            struct sockaddr_in6 *in6 =3D (str=
uct sockaddr_in6 *)ss;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            const void *data;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            size_t len;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          in6-&gt;sin6_len =3D sizeof(*in6);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            data =3D nvlist_get_binary(nvl, &quot;=
address&quot;, &amp;len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            assert(len =3D=3D sizeof(in6-&gt;sin6_addr));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;in6-&gt=
;sin6_addr, data, sizeof(in6-&gt;sin6_addr));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            in6-&gt;sin6_port =3D nvlist_get_numb=
er(nvl, &quot;port&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return (false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco=
, unsigned int peerid, int sd,</span><br><span>              struct sockadd=
r *localaddr, struct sockaddr *remoteaddr,</span><br><span>@@ -571,6 +626,2=
5 @@</span><br><span>             dco-&gt;dco_message_type =3D OVPN_CMD_SWA=
P_KEYS;</span><br><span>             break;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case OVPN_NOTIF_FLOAT: {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const nv=
list_t *address;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!nvlis=
t_exists_nvlist(nvl, &quot;address&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                msg(M_WARN, &quot;Float notification witho=
ut address&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            address =3D=
 nvlist_get_nvlist(nvl, &quot;address&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (!nvlist_to_sockaddr(address, &amp=
;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(M_WARN, &quot;Failed to parse float notification&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco-&g=
t;dco_message_type =3D OVPN_CMD_FLOAT_PEER;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         default:</span><br><span>           =
  msg(M_WARN, &quot;Unknown kernel notification %d&quot;, type);</span><br>=
<span>             break;</span><br><span>diff --git a/src/openvpn/dco_free=
bsd.h b/src/openvpn/dco_freebsd.h</span><br><span>index e1a054e..ab5891e 10=
0644</span><br><span>--- a/src/openvpn/dco_freebsd.h</span><br><span>+++ b/=
src/openvpn/dco_freebsd.h</span><br><span>@@ -36,6 +36,7 @@</span><br><span=
>     OVPN_CMD_DEL_PEER,</span><br><span>     OVPN_CMD_PACKET,</span><br><s=
pan>     OVPN_CMD_SWAP_KEYS,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    OVPN_CMD_FLOAT_PEER,</span><br><span> };</span><br><span> </sp=
an><br><span> enum ovpn_del_reason_t {</span><br><span>@@ -55,6 +56,7 @@</s=
pan><br><span>     int dco_message_type;</span><br><span>     int dco_messa=
ge_peer_id;</span><br><span>     int dco_del_peer_reason;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage dco_float=
_peer_ss;</span><br><span>     uint64_t dco_read_bytes;</span><br><span>   =
  uint64_t dco_write_bytes;</span><br><span> } dco_context_t;</span><br><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex eb5f932..310211c 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3313,7 +3313,7 @@=
</span><br><span>         {</span><br><span>             process_incoming_d=
el_peer(m, mi, dco);</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_FREEBSD)</span><br><span>         else if (d=
co-&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><span>       =
  {</span><br><span>             ASSERT(mi-&gt;context.c2.link_socket);</sp=
an><br><span>diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn=
_dco_freebsd.h</span><br><span>index 53f94df..7eb643b 100644</span><br><spa=
n>--- a/src/openvpn/ovpn_dco_freebsd.h</span><br><span>+++ b/src/openvpn/ov=
pn_dco_freebsd.h</span><br><span>@@ -37,6 +37,7 @@</span><br><span> enum ov=
pn_notif_type {</span><br><span>     OVPN_NOTIF_DEL_PEER,</span><br><span> =
    OVPN_NOTIF_ROTATE_KEY,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_NOTIF_FLOAT,</span><br><span> };</span><br><span> </span><b=
r><span> enum ovpn_del_reason {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail">=
change 1170</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--H1gSilw/P1E=--

