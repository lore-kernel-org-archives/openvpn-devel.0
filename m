From: "ordex (Code Review)" <gerrit@...515...>
Date: Fri, 6 Jun 2025 12:28:21 +0000
References: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f24154270d2e262d6ff465c8399dac41d965dd31-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fsjmCOn4jNk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: enable
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

--fsjmCOn4jNk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail

to review the following change.


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
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1040/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 49dbdad..fcca9dc 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
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
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--fsjmCOn4jNk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: enable extended netlink error reporting<br><br>Th=
e ovpn netlink code reports more verbose error<br>strings to help userspace=
 understand what went wrong,<br>rather than just returning, for example, -E=
INVAL.<br><br>However, userspace must instruct the kernel netlink<br>subsys=
tem that it wants to receive such strings.<br><br>code for parsing such str=
ings has always been present<br>but it was never used.<br><br>Set the socke=
t option which enables such reporting.<br><br>Change-Id: I4457b1d7262e0a39c=
275d33aaef6c4bcbeae6ab3<br>Signed-off-by: Antonio Quartulli &lt;antonio@...493...=
2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, 5 insert=
ions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/40/1040/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c =
b/src/openvpn/dco_linux.c</span><br><span>index 49dbdad..fcca9dc 100644</sp=
an><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvp=
n/dco_linux.c</span><br><span>@@ -405,6 +405,11 @@</span><br><span>        =
     nl_geterror(ret));</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* enable Extended ACK for=
 detailed error reporting */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    setsockopt(nl_socket_get_fd(dco-&gt;nl_sock), SOL_NETLINK, NETLINK_=
EXT_ACK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
    &amp;ret, sizeof(ret));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     /* set close on exec and non-block on the net=
link socket */</span><br><span>     set_cloexec(nl_socket_get_fd(dco-&gt;nl=
_sock));</span><br><span>     set_nonblock(nl_socket_get_fd(dco-&gt;nl_sock=
));</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1040?usp=3Demail">change 1040</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1040?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef=
6c4bcbeae6ab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1040 </div>
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


--fsjmCOn4jNk=--

