From: "ordex (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 23:31:01 +0000
In-Reply-To: <gerrit.1753486180000.Icbc70225d53ca678b8c22ed437b424c16e199d66@...2715...>
References: <gerrit.1753486180000.Icbc70225d53ca678b8c22ed437b424c16e199d66@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2e446207616344a84f9a686ffcab734e040ec655-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bh4i8sjgnXU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: clean up
 PEER_GET trigger and parser
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

--Bh4i8sjgnXU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1114?usp=3Demail

to look at the new patch set (#2).


Change subject: dco_linux: clean up PEER_GET trigger and parser
......................................................................

dco_linux: clean up PEER_GET trigger and parser

This patch is intended to reduce code duplication and
cleanup the DCO code around the PEER_GET command.

Specifically it:
* unified PEER_GET reply parser for `multi` and
  `non-multi` case
* unified PEER_GET request trigger for `multi` and
  `non-multi` case
* dropped struct multi_context from the argument list of
  dco_get_peer_stats_multi()

Github: closes OpenVPN/openvpn#800
Change-Id: Icbc70225d53ca678b8c22ed437b424c16e199d66
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/multi.c
5 files changed, 49 insertions(+), 112 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1114/2

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 9078417..2ce0eb1 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -230,11 +230,9 @@
  * Update traffic statistics for all peers
  *
  * @param dco                   DCO device context
- * @param m                     the server context
  * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                             const bool raise_sigusr1_on_err);
+int dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_=
on_err);

 /**
  * Update traffic statistics for single peer
@@ -374,8 +372,7 @@
 }

 static inline int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
     return 0;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 98d8fb5..e55e58d 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -713,8 +713,7 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {

     struct ifdrv drv;
@@ -774,7 +773,7 @@
         const nvlist_t *peer =3D nvpeers[i];
         uint32_t peerid =3D nvlist_get_number(peer, "peerid");

-        dco_update_peer_stat(m, peerid, nvlist_get_nvlist(peer, "bytes"));
+        dco_update_peer_stat(dco->c->multi, peerid, nvlist_get_nvlist(peer=
, "bytes"));
     }

     nvlist_destroy(nvl);
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 728fb7e..9ad3d51 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -877,53 +877,8 @@
 }

 static int
-ovpn_handle_peer_multi(dco_context_t *dco, struct nlattr *attrs[])
-{
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    /* this function assumes openvpn is running in multipeer mode as
-     * it accesses c->multi
-     */
-    if (dco->ifmode !=3D OVPN_MODE_MP)
-    {
-        msg(M_WARN, "%s: can't parse 'multi-peer' message on P2P instance"=
, __func__);
-        return NL_SKIP;
-    }
-
-    if (!attrs[OVPN_A_PEER])
-    {
-        return NL_SKIP;
-    }
-
-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);
-
-    if (!tb_peer[OVPN_A_PEER_ID])
-    {
-        msg(M_WARN, "ovpn-dco: no peer-id provided in (MULTI) PEER_GET rep=
ly");
-        return NL_SKIP;
-    }
-
-    struct multi_context *m =3D dco->c->multi;
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-
-    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
-    {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer=
_id);
-
-    return NL_OK;
-}
-
-static int
 ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
     if (!attrs[OVPN_A_PEER])
     {
         msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
@@ -942,12 +897,25 @@
     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
     struct context_2 *c2;
=20
+    msg(D_DCO_DEBUG, "%s: parsing message for peer %u...", __func__, peer_=
id);
+
     if (dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
         c2 =3D &dco->c->c2;
+        if (c2->tls_multi->dco_peer_id !=3D peer_id)
+        {
+            return NL_SKIP;
+        }
     }
     else
     {
+        if (peer_id >=3D dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)",=
 __func__, peer_id,
+                dco->c->multi->max_clients);
+            return NL_SKIP;
+        }
+
         struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
         if (!mi)
         {
@@ -958,14 +926,6 @@
         c2 =3D &mi->context.c2;
     }

-    /* at this point this check should never fail for MP mode,
-     * but it's still fully valid for P2P mode
-     */
-    if (c2->tls_multi->dco_peer_id !=3D peer_id)
-    {
-        return NL_SKIP;
-    }
-
     dco_update_peer_stat(c2, tb_peer, peer_id);
=20
     return NL_OK;
