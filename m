From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 22 May 2025 21:08:28 +0000
In-Reply-To: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
References: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <240d6d0414d0fee54460b8572e30250197728cb3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bMiD7EyTuVs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: avoid
 bogus text when netlink message is not parsed
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

--bMiD7EyTuVs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: dco_linux: avoid bogus text when netlink message is not par=
sed
......................................................................

dco_linux: avoid bogus text when netlink message is not parsed

We may bail out parsing an incoming DCO message because it may
concern a different interface.
In that case we print the following debug messages:

    dco_do_read
    ovpn-dco: ignoring message (type=3D5) for foreign ifindex 313
    process_incoming_dco: received message of type 0 - ignoring

However, the last message is confusing, because there is no message
of type 0 being received, but the message_type was simply not
initialized.

Bail out parsing earlier and avoid printing any bogus text.

Change-Id: I568faa12a5960e8b69de23c2df413b70b231592c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/forward.c
1 file changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1027/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ed4cdb4..b90a88c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1251,6 +1251,12 @@

     dco_do_read(dco);

+    /* no message was parsed - bail out */
+    if (dco->dco_message_type =3D=3D 0)
+    {
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

--bMiD7EyTuVs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: avoid bogus text when netlink message is =
not parsed<br><br>We may bail out parsing an incoming DCO message because i=
t may<br>concern a different interface.<br>In that case we print the follow=
ing debug messages:<br><br>    dco_do_read<br>    ovpn-dco: ignoring messag=
e (type=3D5) for foreign ifindex 313<br>    process_incoming_dco: received =
message of type 0 - ignoring<br><br>However, the last message is confusing,=
 because there is no message<br>of type 0 being received, but the message_t=
ype was simply not<br>initialized.<br><br>Bail out parsing earlier and avoi=
d printing any bogus text.<br><br>Change-Id: I568faa12a5960e8b69de23c2df413=
b70b231592c<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<=
br>---<br>M src/openvpn/forward.c<br>1 file changed, 6 insertions(+), 0 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/27/1027/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/fo=
rward.c</span><br><span>index ed4cdb4..b90a88c 100644</span><br><span>--- a=
/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><b=
r><span>@@ -1251,6 +1251,12 @@</span><br><span> </span><br><span>     dco_d=
o_read(dco);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* no message was parsed - bail out */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;dco_message_type =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     /* FreeBSD currently sends u=
s removal notifcation with the old peer-id in</span><br><span>      * p2p m=
ode with the ping timeout reason, so ignore that one to not shoot</span><br=
><span>      * ourselves in the foot and removing the just established sess=
ion */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail">change 1027</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1027?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I568faa12a5960e8b69de23c2df4=
13b70b231592c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1027 </div>
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


--bMiD7EyTuVs=--

