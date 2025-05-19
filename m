From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 19 May 2025 10:36:41 +0000
References: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0e43fefba454f7feae249b8ba5947a2ec1f4c088-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ba/2mj0J9u0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: print
 meaningful text when netlink message is not parsed
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

--Ba/2mj0J9u0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail

to review the following change.


Change subject: dco_linux: print meaningful text when netlink message is no=
t parsed
......................................................................

dco_linux: print meaningful text when netlink message is not parsed

We may bail out parsing an incoming DCO message because it may
concern a different interface.
In that case we print the following debug messages:

    dco_do_read
    ovpn-dco: ignoring message (type=3D5) for foreign ifindex 313
    process_incoming_dco: received message of type 0 - ignoring

However, the last message is confusing, because there is no message
of type 0 being received, but the message_type was simply not
initialized.

Fix that by printing something more appropriate like:

    process_incoming_dco: received message was not parsed

Change-Id: I568faa12a5960e8b69de23c2df413b70b231592c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco_linux.c
M src/openvpn/forward.c
2 files changed, 12 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1027/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3f7965e..29722cb 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -903,6 +903,12 @@
 dco_do_read(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
+
+    /* set the message type to an invalid value so that we later know
+     * if a message was properly parsed or we bailed out earlier
+     */
+    dco->dco_message_type =3D -1;
+
     nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);

     return ovpn_nl_recvmsgs(dco, __func__);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ed4cdb4..39c74af 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1251,6 +1251,12 @@

     dco_do_read(dco);

+    if (dco->dco_message_type =3D=3D -1)
+    {
+        msg(D_DCO_DEBUG, "%s: received message was not parsed");
+        return;
+    }
+
     /* FreeBSD currently sends us removal notifcation with the old peer-id=
 in
      * p2p mode with the ping timeout reason, so ignore that one to not sh=
oot
      * ourselves in the foot and removing the just established session */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I568faa12a5960e8b69de23c2df413b70b231592c
Gerrit-Change-Number: 1027
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Ba/2mj0J9u0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: print meaningful text when netlink message is not=
 parsed<br><br>We may bail out parsing an incoming DCO message because it m=
ay<br>concern a different interface.<br>In that case we print the following=
 debug messages:<br><br>    dco_do_read<br>    ovpn-dco: ignoring message (=
type=3D5) for foreign ifindex 313<br>    process_incoming_dco: received mes=
sage of type 0 - ignoring<br><br>However, the last message is confusing, be=
cause there is no message<br>of type 0 being received, but the message_type=
 was simply not<br>initialized.<br><br>Fix that by printing something more =
appropriate like:<br><br>    process_incoming_dco: received message was not=
 parsed<br><br>Change-Id: I568faa12a5960e8b69de23c2df413b70b231592c<br>Sign=
ed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/ope=
nvpn/dco_linux.c<br>M src/openvpn/forward.c<br>2 files changed, 12 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/27/1027/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/=
src/openvpn/dco_linux.c</span><br><span>index 3f7965e..29722cb 100644</span=
><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/=
dco_linux.c</span><br><span>@@ -903,6 +903,12 @@</span><br><span> dco_do_re=
ad(dco_context_t *dco)</span><br><span> {</span><br><span>     msg(D_DCO_DE=
BUG, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set the message =
type to an invalid value so that we later know</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * if a message was properly parsed or we ba=
iled out earlier</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco=
_message_type =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM,=
 ovpn_handle_msg, dco);</span><br><span> </span><br><span>     return ovpn_=
nl_recvmsgs(dco, __func__);</span><br><span>diff --git a/src/openvpn/forwar=
d.c b/src/openvpn/forward.c</span><br><span>index ed4cdb4..39c74af 100644</=
span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvp=
n/forward.c</span><br><span>@@ -1251,6 +1251,12 @@</span><br><span> </span>=
<br><span>     dco_do_read(dco);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (dco-&gt;dco_message_type =3D=3D -1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s:=
 received message was not parsed&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     /* FreeBSD currently sends us removal notifcation =
with the old peer-id in</span><br><span>      * p2p mode with the ping time=
out reason, so ignore that one to not shoot</span><br><span>      * ourselv=
es in the foot and removing the just established session */</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1027?usp=3Demail">change 1027</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1027?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I568faa12a5960e8b69de23c2df4=
13b70b231592c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1027 </div>
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


--Ba/2mj0J9u0=--