@@ -1176,17 +1136,7 @@
     {
         case OVPN_CMD_PEER_GET:
         {
-            /* this message is part of a peer list dump, hence triggered
-             * by a MP/server instance
-             */
-            if (nlh->nlmsg_flags & NLM_F_MULTI)
-            {
-                return ovpn_handle_peer_multi(dco, attrs);
-            }
-            else
-            {
-                return ovpn_handle_peer(dco, attrs);
-            }
+            return ovpn_handle_peer(dco, attrs);
         }

         case OVPN_CMD_PEER_DEL_NTF:
@@ -1221,52 +1171,32 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }

-int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+static int
+dco_get_peer(dco_context_t *dco, int peer_id, const bool raise_sigusr1_on_=
err)
 {
-    msg(D_DCO_DEBUG, "%s", __func__);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);
-
-    nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;
-
-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
-
-    nlmsg_free(nl_msg);
-
-    if (raise_sigusr1_on_err && ret < 0)
-    {
-        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO p=
eer"
-            "may have been deleted from the kernel without notifying "
-            "userspace. Restarting the session");
-        register_signal(m->top.sig, SIGUSR1, "dco peer stats error");
-    }
-    return ret;
-}
-
-int
-dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
-{
-    int peer_id =3D c->c2.tls_multi->dco_peer_id;
-    if (peer_id =3D=3D -1)
+    /* peer_id =3D=3D -1 means "dump all peers", but this is allowed in MP=
 mode only.
+     * If it happens in P2P mode it means that the DCO peer was deleted an=
d we
+     * can simply bail out
+     */
+    if (peer_id =3D=3D -1 && dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
         return 0;
     }

     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);

-    if (!c->c1.tuntap)
-    {
-        return 0;
-    }
-
-    dco_context_t *dco =3D &c->c1.tuntap->dco;
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;

-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+    if (peer_id !=3D -1)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+    }
+    else
+    {
+        nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;
+    }
     nla_nest_end(nl_msg, attr);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
@@ -1279,11 +1209,23 @@
         msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO p=
eer"
             "may have been deleted from the kernel without notifying "
             "userspace. Restarting the session");
-        register_signal(c->sig, SIGUSR1, "dco peer stats error");
+        register_signal(dco->c->sig, SIGUSR1, "dco peer stats error");
     }
     return ret;
 }

+int
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+{
+    return dco_get_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id, =
raise_sigusr1_on_err);
+}
+
+int
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
+{
+    return dco_get_peer(dco, -1, raise_sigusr1_on_err);
+}
+
 bool
 dco_available(int msglevel)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e5a33a0..995b121 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -715,8 +715,7 @@
 }

 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a62c57a..c5691ff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -551,7 +551,7 @@
 {
     if (dco_enabled(&m->top.options))
     {
-        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, false) < 0)
+        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, false) < 0)
         {
             return;
         }
@@ -862,7 +862,7 @@

         if (dco_enabled(&m->top.options))
         {
-            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, true) =
< 0)
+            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, true) < 0)
             {
                 return;
             }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1114?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icbc70225d53ca678b8c22ed437b424c16e199d66
Gerrit-Change-Number: 1114
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Bh4i8sjgnXU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1114?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dco_linux: clean up PEER_GET trigger and parser<br><br>This patch is int=
ended to reduce code duplication and<br>cleanup the DCO code around the PEE=
R_GET command.<br><br>Specifically it:<br>* unified PEER_GET reply parser f=
or `multi` and<br>  `non-multi` case<br>* unified PEER_GET request trigger =
for `multi` and<br>  `non-multi` case<br>* dropped struct multi_context fro=
m the argument list of<br>  dco_get_peer_stats_multi()<br><br>Github: close=
s OpenVPN/openvpn#800<br>Change-Id: Icbc70225d53ca678b8c22ed437b424c16e199d=
66<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br=
>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_li=
nux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/multi.c<br>5 files change=
d, 49 insertions(+), 112 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/14/1114/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/dco.h b/src/openvpn/dco.h</span><br><span>index 9078417..2ce0eb1 100644</=
span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dc=
o.h</span><br><span>@@ -230,11 +230,9 @@</span><br><span>  * Update traffic=
 statistics for all peers</span><br><span>  *</span><br><span>  * @param dc=
