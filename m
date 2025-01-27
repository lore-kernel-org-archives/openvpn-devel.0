From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 11:00:55 +0000
In-Reply-To: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
References: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <423514acce5d45e75aa0bfa42640994dac44bc82-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3D3eCsAXVYM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: extend
 netlink error cb with extra info
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

--3D3eCsAXVYM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail

to look at the new patch set (#6).


Change subject: dco_linux: extend netlink error cb with extra info
......................................................................

dco_linux: extend netlink error cb with extra info

A netlink error may contain more specific attributes: i.e.
missing attributes or missing neted objects.

Parse and print this information too.

Note that we are re-defining some enum entries that exist
in netlink.h starting with linux-6.1.
Since we do support distros not shipping an up-to-date
netlink.h, we had to re-define the entries we need for
this patch.

Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/Makefile.am
M src/openvpn/dco_linux.c
2 files changed, 36 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/841/6

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ecb2bcf..7ed27a5 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -79,6 +79,7 @@
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	netlink.h \
 	ovpn_dco_freebsd.h \
 	ovpn_dco_linux.h \
 	ovpn_dco_win.h \
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b038382..34f48f2 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -291,6 +291,25 @@
     return NL_SKIP;
 }

+/* The following enum members exist in netlink.h since linux-6.1.
+ * However, some distro we support still ship an old header, thus
+ * failing the OpenVPN compilation.
+ *
+ * For the time being we add the needed defines manually.
+ * We will drop this definition once we stop supporting those old
+ * distros.
+ *
+ * @NLMSGERR_ATTR_MISS_TYPE: type of a missing required attribute,
+ *  %NLMSGERR_ATTR_MISS_NEST will not be present if the attribute was
+ *  missing at the message level
+ * @NLMSGERR_ATTR_MISS_NEST: offset of the nest where attribute was missing
+ */
+enum ovpn_nlmsgerr_attrs {
+    OVPN_NLMSGERR_ATTR_MISS_TYPE =3D 5,
+    OVPN_NLMSGERR_ATTR_MISS_NEST =3D 6,
+    OVPN_NLMSGERR_ATTR_MAX =3D 6,
+};
+
 /* This function is used as error callback on the netlink socket.
  * When something goes wrong and the kernel returns an error, this functio=
n is
  * invoked.
@@ -331,12 +350,24 @@
     len -=3D ack_len;

     nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
-    if (tb_msg[NLMSGERR_ATTR_MSG])
+    if (tb_msg[OVPN_NLMSGERR_ATTR_MSG])
     {
-        len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
-                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+        len =3D strnlen((char *)nla_data(tb_msg[OVPN_NLMSGERR_ATTR_MSG]),
+                      nla_len(tb_msg[OVPN_NLMSGERR_ATTR_MSG]));
         msg(M_WARN, "kernel error: %*s\n", len,
-            (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
+            (char *)nla_data(tb_msg[OVPN_NLMSGERR_ATTR_MSG]));
+    }
+
+    if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST])
+    {
+        msg(M_WARN, "kernel error: missing required nesting type %u\n",
+            nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));
+    }
+
+    if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])
+    {
+        msg(M_WARN, "kernel error: missing required attribute type %u\n",
+            nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));
     }

     return NL_STOP;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b
Gerrit-Change-Number: 841
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--3D3eCsAXVYM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex. </p>
<p>ordex <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco_linux: extend netlink error cb with extra info<br><br>A netlink error=
 may contain more specific attributes: i.e.<br>missing attributes or missin=
g neted objects.<br><br>Parse and print this information too.<br><br>Note t=
hat we are re-defining some enum entries that exist<br>in netlink.h startin=
g with linux-6.1.<br>Since we do support distros not shipping an up-to-date=
<br>netlink.h, we had to re-define the entries we need for<br>this patch.<b=
r><br>Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b<br>Signed-off-by=
: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/Make=
file.am<br>M src/openvpn/dco_linux.c<br>2 files changed, 36 insertions(+), =
4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/41/841/6</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/Makefile.am b/src/open=
vpn/Makefile.am</span><br><span>index ecb2bcf..7ed27a5 100644</span><br><sp=
an>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile=
.am</span><br><span>@@ -79,6 +79,7 @@</span><br><span> 	mbuf.c mbuf.h \</sp=
an><br><span> 	memdbg.h \</span><br><span> 	misc.c misc.h \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	netlink.h \</span><br><span> 	ovpn=
_dco_freebsd.h \</span><br><span> 	ovpn_dco_linux.h \</span><br><span> 	ovp=
n_dco_win.h \</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/op=
envpn/dco_linux.c</span><br><span>index b038382..34f48f2 100644</span><br><=
span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_li=
nux.c</span><br><span>@@ -291,6 +291,25 @@</span><br><span>     return NL_S=
KIP;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* The following enum members exist in netlink.h sinc=
e linux-6.1.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Howe=
ver, some distro we support still ship an old header, thus</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * failing the OpenVPN compilation.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * For the time being we add the need=
ed defines manually.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * We will drop this definition once we stop supporting those old</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * distros.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_MISS_TYPE: type of a missing requir=
ed attribute,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  %N=
LMSGERR_ATTR_MISS_NEST will not be present if the attribute was</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  missing at the message leve=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_=
MISS_NEST: offset of the nest where attribute was missing</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+enum ovpn_nlmsgerr_attrs {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MISS_TYPE =3D 5,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MIS=
S_NEST =3D 6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_NLMSGERR_ATTR_MAX =3D 6,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* This function is used as error callback on the netlink socket.<=
/span><br><span>  * When something goes wrong and the kernel returns an err=
or, this function is</span><br><span>  * invoked.</span><br><span>@@ -331,1=
2 +350,24 @@</span><br><span>     len -=3D ack_len;</span><br><span> </span=
><br><span>     nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tb_msg[NLMSGERR_A=
TTR_MSG])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb=
_msg[OVPN_NLMSGERR_ATTR_MSG])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        len =3D strnlen((char *)nla_data(tb=
_msg[NLMSGERR_ATTR_MSG]),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        len =3D strnlen((char *)=
nla_data(tb_msg[OVPN_NLMSGERR_ATTR_MSG]),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                      nla_len(tb_msg[OVPN_NLMSGERR_AT=
TR_MSG]));</span><br><span>         msg(M_WARN, &quot;kernel error: %*s\n&q=
uot;, len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            (char *)nla_data(tb_msg[OVPN_NLMSGER=
R_ATTR_MSG]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (tb_msg[OVPN_NLMSGERR_ATTR_MISS=
_NEST])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
kernel error: missing required nesting type %u\n&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            nla_get_u32(tb_msg[OVPN_NLM=
SGERR_ATTR_MISS_NEST]));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb_msg[OVPN_NLMSGERR=
_ATTR_MISS_TYPE])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;kernel error: missing required attribute type %u\n&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            nla_get_u32(tb_=
msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));</span><br><span>     }</span><br><span=
> </span><br><span>     return NL_STOP;</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3D=
email">change 841</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e27ff335d892429334137d028f=
8503da4e4ca5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3D3eCsAXVYM=--

