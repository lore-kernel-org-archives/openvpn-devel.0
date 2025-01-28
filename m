From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 14:04:35 +0000
In-Reply-To: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
References: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <4fdfcc79c1aeb219ee679200c4ec77a91e18ce42-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Chq679o03+8="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Chq679o03+8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
1?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250128134454.2888-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
658.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 33 insertions(+), 2 deletions(-)




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
Gerrit-PatchSet: 10
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Chq679o03+8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/841?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco_linux: extend netlink error cb with extra =
info<br><br>A netlink error may contain more specific attributes: i.e.<br>m=
issing attributes or missing neted objects.<br><br>Parse and print this inf=
ormation too.<br><br>Note that we are re-defining some enum entries that ex=
ist<br>in netlink.h starting with linux-6.1.<br>Since we do support distros=
 not shipping an up-to-date<br>netlink.h, we had to re-define the entries w=
e need for<br>this patch.<br><br>Change-Id: I9e27ff335d892429334137d028f850=
3da4e4ca5b<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<b=
r>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2=
0250128134454.2888-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg30658.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 f=
ile changed, 33 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index b038382..fa7abd3 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -2=
91,6 +291,25 @@</span><br><span>     return NL_SKIP;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Th=
e following enum members exist in netlink.h since linux-6.1.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * However, some distro we support=
 still ship an old header, thus</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * failing the OpenVPN compilation.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * For the time being we add the needed defines manually.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * We will drop this defin=
ition once we stop supporting those old</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * distros.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @N=
LMSGERR_ATTR_MISS_TYPE: type of a missing required attribute,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  %NLMSGERR_ATTR_MISS_NEST will=
 not be present if the attribute was</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  missing at the message level</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_MISS_NEST: offset of the ne=
st where attribute was missing</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum =
ovpn_nlmsgerr_attrs {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    OVPN_NLMSGERR_ATTR_MISS_TYPE =3D 5,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MISS_NEST =3D 6,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NLMSGERR_ATTR_MAX =3D 6,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This function i=
s used as error callback on the netlink socket.</span><br><span>  * When so=
mething goes wrong and the kernel returns an error, this function is</span>=
<br><span>  * invoked.</span><br><span>@@ -304,7 +323,7 @@</span><br><span>=
                  struct nlmsgerr *err, void *arg)</span><br><span> {</span=
><br><span>     struct nlmsghdr *nlh =3D (struct nlmsghdr *)err - 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_msg[NL=
MSGERR_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct nlattr *tb_msg[OVPN_NLMSGERR_ATTR_MAX + 1];</span><br><span>  =
   int len =3D nlh-&gt;nlmsg_len;</span><br><span>     struct nlattr *attrs=
;</span><br><span>     int *ret =3D arg;</span><br><span>@@ -330,7 +349,7 @=
@</span><br><span>     attrs =3D (void *)((unsigned char *)nlh + ack_len);<=
/span><br><span>     len -=3D ack_len;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_msg, NLMSGERR_ATTR_MAX,=
 attrs, len, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);</span><br>=
<span>     if (tb_msg[NLMSGERR_ATTR_MSG])</span><br><span>     {</span><br>=
<span>         len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),=
</span><br><span>@@ -339,6 +358,18 @@</span><br><span>             (char *)=
nla_data(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb_msg[O=
VPN_NLMSGERR_ATTR_MISS_NEST])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN, &quot;kernel error: missing required nesting type %u\n&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            nla_g=
et_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN, &quot;kernel error: missing required attribute ty=
pe %u\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     return NL_STOP;</span><br><s=
pan> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">change 8=
41</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e27ff335d892429334137d028f=
8503da4e4ca5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Chq679o03+8=--

