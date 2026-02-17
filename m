From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 17 Feb 2026 15:56:35 +0000
References: <gerrit.1771343792000.Ic877f9a9c6459c6eb97cde1099f47f0b196b8084@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <adee93d24718b6a91f676c94dfbcf45a7d8bb53a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XVjNAVoVTf4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: systemd: Change
 LimitNPROC to TasksMax
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

--XVjNAVoVTf4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail

to review the following change.


Change subject: systemd: Change LimitNPROC to TasksMax
......................................................................

systemd: Change LimitNPROC to TasksMax

There were some complaints about valid setups
that ran into problems with LimitNPROC. This
is especially true since LimitNPROC limits
the total amounts of threads running for the
same uid, so if multiple openvpn services run
under the same user, they will compete for
resources. As suggested in the systemd
documentation change this to TasksMax which
really counts the threads running in one
specific service.

Github: Fixes #929
Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M distro/systemd/openvpn-client@...2221...
M distro/systemd/openvpn-server@...2221...
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1539/1

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/open=
vpn-client@...2221...
index 326bb73..e311978 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -12,7 +12,7 @@
 WorkingDirectory=3D/etc/openvpn/client
 ExecStart=3D@...2235...@/openvpn --suppress-timestamps --nobind --config %i.c=
onf
 CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID =
CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_SYS_NICE
-LimitNPROC=3D10
+TasksMax=3D10
 DeviceAllow=3D/dev/null rw
 DeviceAllow=3D/dev/net/tun rw
 ProtectSystem=3Dtrue
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/open=
vpn-server@...2221...
index d43bce1..e3e9895 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -12,7 +12,7 @@
 WorkingDirectory=3D/etc/openvpn/server
 ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log --s=
tatus-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CA=
P_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE=
 CAP_SYS_NICE CAP_AUDIT_WRITE
-LimitNPROC=3D10
+TasksMax=3D10
 DeviceAllow=3D/dev/null rw
 DeviceAllow=3D/dev/net/tun rw
 ProtectSystem=3Dtrue

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084
Gerrit-Change-Number: 1539
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XVjNAVoVTf4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">systemd: Change LimitNPROC to TasksMax<br><=
br>There were some complaints about valid setups<br>that ran into problems =
with LimitNPROC. This<br>is especially true since LimitNPROC limits<br>the =
total amounts of threads running for the<br>same uid, so if multiple openvp=
n services run<br>under the same user, they will compete for<br>resources. =
As suggested in the systemd<br>documentation change this to TasksMax which<=
br>really counts the threads running in one<br>specific service.<br><br>Git=
hub: Fixes #929<br>Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M distr=
o/systemd/openvpn-client@...2221...<br>M distro/systemd/openvpn-server@...1665...=
221...<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/=
1539/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/distro/systemd/openvpn-client@...2221... b/dist=
ro/systemd/openvpn-client@...2221...</span><br><span>index 326bb73..e311978=
 100644</span><br><span>--- a/distro/systemd/openvpn-client@...2221...</spa=
n><br><span>+++ b/distro/systemd/openvpn-client@...2221...</span><br><span>=
@@ -12,7 +12,7 @@</span><br><span> WorkingDirectory=3D/etc/openvpn/client</=
span><br><span> ExecStart=3D@...2235...@/openvpn --suppress-timestamps --nobin=
d --config %i.conf</span><br><span> CapabilityBoundingSet=3DCAP_IPC_LOCK CA=
P_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CA=
P_DAC_OVERRIDE CAP_SYS_NICE</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-LimitNPROC=3D10</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+TasksMax=3D10</span><br><span> DeviceAllow=3D/dev/null rw</span><br><span=
> DeviceAllow=3D/dev/net/tun rw</span><br><span> ProtectSystem=3Dtrue</span=
><br><span>diff --git a/distro/systemd/openvpn-server@...2221... b/distro/s=
ystemd/openvpn-server@...2221...</span><br><span>index d43bce1..e3e9895 100=
644</span><br><span>--- a/distro/systemd/openvpn-server@...2221...</span><b=
r><span>+++ b/distro/systemd/openvpn-server@...2221...</span><br><span>@@ -=
12,7 +12,7 @@</span><br><span> WorkingDirectory=3D/etc/openvpn/server</span=
><br><span> ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status=
-%i.log --status-version 2 --suppress-timestamps --config %i.conf</span><br=
><span> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SER=
VICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_O=
VERRIDE CAP_SYS_NICE CAP_AUDIT_WRITE</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-LimitNPROC=3D10</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+TasksMax=3D10</span><br><span> DeviceAllow=3D/dev/null rw</span>=
<br><span> DeviceAllow=3D/dev/net/tun rw</span><br><span> ProtectSystem=3Dt=
rue</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1539?usp=3Demail">change 1539</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1539?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic877f9a9c6459c6eb97cde1099f=
47f0b196b8084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1539 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--XVjNAVoVTf4=--

