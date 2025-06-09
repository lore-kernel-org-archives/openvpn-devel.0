From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Jun 2025 17:46:21 +0000
In-Reply-To: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
References: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <7a7701c0e451d9de488f73bc17f45d6f5f3feb4d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqMILpvuN1g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: enable
 extended netlink error reporting
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

--JqMILpvuN1g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco_linux: enable extended netlink error reporting
......................................................................

dco_linux: enable extended netlink error reporting

The ovpn netlink code reports more verbose error
strings to help userspace understand what went wrong,
rather than just returning, for example, -EINVAL.

However, userspace must instruct the kernel netlink
subsystem that it wants to receive such strings.

code for parsing such strings has always been present
but it was never used.

Set the socket option which enables such reporting.

Change-Id: I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250609100216.3997-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
885.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 8 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1040/3

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 49dbdad..0345413 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -367,19 +367,19 @@
     {
         len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
                       nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
-        msg(M_WARN, "kernel error: %*s\n", len,
+        msg(M_WARN, "kernel error: %*s", len,
             (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
     }

     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST])
     {
-        msg(M_WARN, "kernel error: missing required nesting type %u\n",
+        msg(M_WARN, "kernel error: missing required nesting type %u",
             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));
     }

     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])
     {
-        msg(M_WARN, "kernel error: missing required attribute type %u\n",
+        msg(M_WARN, "kernel error: missing required attribute type %u",
             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));
     }

@@ -405,6 +405,11 @@
             nl_geterror(ret));
     }

+    /* enable Extended ACK for detailed error reporting */
+    ret =3D 1;
+    setsockopt(nl_socket_get_fd(dco->nl_sock), SOL_NETLINK, NETLINK_EXT_AC=
K,
+               &ret, sizeof(ret));
+
     /* set close on exec and non-block on the netlink socket */
     set_cloexec(nl_socket_get_fd(dco->nl_sock));
     set_nonblock(nl_socket_get_fd(dco->nl_sock));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3
Gerrit-Change-Number: 1040
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JqMILpvuN1g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1040=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: enable extended netlink error reporting<b=
r><br>The ovpn netlink code reports more verbose error<br>strings to help u=
serspace understand what went wrong,<br>rather than just returning, for exa=
mple, -EINVAL.<br><br>However, userspace must instruct the kernel netlink<b=
r>subsystem that it wants to receive such strings.<br><br>code for parsing =
such strings has always been present<br>but it was never used.<br><br>Set t=
he socket option which enables such reporting.<br><br>Change-Id: I4457b1d72=
62e0a39c275d33aaef6c4bcbeae6ab3<br>Signed-off-by: Antonio Quartulli &lt;ant=
onio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Me=
ssage-Id: &lt;20250609100216.3997-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31885.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco=
_linux.c<br>1 file changed, 8 insertions(+), 3 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1040/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><sp=
an>index 49dbdad..0345413 100644</span><br><span>--- a/src/openvpn/dco_linu=
x.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -367,1=
9 +367,19 @@</span><br><span>     {</span><br><span>         len =3D strnle=
n((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),</span><br><span>            =
           nla_len(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;kernel error: %*s\n&quo=
t;, len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;kernel error: %*s&quot;, len,</span><br><span>             (=
char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));</span><br><span>     }</span><=
br><span> </span><br><span>     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST])</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_WARN, &quot;kernel error: missing required nesting type %u\n&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;kernel error: missing required nesting type %u&quot;,</span><b=
r><span>             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));</s=
pan><br><span>     }</span><br><span> </span><br><span>     if (tb_msg[OVPN=
_NLMSGERR_ATTR_MISS_TYPE])</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;kernel error: missing=
 required attribute type %u\n&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_WARN, &quot;kernel error: missing required a=
ttribute type %u&quot;,</span><br><span>             nla_get_u32(tb_msg[OVP=
N_NLMSGERR_ATTR_MISS_TYPE]));</span><br><span>     }</span><br><span> </spa=
n><br><span>@@ -405,6 +405,11 @@</span><br><span>             nl_geterror(r=
et));</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* enable Extended ACK for detailed error re=
porting */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setsockop=
t(nl_socket_get_fd(dco-&gt;nl_sock), SOL_NETLINK, NETLINK_EXT_ACK,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+               &amp;ret, siz=
eof(ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     /* set close on exec and non-block on the netlink socket */</s=
pan><br><span>     set_cloexec(nl_socket_get_fd(dco-&gt;nl_sock));</span><b=
r><span>     set_nonblock(nl_socket_get_fd(dco-&gt;nl_sock));</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1040?usp=3Demail">change 1040</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/104=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef=
6c4bcbeae6ab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1040 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JqMILpvuN1g=--