o                   DCO device context</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param m                     the server context</span><=
br><span>  * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error=
</span><br><span>  **/</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       const bool raise_sigusr1_on_err);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int dco_get_peer_stats_multi(dco_context_t *dco, const=
 bool raise_sigusr1_on_err);</span><br><span> </span><br><span> /**</span><=
br><span>  * Update traffic statistics for single peer</span><br><span>@@ -=
374,8 +372,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_p=
eer_stats_multi(dco_context_t *dco, struct multi_context *m,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                         const bool =
raise_sigusr1_on_err)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_=
err)</span><br><span> {</span><br><span>     return 0;</span><br><span> }</=
span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_fre=
ebsd.c</span><br><span>index 98d8fb5..e55e58d 100644</span><br><span>--- a/=
src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</=
span><br><span>@@ -713,8 +713,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                         const =
bool raise_sigusr1_on_err)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr=
1_on_err)</span><br><span> {</span><br><span> </span><br><span>     struct =
ifdrv drv;</span><br><span>@@ -774,7 +773,7 @@</span><br><span>         con=
st nvlist_t *peer =3D nvpeers[i];</span><br><span>         uint32_t peerid =
=3D nvlist_get_number(peer, &quot;peerid&quot;);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        dco_update_peer_stat(m=
, peerid, nvlist_get_nvlist(peer, &quot;bytes&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        dco_update_peer_stat(dco-&gt;c-&=
gt;multi, peerid, nvlist_get_nvlist(peer, &quot;bytes&quot;));</span><br><s=
pan>     }</span><br><span> </span><br><span>     nvlist_destroy(nvl);</spa=
n><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c<=
/span><br><span>index 728fb7e..9ad3d51 100644</span><br><span>--- a/src/ope=
nvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><s=
pan>@@ -877,53 +877,8 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_ha=
ndle_peer_multi(dco_context_t *dco, struct nlattr *attrs[])</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, =
__func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* this function assumes ope=
nvpn is running in multipeer mode as</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * it accesses c-&gt;multi</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (dco-&gt;ifmode !=3D OVPN_MODE_MP)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: can&#39;t parse &#39;multi-pe=
er&#39; message on P2P instance&quot;, __func__);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!attrs[OVPN_A_PEER])</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse_nested(t=
b_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!tb_peer[OVPN_A_PEER_ID])</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_WARN, &quot;ovpn-dco: no peer-id provided in (MULTI) P=
EER_GET reply&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct multi_context *m =3D dco=
-&gt;c-&gt;multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (peer_id &gt;=3D m-&gt;max_clients || !m-&gt;instanc=
es[peer_id])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot=
;%s: cannot store DCO stats for peer %u&quot;, __func__,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            peer_id);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    dco_update_peer_stat(&amp;m-&gt;instances[peer_id]-&gt;context.c2, tb_p=
eer, peer_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static int</span><br><span> ovpn_handle_peer(dco_context_t *dco, struct n=
lattr *attrs[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __fun=
c__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>     if (!attrs[OVPN_A_PEER])</span><br><span>     {</span><br><span>     =
    msg(D_DCO_DEBUG, &quot;%s: malformed reply&quot;, __func__);</span><br>=
<span>@@ -942,12 +897,25 @@</span><br><span>     uint32_t peer_id =3D nla_g=
et_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span>     struct context_2 *c2;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_DCO_DEBUG, &quot;%s: parsing message for peer %u...&quot;, __func_=
_, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span>   =
  {</span><br><span>         c2 =3D &amp;dco-&gt;c-&gt;c2;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (c2-&gt;tls_multi-&gt;dco=
_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
peer_id &gt;=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received out of b=
ound peer_id %u (max=3D%u)&quot;, __func__, peer_id,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;c-&gt;multi-&gt;m=
ax_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>         struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;inst=
ances[peer_id];</span><br><span>         if (!mi)</span><br><span>         =
{</span><br><span>@@ -958,14 +926,6 @@</span><br><span>         c2 =3D &amp=
;mi-&gt;context.c2;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* at this point this check shou=
ld never fail for MP mode,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * but it&#39;s still fully valid for P2P mode</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D peer_id)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     dco_update_peer_stat(c2, tb_pe=
er, peer_id);</span><br><span> </span><br><span>     return NL_OK;</span><b=
r><span>@@ -1176,17 +1136,7 @@</span><br><span>     {</span><br><span>     =
    case OVPN_CMD_PEER_GET:</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* this message is part of a p=
eer list dump, hence triggered</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             * by a MP/server instance</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (nlh-&gt;nlmsg_flags &amp; NLM_F_MULTI)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                return ovpn_ha=
ndle_peer_multi(dco, attrs);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  return ovpn_handle_peer(dco, attrs);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return ovpn_handle_peer(dco, attrs);</span><br><span=
>         }</span><br><span> </span><br><span>         case OVPN_CMD_PEER_D=
EL_NTF:</span><br><span>@@ -1221,52 +1171,32 @@</span><br><span>     return=
 ovpn_nl_recvmsgs(dco, __func__);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_context_t *dco=
, struct multi_context *m,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         const bool raise_sigusr1_on_err)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_get_peer(dco_context_t *dco, int peer=
_id, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s&quot;, __f=
unc__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_=
dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    nlmsg_free(nl_msg);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (raise_sigusr1_on_err &amp;&amp; ret &lt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_WARN, &quot;Error retrieving DCO peer sta=
ts: the underlying DCO peer&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            &quot;may have been deleted from the kernel without=
 notifying &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;userspace. Restarting the session&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        register_signal(m-&gt;top.sig, SI=
GUSR1, &quot;dco peer stats error&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dco_get_peer_stats(struct context *c, const bool raise_sigusr=
1_on_err)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2.tls=
_multi-&gt;dco_peer_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (peer_id =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* peer_id =3D=3D -1 means &quot;dump all peers&quot;, but thi=
s is allowed in MP mode only.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * If it happens in P2P mode it means that the DCO peer was d=
eleted and we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 can simply bail out</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pee=
r_id =3D=3D -1 &amp;&amp; dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><s=
pan>     {</span><br><span>         return 0;</span><br><span>     }</span>=
<br><span> </span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot=
;, __func__, peer_id);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!c-&gt;c1.tuntap)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;c-=
&gt;c1.tuntap-&gt;dco;</span><br><span>     struct nl_msg *nl_msg =3D ovpn_=
dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</span><br><span>     struct nlatt=
r *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int r=
et =3D -EMSGSIZE;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (peer_id !=3D -1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_=
ID, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=
=3D NLM_F_DUMP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span>=
<br><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><=
span>@@ -1279,11 +1209,23 @@</span><br><span>         msg(M_WARN, &quot;Err=
or retrieving DCO peer stats: the underlying DCO peer&quot;</span><br><span=
>             &quot;may have been deleted from the kernel without notifying=
 &quot;</span><br><span>             &quot;userspace. Restarting the sessio=
n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        regi=
ster_signal(c-&gt;sig, SIGUSR1, &quot;dco peer stats error&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        register_signal(dco-=
&gt;c-&gt;sig, SIGUSR1, &quot;dco peer stats error&quot;);</span><br><span>=
     }</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct context =
*c, const bool raise_sigusr1_on_err)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return dco_get_peer(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.tls_multi-&gt=
;dco_peer_id, raise_sigusr1_on_err);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats_multi(dco_context=
_t *dco, const bool raise_sigusr1_on_err)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return dco_get_peer(dco, -1, raise_sigusr1_on_err);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> dco_available=
(int msglevel)</span><br><span> {</span><br><span>diff --git a/src/openvpn/=
dco_win.c b/src/openvpn/dco_win.c</span><br><span>index e5a33a0..995b121 10=
0644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/=
openvpn/dco_win.c</span><br><span>@@ -715,8 +715,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_co=
ntext *m,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             const bool raise_sigusr1_on_err)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_get_peer_stats_multi(dco_context_t *dco, cons=
t bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>     /* Not=
 implemented. */</span><br><span>     return 0;</span><br><span>diff --git =
a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index a62c57a..=
c5691ff 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>++=
+ b/src/openvpn/multi.c</span><br><span>@@ -551,7 +551,7 @@</span><br><span=
> {</span><br><span>     if (dco_enabled(&amp;m-&gt;top.options))</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m, false) &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dc=
o_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, false) &lt; 0)</sp=
an><br><span>         {</span><br><span>             return;</span><br><spa=
n>         }</span><br><span>@@ -862,7 +862,7 @@</span><br><span> </span><b=
r><span>         if (dco_enabled(&amp;m-&gt;top.options))</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, m, true) &lt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(dco_get_peer_stats_multi(&amp;m-&gt;top.c1.tuntap-&gt;dco, true) &lt; 0)</=
span><br><span>             {</span><br><span>                 return;</spa=
n><br><span>             }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1114?usp=3Demail">chang=
e 1114</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1114?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbc70225d53ca678b8c22ed437b=
424c16e199d66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1114 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Bh4i8sjgnXU=--

