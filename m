From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 9 Jun 2025 08:06:14 +0000
In-Reply-To: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
References: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <0b867f80cb9088739daedb6330099b6b1638c075-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c+W5o/olBuM="; charset=UTF-8
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

--c+W5o/olBuM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
---
M src/openvpn/dco_linux.c
1 file changed, 8 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1040/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-MessageType: newpatchset

--c+W5o/olBuM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: enable extended netlink error reporting<b=
r><br>The ovpn netlink code reports more verbose error<br>strings to help u=
serspace understand what went wrong,<br>rather than just returning, for exa=
mple, -EINVAL.<br><br>However, userspace must instruct the kernel netlink<b=
r>subsystem that it wants to receive such strings.<br><br>code for parsing =
such strings has always been present<br>but it was never used.<br><br>Set t=
he socket option which enables such reporting.<br><br>Change-Id: I4457b1d72=
62e0a39c275d33aaef6c4bcbeae6ab3<br>Signed-off-by: Antonio Quartulli &lt;ant=
onio@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, =
8 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/40/1040/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_=
linux.c b/src/openvpn/dco_linux.c</span><br><span>index 49dbdad..0345413 10=
0644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/sr=
c/openvpn/dco_linux.c</span><br><span>@@ -367,19 +367,19 @@</span><br><span=
>     {</span><br><span>         len =3D strnlen((char *)nla_data(tb_msg[NL=
MSGERR_ATTR_MSG]),</span><br><span>                       nla_len(tb_msg[NL=
MSGERR_ATTR_MSG]));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(M_WARN, &quot;kernel error: %*s\n&quot;, len,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;kernel error:=
 %*s&quot;, len,</span><br><span>             (char *)nla_data(tb_msg[NLMSG=
ERR_ATTR_MSG]));</span><br><span>     }</span><br><span> </span><br><span> =
    if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST])</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ke=
rnel error: missing required nesting type %u\n&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;kernel error: m=
issing required nesting type %u&quot;,</span><br><span>             nla_get=
_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));</span><br><span>     }</span><=
br><span> </span><br><span>     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_WARN, &quot;kernel error: missing required attribute type %u\=
n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;kernel error: missing required attribute type %u&quot;,</spa=
n><br><span>             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]))=
;</span><br><span>     }</span><br><span> </span><br><span>@@ -405,6 +405,1=
1 @@</span><br><span>             nl_geterror(ret));</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* enable Extended ACK for detailed error reporting */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret =3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    setsockopt(nl_socket_get_fd(dco-&gt;n=
l_sock), SOL_NETLINK, NETLINK_EXT_ACK,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+               &amp;ret, sizeof(ret));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* set close on=
 exec and non-block on the netlink socket */</span><br><span>     set_cloex=
ec(nl_socket_get_fd(dco-&gt;nl_sock));</span><br><span>     set_nonblock(nl=
_socket_get_fd(dco-&gt;nl_sock));</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail=
">change 1040</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef=
6c4bcbeae6ab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1040 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--c+W5o/olBuM=--

