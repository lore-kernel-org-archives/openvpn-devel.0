From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:22:19 +0000
References: <gerrit.1753215725000.Ifc442b4426c02de7282d0f69629e8a10b679c589@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b201490c9c0006b5c2d752c054f11359d585ef4d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/HxEsRtsR78="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/HxEsRtsR78=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1096?usp=3Demail

to review the following change.


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
---
M src/openvpn/dco_linux.c
1 file changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1096/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 58051f5..13506a1 100644
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
@@ -484,7 +484,7 @@

     if (dco->ovpn_dco_mcast_id < 0)
     {
-        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dc=
o_mcast_id));
+        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_=
dco_mcast_id));
     }

     /* Register for ovpn-dco specific multicast messages that the kernel m=
ay
@@ -493,7 +493,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/HxEsRtsR78=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1096?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: use M_FATAL instead of M_ERR in netlink error cod=
e paths<br><br>Netlink code doesn&#39;t set errno upon error (with the exce=
ption of<br>any *alloc() function which probably inherits the errno=3DENOME=
M<br>from the underlying malloc call), therefore we should not print<br>err=
or messages with M_ERR, but rather rely on M_FATAL.<br><br>M_ERR is equival=
ent to M_FATAL with the addition of appending<br>&quot;: $errno&quot; to th=
e error string.<br><br>Since errno is not meaningful in this context, we ca=
n just opt<br>for the less confusing M_FATAL.<br><br>Change-Id: Ifc442b4426=
c02de7282d0f69629e8a10b679c589<br>Signed-off-by: Antonio Quartulli &lt;anto=
nio@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, 9=
 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/96/1096/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_l=
inux.c b/src/openvpn/dco_linux.c</span><br><span>index 58051f5..13506a1 100=
644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src=
/openvpn/dco_linux.c</span><br><span>@@ -114,7 +114,7 @@</span><br><span>  =
   struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!nl_ms=
g)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_ERR, &quot;cannot allocate netlink message&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot=
;cannot allocate netlink message&quot;);</span><br><span>         return NU=
LL;</span><br><span>     }</span><br><span> </span><br><span>@@ -140,7 +140=
,7 @@</span><br><span>             break;</span><br><span> </span><br><span=
>         case -NLE_NOMEM:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(M_ERR, &quot;%s: netlink out of memory error&quot;, pr=
efix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_FATAL, &quot;%s: netlink out of memory error&quot;, prefix);</span><br=
><span>             break;</span><br><span> </span><br><span>         case =
-NLE_AGAIN:</span><br><span>@@ -148,7 +148,7 @@</span><br><span>           =
  break;</span><br><span> </span><br><span>         case -NLE_NODEV:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot=
;%s: netlink reports device not found:&quot;, prefix);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: netli=
nk reports device not found:&quot;, prefix);</span><br><span>             b=
reak;</span><br><span> </span><br><span>         case -NLE_OBJ_NOTFOUND:</s=
pan><br><span>@@ -387,19 +387,19 @@</span><br><span> static void</span><br>=
<span> ovpn_dco_init_netlink(dco_context_t *dco)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;ovpn_dco_id =3D r=
esolve_ovpn_netlink_id(M_ERR);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);</s=
pan><br><span> </span><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc();=
</span><br><span> </span><br><span>     if (!dco-&gt;nl_sock)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_ERR, &quot;Cannot create netlink socket&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Cannot create netl=
ink socket&quot;);</span><br><span>     }</span><br><span> </span><br><span=
>     int ret =3D genl_connect(dco-&gt;nl_sock);</span><br><span>     if (r=
et)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(M_ERR, &quot;Cannot connect to generic netlink: %s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;Cannot connect to generic netlink: %s&quot;,</span><br><span>       =
      nl_geterror(ret));</span><br><span>     }</span><br><span> </span><br=
><span>@@ -415,7 +415,7 @@</span><br><span>     dco-&gt;nl_cb =3D nl_cb_all=
oc(NL_CB_DEFAULT);</span><br><span>     if (!dco-&gt;nl_cb)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
ERR, &quot;failed to allocate netlink callback&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;failed to all=
ocate netlink callback&quot;);</span><br><span>     }</span><br><span> </sp=
an><br><span>     nl_socket_set_cb(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><=
br><span>@@ -484,7 +484,7 @@</span><br><span> </span><br><span>     if (dco=
-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;cannot get mcast g=
roup: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;cannot get=
 mcast group: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));</span><br=
><span>     }</span><br><span> </span><br><span>     /* Register for ovpn-d=
co specific multicast messages that the kernel may</span><br><span>@@ -493,=
7 +493,7 @@</span><br><span>     int ret =3D nl_socket_add_membership(dco-&=
gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span><br><span>     if (ret)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_ERR, &quot;%s: failed to join groups: %d&quot;, __func__, ret);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, =
&quot;%s: failed to join groups: %d&quot;, __func__, ret);</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1096?u=
sp=3Demail">change 1096</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1096?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc442b4426c02de7282d0f69629=
e8a10b679c589 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1096 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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


--/HxEsRtsR78=--

