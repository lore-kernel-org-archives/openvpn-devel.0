From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 08:18:42 +0000
In-Reply-To: <gerrit.1753215725000.Ifc442b4426c02de7282d0f69629e8a10b679c589@...2715...>
References: <gerrit.1753215725000.Ifc442b4426c02de7282d0f69629e8a10b679c589@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <405b2fe22f7edffc080fc5ed35d5b0ba197f5271-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i5FYQPG4bg4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: use
 M_FATAL instead of M_ERR in netlink error code paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i5FYQPG4bg4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
96?usp=3Demail )

Change subject: dco_linux: use M_FATAL instead of M_ERR in netlink error co=
de paths
......................................................................

dco_linux: use M_FATAL instead of M_ERR in netlink error code paths

Netlink code doesn't set errno upon error (with the exception of
any *alloc() function which probably inherits the errno=3DENOMEM
from the underlying malloc call), therefore we should not print
error messages with M_ERR, but rather rely on M_FATAL.

M_ERR is equivalent to M_FATAL with the addition of appending
": $errno" to the error string.

Since errno is not meaningful in this context, we can just opt
for the less confusing M_FATAL.

Change-Id: Ifc442b4426c02de7282d0f69629e8a10b679c589
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723063039.25449-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
271.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 9 insertions(+), 9 deletions(-)




diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0a73882..a04a164 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -114,7 +114,7 @@
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
     {
-        msg(M_ERR, "cannot allocate netlink message");
+        msg(M_FATAL, "cannot allocate netlink message");
         return NULL;
     }

@@ -140,7 +140,7 @@
             break;

         case -NLE_NOMEM:
-            msg(M_ERR, "%s: netlink out of memory error", prefix);
+            msg(M_FATAL, "%s: netlink out of memory error", prefix);
             break;

         case -NLE_AGAIN:
@@ -148,7 +148,7 @@
             break;

         case -NLE_NODEV:
-            msg(M_ERR, "%s: netlink reports device not found:", prefix);
+            msg(M_FATAL, "%s: netlink reports device not found:", prefix);
             break;

         case -NLE_OBJ_NOTFOUND:
