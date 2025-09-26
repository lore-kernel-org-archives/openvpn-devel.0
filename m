From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 20:39:10 +0000
In-Reply-To: <gerrit.1758817708000.I473d345d10fc406f76fbdb131c28cc4fc54822fd@...2715...>
References: <gerrit.1758817708000.I473d345d10fc406f76fbdb131c28cc4fc54822fd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <4c411d354dafff6e18c9c74def8a1119fc626e5d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0ONS/Po/PRc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: Fix
 -Wconversion warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0ONS/Po/PRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
20?usp=3Demail )

Change subject: dco_linux: Fix -Wconversion warnings
......................................................................

dco_linux: Fix -Wconversion warnings

Combination of using the correct types and some
unavoidable safe size_t->int casts.

Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1220
Message-Id: <20250926142442.20796-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59239172/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 5 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 395a38f..d46fa46 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -62,11 +62,6 @@

 typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * @brief resolves the netlink ID for ovpn-dco
  *
@@ -110,7 +105,7 @@
 }

 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, int cmd)
+ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -346,7 +341,7 @@

     if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
     {
-        ack_len +=3D err->msg.nlmsg_len - sizeof(*nlh);
+        ack_len +=3D err->msg.nlmsg_len - (int)sizeof(*nlh);
     }

     if (len <=3D ack_len)
@@ -360,8 +355,8 @@
     nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);
     if (tb_msg[NLMSGERR_ATTR_MSG])
     {
-        len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
-                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+        len =3D (int)strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
+                           nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
         msg(M_WARN, "kernel error: %*s", len, (char *)nla_data(tb_msg[NLMS=
GERR_ATTR_MSG]));
     }

@@ -606,7 +601,7 @@
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __fu=
nc__, slot, keyid, peerid,
         ciphername);

-    const size_t key_len =3D cipher_kt_key_size(ciphername);
+    const int key_len =3D cipher_kt_key_size(ciphername);
     const int nonce_tail_len =3D 8;

     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);
@@ -1303,8 +1298,4 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1220?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd
Gerrit-Change-Number: 1220
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--0ONS/Po/PRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1220?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: Fix -Wconversion warnings<br><br>C=
ombination of using the correct types and some<br>unavoidable safe size_t-&=
gt;int casts.<br><br>Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: An=
tonio Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1220<br>Message-Id: &lt;20250926142442.20796-1-gert@...220...=
..1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/592=
39172/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/openvpn/dco_linux.c<br>1 file changed, 5 insertions(+), 14 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index 395a38f..d46fa46 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -6=
2,11 +62,6 @@</span><br><span> </span><br><span> typedef int (*ovpn_nl_cb)(=
struct nl_msg *msg, void *arg);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /**</span><br><span>  * @brief resolves the netlink ID fo=
r ovpn-dco</span><br><span>  *</span><br><span>@@ -110,7 +105,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static struct nl_msg *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_co=
ntext_t *dco, int cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)</span><br><span> =
{</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><=
span>     if (!nl_msg)</span><br><span>@@ -346,7 +341,7 @@</span><br><span>=
 </span><br><span>     if (!(nlh-&gt;nlmsg_flags &amp; NLM_F_CAPPED))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ack_len +=3D err-&gt;msg.nlmsg_len - sizeof(*nlh);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ack_len +=3D err-&gt;msg.nlmsg_l=
en - (int)sizeof(*nlh);</span><br><span>     }</span><br><span> </span><br>=
<span>     if (len &lt;=3D ack_len)</span><br><span>@@ -360,8 +355,8 @@</sp=
an><br><span>     nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NUL=
L);</span><br><span>     if (tb_msg[NLMSGERR_ATTR_MSG])</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D st=
rnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                      nla_len(tb_msg[NLMSGERR_=
ATTR_MSG]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 len =3D (int)strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           n=
la_len(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span>         msg(M_WARN, &q=
uot;kernel error: %*s&quot;, len, (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG=
]));</span><br><span>     }</span><br><span> </span><br><span>@@ -606,7 +60=
1,7 @@</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, =
peer-id %d, cipher %s&quot;, __func__, slot, keyid, peerid,</span><br><span=
>         ciphername);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const size_t key_len =3D cipher_kt_key_size(cipherna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int k=
ey_len =3D cipher_kt_key_size(ciphername);</span><br><span>     const int n=
once_tail_len =3D 8;</span><br><span> </span><br><span>     struct nl_msg *=
nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);</span><br><span>@@=
 -1303,8 +1298,4 @@</span><br><span>     return &quot;AES-128-GCM:AES-256-G=
CM:AES-192-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> #endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1220?usp=3Demail">change 1220</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1220?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I473d345d10fc406f76fbdb131c2=
8cc4fc54822fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1220 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--0ONS/Po/PRc=--

