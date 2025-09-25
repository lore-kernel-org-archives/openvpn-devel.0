From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 25 Sep 2025 16:28:31 +0000
References: <gerrit.1758817708000.I473d345d10fc406f76fbdb131c28cc4fc54822fd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7eeacd2bd26dbf97391a6270379410b4d2c2a77c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hHqq5S72mzA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hHqq5S72mzA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1220?usp=3Demail

to review the following change.


Change subject: dco_linux: Fix -Wconversion warnings
......................................................................

dco_linux: Fix -Wconversion warnings

Combination of using the correct types and some
unavoidable safe size_t->int casts.

Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dco_linux.c
1 file changed, 5 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1220/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--hHqq5S72mzA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1220?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: Fix -Wconversion warnings<br><br>Combination of u=
sing the correct types and some<br>unavoidable safe size_t-&gt;int casts.<b=
r><br>Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/dco_li=
nux.c<br>1 file changed, 5 insertions(+), 14 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1220/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span=
>index 395a38f..d46fa46 100644</span><br><span>--- a/src/openvpn/dco_linux.=
c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -62,11 +=
62,6 @@</span><br><span> </span><br><span> typedef int (*ovpn_nl_cb)(struct=
 nl_msg *msg, void *arg);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /**</span><br><span>  * @brief resolves the netlink ID for ovpn=
-dco</span><br><span>  *</span><br><span>@@ -110,7 +105,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static struct nl_msg *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_context_=
t *dco, int cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovp=
n_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)</span><br><span> {</spa=
n><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span> =
    if (!nl_msg)</span><br><span>@@ -346,7 +341,7 @@</span><br><span> </spa=
n><br><span>     if (!(nlh-&gt;nlmsg_flags &amp; NLM_F_CAPPED))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ac=
k_len +=3D err-&gt;msg.nlmsg_len - sizeof(*nlh);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ack_len +=3D err-&gt;msg.nlmsg_len - (=
int)sizeof(*nlh);</span><br><span>     }</span><br><span> </span><br><span>=
     if (len &lt;=3D ack_len)</span><br><span>@@ -360,8 +355,8 @@</span><br=
><span>     nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);</s=
pan><br><span>     if (tb_msg[NLMSGERR_ATTR_MSG])</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D strnlen(=
(char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                      nla_len(tb_msg[NLMSGERR_ATTR_M=
SG]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len =
=3D (int)strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           nla_le=
n(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span>         msg(M_WARN, &quot;k=
ernel error: %*s&quot;, len, (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -606,7 +601,7 @=
@</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-=
id %d, cipher %s&quot;, __func__, slot, keyid, peerid,</span><br><span>    =
     ciphername);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const size_t key_len =3D cipher_kt_key_size(ciphername);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int key_le=
n =3D cipher_kt_key_size(ciphername);</span><br><span>     const int nonce_=
tail_len =3D 8;</span><br><span> </span><br><span>     struct nl_msg *nl_ms=
g =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);</span><br><span>@@ -130=
3,8 +1298,4 @@</span><br><span>     return &quot;AES-128-GCM:AES-256-GCM:AE=
S-192-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1220?usp=3Demail">change 1220</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1220?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I473d345d10fc406f76fbdb131c2=
8cc4fc54822fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1220 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--hHqq5S72mzA=--

