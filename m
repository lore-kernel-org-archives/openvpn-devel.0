From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 17:06:58 +0000
In-Reply-To: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
References: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3477763c1de74a8df9f956d6a62558160671b9b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S8vlKtP5qvI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd.c: add
 D_DCO_DEBUG messages for counters and notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S8vlKtP5qvI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
49?usp=3Demail )

Change subject: dco_freebsd.c: add D_DCO_DEBUG messages for counters and no=
tifications
......................................................................

dco_freebsd.c: add D_DCO_DEBUG messages for counters and notifications

Some of these debug messages only existed on Linux, and made debugging
DCO issues on FreeBSD more difficult.  Add them, using the same style as
used for dco_linux.c

While at it, change all format strings for "peerid" to "%u" (wherever
appropriate, dco->dco_message_peer_id is an "int" today and changing
this to uint32_t is out of scope for "make better logging")

Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1349
Message-Id: <20251107165038.26171-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
250.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 21 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3521fca..f80b6df 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -147,7 +147,7 @@

     nvl =3D nvlist_create(0);

-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d", __func__, peerid, sd);

     if (localaddr)
     {
@@ -363,7 +363,7 @@
     nvlist_t *nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);

     nvl =3D nvlist_create(0);
     nvlist_add_number(nvl, "peerid", peerid);
@@ -392,7 +392,7 @@
     nvlist_t *nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);

     nvl =3D nvlist_create(0);
     nvlist_add_number(nvl, "peerid", peerid);
@@ -421,7 +421,7 @@
     nvlist_t *nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func__, peerid, slot);

     nvl =3D nvlist_create(0);
     nvlist_add_number(nvl, "slot", slot);
@@ -493,7 +493,7 @@
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch=
 %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch=
 %d", __func__, slot, keyid, peerid,
         ciphername, epoch);

     nvl =3D nvlist_create(0);
@@ -539,7 +539,7 @@
     nvlist_t *nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: peer-id %d, ping interval %d, ping timeout %d", =
__func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, ping interval %d, ping timeout %d", =
__func__, peerid,
         keepalive_interval, keepalive_timeout);

     nvl =3D nvlist_create(0);
@@ -569,7 +569,7 @@
 {
     if (peerid >=3D m->max_clients || !m->instances[peerid])
     {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by =
kernel", peerid);
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %u returned by =
kernel", peerid);
         return;
     }

@@ -577,6 +577,9 @@

     mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
     mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
+
+    msg(D_DCO_DEBUG, "%s: peer-id %u, dco_read_bytes: " counter_format " d=
co_write_bytes: " counter_format,
+        __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dc=
o_write_bytes);
 }

 int
@@ -614,6 +617,7 @@
     dco->dco_message_peer_id =3D nvlist_get_number(nvl, "peerid");

     type =3D nvlist_get_number(nvl, "notification");
+
     switch (type)
     {
         case OVPN_NOTIF_DEL_PEER:
@@ -631,6 +635,8 @@
                     dco->dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_USER=
SPACE;
                 }
             }
+            msg(D_DCO_DEBUG, "%s: received NOTIF_DEL_PEER for peer-id=3D%d=
, reason=3D%d", __func__,
+                dco->dco_message_peer_id, dco->dco_del_peer_reason);

             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
@@ -651,6 +657,8 @@
             break;

         case OVPN_NOTIF_ROTATE_KEY:
+            msg(D_DCO_DEBUG, "%s: received NOTIF_ROTATE_KEY for peer-id=3D=
%d", __func__,
+                dco->dco_message_peer_id);
             dco->dco_message_type =3D OVPN_CMD_SWAP_KEYS;
             break;

@@ -670,12 +678,14 @@
                 msg(M_WARN, "Failed to parse float notification");
                 break;
             }
+            msg(D_DCO_DEBUG, "%s: received NOTIF_FLOAT for peer-id=3D%d", =
__func__,
+                dco->dco_message_peer_id);
             dco->dco_message_type =3D OVPN_CMD_FLOAT_PEER;
             break;
         }

         default:
-            msg(M_WARN, "Unknown kernel notification %d", type);
+            msg(M_WARN, "%s: unknown kernel notification %d", __func__, ty=
pe);
             break;
     }

@@ -815,6 +825,8 @@
         return 0;
     }

+    msg(D_DCO_DEBUG, __func__);
+
     CLEAR(drv);
     snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
     drv.ifd_cmd =3D OVPN_GET_PEER_STATS;
@@ -873,6 +885,7 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
+    msg(D_DCO_DEBUG, __func__);
     /* Not implemented. */
     return 0;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Gerrit-Change-Number: 1349
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S8vlKtP5qvI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1349?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco_freebsd.c: add D_DCO_DEBUG messages for coun=
ters and notifications<br><br>Some of these debug messages only existed on =
Linux, and made debugging<br>DCO issues on FreeBSD more difficult.  Add the=
m, using the same style as<br>used for dco_linux.c<br><br>While at it, chan=
ge all format strings for &quot;peerid&quot; to &quot;%u&quot; (wherever<br=
>appropriate, dco-&gt;dco_message_peer_id is an &quot;int&quot; today and c=
hanging<br>this to uint32_t is out of scope for &quot;make better logging&q=
uot;)<br><br>Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1349<br>Message-Id: &lt;20251107165038.26171-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
4250.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/dco_freebsd.c<br>1 file changed, 21 insertions(+), 8 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index 3521fca..f80b6df 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -147,7 +147,7 @@</span><br><span> </span><br><span>     nvl =3D nvlis=
t_create(0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&quot;, __func__, =
peerid, sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d&quot;, __func__, peerid, sd);</sp=
an><br><span> </span><br><span>     if (localaddr)</span><br><span>     {</=
span><br><span>@@ -363,7 +363,7 @@</span><br><span>     nvlist_t *nvl;</spa=
n><br><span>     int ret;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __fu=
nc__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><s=
pan> </span><br><span>     nvl =3D nvlist_create(0);</span><br><span>     n=
vlist_add_number(nvl, &quot;peerid&quot;, peerid);</span><br><span>@@ -392,=
7 +392,7 @@</span><br><span>     nvlist_t *nvl;</span><br><span>     int re=
t;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: peer-id %u&quot;, __func__, peerid);</span><br><span> </span><br><span> =
    nvl =3D nvlist_create(0);</span><br><span>     nvlist_add_number(nvl, &=
quot;peerid&quot;, peerid);</span><br><span>@@ -421,7 +421,7 @@</span><br><=
span>     nvlist_t *nvl;</span><br><span>     int ret;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &qu=
ot;%s: peer-id %d, slot %d&quot;, __func__, peerid, slot);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-=
id %u, slot %d&quot;, __func__, peerid, slot);</span><br><span> </span><br>=
<span>     nvl =3D nvlist_create(0);</span><br><span>     nvlist_add_number=
(nvl, &quot;slot&quot;, slot);</span><br><span>@@ -493,7 +493,7 @@</span><b=
r><span>     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;</span><br><span>   =
  int ret;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, ciphe=