@@ -387,19 +387,19 @@
 static void
 ovpn_dco_init_netlink(dco_context_t *dco)
 {
-    dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR);
+    dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);

     dco->nl_sock =3D nl_socket_alloc();

     if (!dco->nl_sock)
     {
-        msg(M_ERR, "Cannot create netlink socket");
+        msg(M_FATAL, "Cannot create netlink socket");
     }

     int ret =3D genl_connect(dco->nl_sock);
     if (ret)
     {
-        msg(M_ERR, "Cannot connect to generic netlink: %s",
+        msg(M_FATAL, "Cannot connect to generic netlink: %s",
             nl_geterror(ret));
     }

@@ -415,7 +415,7 @@
     dco->nl_cb =3D nl_cb_alloc(NL_CB_DEFAULT);
     if (!dco->nl_cb)
     {
-        msg(M_ERR, "failed to allocate netlink callback");
+        msg(M_FATAL, "failed to allocate netlink callback");
     }

     nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
@@ -478,7 +478,7 @@

     if (dco->ovpn_dco_mcast_id < 0)
     {
-        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dc=
o_mcast_id));
+        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_=
dco_mcast_id));
     }

     /* Register for ovpn-dco specific multicast messages that the kernel m=
ay
@@ -487,7 +487,7 @@
     int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast=
_id);
     if (ret)
     {
-        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
+        msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1096?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc442b4426c02de7282d0f69629e8a10b679c589
Gerrit-Change-Number: 1096
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--i5FYQPG4bg4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1096?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: use M_FATAL instead of M_ERR in ne=
tlink error code paths<br><br>Netlink code doesn&#39;t set errno upon error=
 (with the exception of<br>any *alloc() function which probably inherits th=
e errno=3DENOMEM<br>from the underlying malloc call), therefore we should n=
ot print<br>error messages with M_ERR, but rather rely on M_FATAL.<br><br>M=
_ERR is equivalent to M_FATAL with the addition of appending<br>&quot;: $er=
rno&quot; to the error string.<br><br>Since errno is not meaningful in this=
 context, we can just opt<br>for the less confusing M_FATAL.<br><br>Change-=
Id: Ifc442b4426c02de7282d0f69629e8a10b679c589<br>Signed-off-by: Antonio Qua=
rtulli &lt;antonio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>Message-Id: &lt;20250723063039.25449-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg322=
71.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/dco_linux.c<br>1 file changed, 9 insertions(+), 9 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index 0a73882..a04a164 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1=
14,7 +114,7 @@</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc()=
;</span><br><span>     if (!nl_msg)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;cannot alloca=
te netlink message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_FATAL, &quot;cannot allocate netlink message&quot;);</=
span><br><span>         return NULL;</span><br><span>     }</span><br><span=
> </span><br><span>@@ -140,7 +140,7 @@</span><br><span>             break;<=
/span><br><span> </span><br><span>         case -NLE_NOMEM:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot;%s: netl=
ink out of memory error&quot;, prefix);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: netlink out of memor=
y error&quot;, prefix);</span><br><span>             break;</span><br><span=
> </span><br><span>         case -NLE_AGAIN:</span><br><span>@@ -148,7 +148=
,7 @@</span><br><span>             break;</span><br><span> </span><br><span=
>         case -NLE_NODEV:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(M_ERR, &quot;%s: netlink reports device not found:&quo=
t;, prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_FATAL, &quot;%s: netlink reports device not found:&quot;, prefix=
);</span><br><span>             break;</span><br><span> </span><br><span>  =
       case -NLE_OBJ_NOTFOUND:</span><br><span>@@ -387,19 +387,19 @@</span>=
<br><span> static void</span><br><span> ovpn_dco_init_netlink(dco_context_t=
 *dco)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;ovpn_dco_id =3D res=
olve_ovpn_netlink_id(M_FATAL);</span><br><span> </span><br><span>     dco-&=
gt;nl_sock =3D nl_socket_alloc();</span><br><span> </span><br><span>     if=
 (!dco-&gt;nl_sock)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;Cannot create netlink socket&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_FATAL, &quot;Cannot create netlink socket&quot;);</span><br><span>     }<=
/span><br><span> </span><br><span>     int ret =3D genl_connect(dco-&gt;nl_=
sock);</span><br><span>     if (ret)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;Cannot conne=
ct to generic netlink: %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_FATAL, &quot;Cannot connect to generic netlink: =
%s&quot;,</span><br><span>             nl_geterror(ret));</span><br><span> =
    }</span><br><span> </span><br><span>@@ -415,7 +415,7 @@</span><br><span=
>     dco-&gt;nl_cb =3D nl_cb_alloc(NL_CB_DEFAULT);</span><br><span>     if=
 (!dco-&gt;nl_cb)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_ERR, &quot;failed to allocate netlink call=
back&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_FATAL, &quot;failed to allocate netlink callback&quot;);</span><br><=
span>     }</span><br><span> </span><br><span>     nl_socket_set_cb(dco-&gt=
;nl_sock, dco-&gt;nl_cb);</span><br><span>@@ -478,7 +478,7 @@</span><br><sp=
an> </span><br><span>     if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
g(M_ERR, &quot;cannot get mcast group: %s&quot;,  nl_geterror(dco-&gt;ovpn_=
dco_mcast_id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_FATAL, &quot;cannot get mcast group: %s&quot;,  nl_geterror(dco-&=
gt;ovpn_dco_mcast_id));</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Register for ovpn-dco specific multicast messages that the ke=
rnel may</span><br><span>@@ -487,7 +487,7 @@</span><br><span>     int ret =
=3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</=
span><br><span>     if (ret)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;%s: failed to join=
 groups: %d&quot;, __func__, ret);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_FATAL, &quot;%s: failed to join groups: %d&quo=
t;, __func__, ret);</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1096?usp=3Demail">change 1096</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1096?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc442b4426c02de7282d0f69629=
e8a10b679c589 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1096 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--i5FYQPG4bg4=--

