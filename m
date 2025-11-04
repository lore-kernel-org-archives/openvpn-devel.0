From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 21:44:18 +0000
References: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bba4a14b414373e7a465562861b3adfa7ce14c5c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GznoqebD5sE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GznoqebD5sE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail

to review the following change.


Change subject: dco_freebsd.c: add D_DCO_DEBUG messages for counters and no=
tifications
......................................................................

dco_freebsd.c: add D_DCO_DEBUG messages for counters and notifications

Some of these debug messages only existed on Linux, and made debugging
DCO issues on FreeBSD more difficult.  Add them, using the same style as
used for dco_linux.c

Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 14 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1349/1

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3521fca..e4cb71a 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -577,6 +577,9 @@

     mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
     mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d, dco_read_bytes: " counter_format " d=
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Gerrit-Change-Number: 1349
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--GznoqebD5sE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_freebsd.c: add D_DCO_DEBUG messages for=
 counters and notifications<br><br>Some of these debug messages only existe=
d on Linux, and made debugging<br>DCO issues on FreeBSD more difficult.  Ad=
d them, using the same style as<br>used for dco_linux.c<br><br>Change-Id: I=
fe55cb78401dad921b75f6c86d9bd0642f6a6e83<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file change=
d, 14 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/49/1349/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span=
>index 3521fca..e4cb71a 100644</span><br><span>--- a/src/openvpn/dco_freebs=
d.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -577=
,6 +577,9 @@</span><br><span> </span><br><span>     mi-&gt;context.c2.dco_r=
ead_bytes =3D nvlist_get_number(nvl, &quot;in&quot;);</span><br><span>     =
mi-&gt;context.c2.dco_write_bytes =3D nvlist_get_number(nvl, &quot;out&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer=
-id %d, dco_read_bytes: &quot; counter_format &quot; dco_write_bytes: &quot=
; counter_format,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      __func__, peerid, mi-&gt;context.c2.dco_read_bytes, mi-&gt;context.c2=
.dco_write_bytes);</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span>@@ -614,6 +617,7 @@</span><br><span>     dco-&gt;dco_mess=
age_peer_id =3D nvlist_get_number(nvl, &quot;peerid&quot;);</span><br><span=
> </span><br><span>     type =3D nvlist_get_number(nvl, &quot;notification&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     switch (type)</span><br><span>     {</span><br><span>         cas=
e OVPN_NOTIF_DEL_PEER:</span><br><span>@@ -631,6 +635,8 @@</span><br><span>=
                     dco-&gt;dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_U=
SERSPACE;</span><br><span>                 }</span><br><span>             }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_D=
CO_DEBUG, &quot;%s: received NOTIF_DEL_PEER for peer-id=3D%d, reason=3D%d&q=
uot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            dco-&gt;dco_message_peer_id, dco-&gt;dco_del_peer_reason);</spa=
n><br><span> </span><br><span>             if (nvlist_exists_nvlist(nvl, &q=
uot;bytes&quot;))</span><br><span>             {</span><br><span>@@ -651,6 =
+657,8 @@</span><br><span>             break;</span><br><span> </span><br><=
span>         case OVPN_NOTIF_ROTATE_KEY:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s: received NOTIF=
_ROTATE_KEY for peer-id=3D%d&quot;, __func__,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                dco-&gt;dco_message_peer_id);</sp=
an><br><span>             dco-&gt;dco_message_type =3D OVPN_CMD_SWAP_KEYS;<=
/span><br><span>             break;</span><br><span> </span><br><span>@@ -6=
70,12 +678,14 @@</span><br><span>                 msg(M_WARN, &quot;Failed =
to parse float notification&quot;);</span><br><span>                 break;=
</span><br><span>             }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s: received NOTIF_FLOAT for=
 peer-id=3D%d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                dco-&gt;dco_message_peer_id);</span><br><span>  =
           dco-&gt;dco_message_type =3D OVPN_CMD_FLOAT_PEER;</span><br><spa=
n>             break;</span><br><span>         }</span><br><span> </span><b=
r><span>         default:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msg(M_WARN, &quot;Unknown kernel notification %d&quot;, typ=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
M_WARN, &quot;%s: unknown kernel notification %d&quot;, __func__, type);</s=
pan><br><span>             break;</span><br><span>     }</span><br><span> <=
/span><br><span>@@ -815,6 +825,8 @@</span><br><span>         return 0;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     CLEAR(drv);</span><br><s=
pan>     snprintf(drv.ifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);<=
/span><br><span>     drv.ifd_cmd =3D OVPN_GET_PEER_STATS;</span><br><span>@=
@ -873,6 +885,7 @@</span><br><span> int</span><br><span> dco_get_peer_stats=
(struct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, __=
func__);</span><br><span>     /* Not implemented. */</span><br><span>     r=
eturn 0;</span><br><span> }</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail">chan=
ge 1349</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9=
bd0642f6a6e83 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1349 </div>
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

</body></html>=

--GznoqebD5sE=--

