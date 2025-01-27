From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 20:15:24 +0000
In-Reply-To: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
References: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <850d67c0b495ebedc0aa36f6b524157a213851fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="itFY7q4v9J0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--itFY7q4v9J0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail

to look at the new patch set (#9).


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
M src/openvpn/dco_linux.c
1 file changed, 33 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/841/9

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b038382..fa7abd3 100644
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
@@ -304,7 +323,7 @@
                  struct nlmsgerr *err, void *arg)
 {
     struct nlmsghdr *nlh =3D (struct nlmsghdr *)err - 1;
-    struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
+    struct nlattr *tb_msg[OVPN_NLMSGERR_ATTR_MAX + 1];
     int len =3D nlh->nlmsg_len;
     struct nlattr *attrs;
     int *ret =3D arg;
@@ -330,7 +349,7 @@
     attrs =3D (void *)((unsigned char *)nlh + ack_len);
     len -=3D ack_len;

-    nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
+    nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);
     if (tb_msg[NLMSGERR_ATTR_MSG])
     {
         len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
@@ -339,6 +358,18 @@
             (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
     }

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
+    }
+
     return NL_STOP;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b
Gerrit-Change-Number: 841
Gerrit-PatchSet: 9
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--itFY7q4v9J0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>ordex <strong>uploaded patch set #9</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco_linux: extend netlink error cb with extra info<br><br>A netlink error=
 may contain more specific attributes: i.e.<br>missing attributes or missin=
g neted objects.<br><br>Parse and print this information too.<br><br>Note t=
hat we are re-defining some enum entries that exist<br>in netlink.h startin=
g with linux-6.1.<br>Since we do support distros not shipping an up-to-date=
<br>netlink.h, we had to re-define the entries we need for<br>this patch.<b=
r><br>Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b<br>Signed-off-by=
: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/dco_=
linux.c<br>1 file changed, 33 insertions(+), 2 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/841/9</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><spa=
n>index b038382..fa7abd3 100644</span><br><span>--- a/src/openvpn/dco_linux=
.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -291,6 =
+291,25 @@</span><br><span>     return NL_SKIP;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The fol=
lowing enum members exist in netlink.h since linux-6.1.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * However, some distro we support stil=
l ship an old header, thus</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * failing the OpenVPN compilation.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * For the time being we add the needed defines manually.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * We will drop this definition=
 once we stop supporting those old</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * distros.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NLMSGE=
RR_ATTR_MISS_TYPE: type of a missing required attribute,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  %NLMSGERR_ATTR_MISS_NEST will not =
be present if the attribute was</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  missing at the message level</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_MISS_NEST: offset of the nest wh=
ere attribute was missing</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_=
nlmsgerr_attrs {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_NLMSGERR_ATTR_MISS_TYPE =3D 5,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MISS_NEST =3D 6,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MAX =3D 6,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This function is use=
d as error callback on the netlink socket.</span><br><span>  * When somethi=
ng goes wrong and the kernel returns an error, this function is</span><br><=
span>  * invoked.</span><br><span>@@ -304,7 +323,7 @@</span><br><span>     =
             struct nlmsgerr *err, void *arg)</span><br><span> {</span><br>=
<span>     struct nlmsghdr *nlh =3D (struct nlmsghdr *)err - 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_msg[NLMSGER=
R_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct nlattr *tb_msg[OVPN_NLMSGERR_ATTR_MAX + 1];</span><br><span>     in=
t len =3D nlh-&gt;nlmsg_len;</span><br><span>     struct nlattr *attrs;</sp=
an><br><span>     int *ret =3D arg;</span><br><span>@@ -330,7 +349,7 @@</sp=
an><br><span>     attrs =3D (void *)((unsigned char *)nlh + ack_len);</span=
><br><span>     len -=3D ack_len;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_msg, NLMSGERR_ATTR_MAX, at=
trs, len, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);</span><br><sp=
an>     if (tb_msg[NLMSGERR_ATTR_MSG])</span><br><span>     {</span><br><sp=
an>         len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</s=
pan><br><span>@@ -339,6 +358,18 @@</span><br><span>             (char *)nla=
_data(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb_msg[OVPN=
_NLMSGERR_ATTR_MISS_NEST])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_WARN, &quot;kernel error: missing required nesting type %u\n&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            nla_get_=
u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t=
b_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN, &quot;kernel error: missing required attribute type =
%u\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     return NL_STOP;</span><br><span=
> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">change 841<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e27ff335d892429334137d028f=
8503da4e4ca5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--itFY7q4v9J0=--

