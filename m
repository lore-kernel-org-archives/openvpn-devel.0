From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 23 May 2025 07:55:40 +0000
In-Reply-To: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
References: <gerrit.1747650999000.I568faa12a5960e8b69de23c2df413b70b231592c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <a61788b5a85f974f8347bbf252192b0d8733aa2d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mQa23kJpaTE="; charset=UTF-8
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

--mQa23kJpaTE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1027?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250523073848.20848-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
763.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1027/4

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 022afdb..a83b258 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1251,6 +1251,12 @@

     dco_do_read(dco);

+    /* no message for us to handle - platform specific code has logged det=
ails */
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
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--mQa23kJpaTE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1027=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
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
br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202505=
23073848.20848-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg31763.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forward.c<br>1 file ch=
anged, 6 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/27/1027/4</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/forward.c b/src/openvpn/forward.c</span><br><span>index 022afdb..a83b258=
 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/s=
rc/openvpn/forward.c</span><br><span>@@ -1251,6 +1251,12 @@</span><br><span=
> </span><br><span>     dco_do_read(dco);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* no message for us to handle =
- platform specific code has logged details */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (dco-&gt;dco_message_type =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /* FreeBSD currently sends us rem=
oval notifcation with the old peer-id in</span><br><span>      * p2p mode w=
ith the ping timeout reason, so ignore that one to not shoot</span><br><spa=
n>      * ourselves in the foot and removing the just established session *=
/</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1027?usp=3Demail">change 1027</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1027?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I568faa12a5960e8b69de23c2df4=
13b70b231592c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1027 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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


--mQa23kJpaTE=--