r %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, k=
ey-id %d, peer-id %u, cipher %s, epoch %d&quot;, __func__, slot, keyid, pee=
rid,</span><br><span>         ciphername, epoch);</span><br><span> </span><=
br><span>     nvl =3D nvlist_create(0);</span><br><span>@@ -539,7 +539,7 @@=
</span><br><span>     nvlist_t *nvl;</span><br><span>     int ret;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DC=
O_DEBUG, &quot;%s: peer-id %d, ping interval %d, ping timeout %d&quot;, __f=
unc__, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %u, ping interval %d, ping timeout %d&quo=
t;, __func__, peerid,</span><br><span>         keepalive_interval, keepaliv=
e_timeout);</span><br><span> </span><br><span>     nvl =3D nvlist_create(0)=
;</span><br><span>@@ -569,7 +569,7 @@</span><br><span> {</span><br><span>  =
   if (peerid &gt;=3D m-&gt;max_clients || !m-&gt;instances[peerid])</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %d returned by k=
ernel&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %u return=
ed by kernel&quot;, peerid);</span><br><span>         return;</span><br><sp=
an>     }</span><br><span> </span><br><span>@@ -577,6 +577,9 @@</span><br><=
span> </span><br><span>     mi-&gt;context.c2.dco_read_bytes =3D nvlist_get=
_number(nvl, &quot;in&quot;);</span><br><span>     mi-&gt;context.c2.dco_wr=
ite_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, dco_read_bytes: =
&quot; counter_format &quot; dco_write_bytes: &quot; counter_format,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, peerid, =
mi-&gt;context.c2.dco_read_bytes, mi-&gt;context.c2.dco_write_bytes);</span=
><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@ -61=
4,6 +617,7 @@</span><br><span>     dco-&gt;dco_message_peer_id =3D nvlist_g=
et_number(nvl, &quot;peerid&quot;);</span><br><span> </span><br><span>     =
type =3D nvlist_get_number(nvl, &quot;notification&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     switch (type)<=
/span><br><span>     {</span><br><span>         case OVPN_NOTIF_DEL_PEER:</=
span><br><span>@@ -631,6 +635,8 @@</span><br><span>                     dco=
-&gt;dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_USERSPACE;</span><br><spa=
n>                 }</span><br><span>             }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s: re=
ceived NOTIF_DEL_PEER for peer-id=3D%d, reason=3D%d&quot;, __func__,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;dc=
o_message_peer_id, dco-&gt;dco_del_peer_reason);</span><br><span> </span><b=
r><span>             if (nvlist_exists_nvlist(nvl, &quot;bytes&quot;))</spa=
n><br><span>             {</span><br><span>@@ -651,6 +657,8 @@</span><br><s=
pan>             break;</span><br><span> </span><br><span>         case OVP=
N_NOTIF_ROTATE_KEY:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(D_DCO_DEBUG, &quot;%s: received NOTIF_ROTATE_KEY for peer-i=
d=3D%d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                dco-&gt;dco_message_peer_id);</span><br><span>         =
    dco-&gt;dco_message_type =3D OVPN_CMD_SWAP_KEYS;</span><br><span>      =
       break;</span><br><span> </span><br><span>@@ -670,12 +678,14 @@</span=
><br><span>                 msg(M_WARN, &quot;Failed to parse float notific=
ation&quot;);</span><br><span>                 break;</span><br><span>     =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(D_DCO_DEBUG, &quot;%s: received NOTIF_FLOAT for peer-id=3D%d&quot;, _=
_func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     dco-&gt;dco_message_peer_id);</span><br><span>             dco-&gt;dco=
_message_type =3D OVPN_CMD_FLOAT_PEER;</span><br><span>             break;<=
/span><br><span>         }</span><br><span> </span><br><span>         defau=
lt:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_=
WARN, &quot;Unknown kernel notification %d&quot;, type);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: unkn=
own kernel notification %d&quot;, __func__, type);</span><br><span>        =
     break;</span><br><span>     }</span><br><span> </span><br><span>@@ -81=
5,6 +825,8 @@</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     CLEAR(drv);</span><br><span>     snprintf(drv.=
ifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</span><br><span>     d=
rv.ifd_cmd =3D OVPN_GET_PEER_STATS;</span><br><span>@@ -873,6 +885,7 @@</sp=
an><br><span> int</span><br><span> dco_get_peer_stats(struct context *c, co=
nst bool raise_sigusr1_on_err)</span><br><span> {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, __func__);</span><br><sp=
an>     /* Not implemented. */</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail">change 1349</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1349?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9=
bd0642f6a6e83 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1349 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--S8vlKtP5qvI=--

