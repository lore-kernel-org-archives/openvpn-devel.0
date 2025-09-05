From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 5 Sep 2025 17:55:30 +0000
References: <gerrit.1757094927000.I53e6d1b31c4f673cb646716dce774ef3210f36bd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db632607073db9fda926282bd1ee4b77e4f6842c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pemylp0uGTI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Pemylp0uGTI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail

to review the following change.


Change subject: dco: support float notifications on FreeBSD
......................................................................

dco: support float notifications on FreeBSD

this is a backport of commit b66b80b2ab and 796ad2c559
(squashed, as the second commit undoes quite a bit of #ifdef from the first)

Change-Id: I53e6d1b31c4f673cb646716dce774ef3210f36bd
Signed-off-by: Kristof Provost <kprovost@...2661...>
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit b66b80b2ab73bb422826911b675798e6b789ef03)
(cherry picked from commit 796ad2c55951635382e48ea5b71d13bbb83ebfb1)
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/multi.c
M src/openvpn/ovpn_dco_freebsd.h
4 files changed, 78 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1170/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Pemylp0uGTI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco: support float notifications on FreeBSD<br><br>this is a=
 backport of commit b66b80b2ab and 796ad2c559<br>(squashed, as the second c=
ommit undoes quite a bit of #ifdef from the first)<br><br>Change-Id: I53e6d=
1b31c4f673cb646716dce774ef3210f36bd<br>Signed-off-by: Kristof Provost &lt;k=
provost@...2661...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>(cherry picked from commit b66b80b2ab73bb422826911b675798e6b789ef03)<=
br>(cherry picked from commit 796ad2c55951635382e48ea5b71d13bbb83ebfb1)<br>=
---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>M src/=
openvpn/multi.c<br>M src/openvpn/ovpn_dco_freebsd.h<br>4 files changed, 78 =
insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/70/1170/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_fre=
ebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index ed7ea92..25532d4 1=
00644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b=
/src/openvpn/dco_freebsd.c</span><br><span>@@ -72,6 +72,61 @@</span><br><sp=
an>     return (nvl);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+nvlist_to_sockaddr(const nvlist_t *nvl, stru=
ct sockaddr_storage *ss)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nvli=
st_exists_number(nvl, &quot;af&quot;))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return (false);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!nvlist_exists_binary(nvl, &quot;address&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return (false);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!nvlist_exists_number(nvl, &quot;port&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return (false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ss-&gt;ss_family =3D nvlist_get_number(nvl, &quot;af&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    switch (ss-&gt;ss_family)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            struct sockaddr_in *in =3D (struct sockaddr_in *=
)ss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st void *data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       size_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in-&gt;s=
in_len =3D sizeof(*in);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            data =3D nvlist_get_binary(nvl, &quot;address&quot;, &amp;l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ass=
ert(len =3D=3D sizeof(in-&gt;sin_addr));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            memcpy(&amp;in-&gt;sin_addr, data, sizeof(=
in-&gt;sin_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           in-&gt;sin_port =3D nvlist_get_number(nvl, &quot;port&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            struct sockaddr_in6 *in6 =3D (struct sockaddr_i=
n6 *)ss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const void *data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           size_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in6-=
&gt;sin6_len =3D sizeof(*in6);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            data =3D nvlist_get_binary(nvl, &quot;address&quot;,=
 &amp;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    assert(len =3D=3D sizeof(in6-&gt;sin6_addr));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            memcpy(&amp;in6-&gt;sin6_addr, da=
ta, sizeof(in6-&gt;sin6_addr));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            in6-&gt;sin6_port =3D nvlist_get_number(nvl, &quot;=
port&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return (false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return (true);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int=
 peerid, int sd,</span><br><span>              struct sockaddr *localaddr, =
struct sockaddr *remoteaddr,</span><br><span>@@ -571,6 +626,25 @@</span><br=
><span>             dco-&gt;dco_message_type =3D OVPN_CMD_SWAP_KEYS;</span>=
<br><span>             break;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case OVPN_NOTIF_FLOAT: {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const nvlist_t *addres=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (!nvlist_exists_nvlis=
t(nvl, &quot;address&quot;))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(M_WARN, &quot;Float notification without address&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            address =3D nvlist_get_nv=
list(nvl, &quot;address&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!nvlist_to_sockaddr(address, &amp;dco-&gt;dco_f=
loat_peer_ss))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     msg(M_WARN, &quot;Failed to parse float notification&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message_=
type =3D OVPN_CMD_FLOAT_PEER;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         default:</span><br><span>             msg(M_WARN, =
&quot;Unknown kernel notification %d&quot;, type);</span><br><span>        =
     break;</span><br><span>diff --git a/src/openvpn/dco_freebsd.h b/src/op=
envpn/dco_freebsd.h</span><br><span>index e1a054e..ab5891e 100644</span><br=
><span>--- a/src/openvpn/dco_freebsd.h</span><br><span>+++ b/src/openvpn/dc=
o_freebsd.h</span><br><span>@@ -36,6 +36,7 @@</span><br><span>     OVPN_CMD=
_DEL_PEER,</span><br><span>     OVPN_CMD_PACKET,</span><br><span>     OVPN_=
CMD_SWAP_KEYS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_CMD_FLOAT_PEER,</span><br><span> };</span><br><span> </span><br><span> =
enum ovpn_del_reason_t {</span><br><span>@@ -55,6 +56,7 @@</span><br><span>=
     int dco_message_type;</span><br><span>     int dco_message_peer_id;</s=
pan><br><span>     int dco_del_peer_reason;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct sockaddr_storage dco_float_peer_ss;</spa=
n><br><span>     uint64_t dco_read_bytes;</span><br><span>     uint64_t dco=
_write_bytes;</span><br><span> } dco_context_t;</span><br><span>diff --git =
a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index eb5f932..=
310211c 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>++=
+ b/src/openvpn/multi.c</span><br><span>@@ -3313,7 +3313,7 @@</span><br><sp=
an>         {</span><br><span>             process_incoming_del_peer(m, mi,=
 dco);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(TARGET_FREEBSD)</span><br><span>         else if (dco-&gt;dco_mes=
sage_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><span>         {</span><br>=
<span>             ASSERT(mi-&gt;context.c2.link_socket);</span><br><span>d=
iff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h=
</span><br><span>index 53f94df..7eb643b 100644</span><br><span>--- a/src/op=
envpn/ovpn_dco_freebsd.h</span><br><span>+++ b/src/openvpn/ovpn_dco_freebsd=
.h</span><br><span>@@ -37,6 +37,7 @@</span><br><span> enum ovpn_notif_type =
{</span><br><span>     OVPN_NOTIF_DEL_PEER,</span><br><span>     OVPN_NOTIF=
_ROTATE_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_NOTIF_FLOAT,</span><br><span> };</span><br><span> </span><br><span> enum =
ovpn_del_reason {</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1170?usp=3Demail">change 1170</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1170?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53e6d1b31c4f673cb646716dce7=
74ef3210f36bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1170 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Pemylp0uGTI=--

