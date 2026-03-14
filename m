From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 14 Mar 2026 10:50:05 +0000
In-Reply-To: <gerrit.1771343792000.Ic877f9a9c6459c6eb97cde1099f47f0b196b8084@...2715...>
References: <gerrit.1771343792000.Ic877f9a9c6459c6eb97cde1099f47f0b196b8084@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6ecc032f767ac8af89e3ff6cc42dac00dcf0f2b5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yx4qlQCXaRM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: systemd: Change
 LimitNPROC to TasksMax and increase limit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Yx4qlQCXaRM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: systemd: Change LimitNPROC to TasksMax and increase limit
......................................................................

systemd: Change LimitNPROC to TasksMax and increase limit

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

Also increase the limit. When using e.g.
resolvconf for DNS configuration the limit
can be exhausted just due to the amount of
nested shell scripts.

Github: Fixes OpenVPN/openvpn#929
Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1539
Message-Id: <20260313223833.3813-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
123.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/systemd/openvpn-client@...2221...
M distro/systemd/openvpn-server@...2221...
2 files changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1539/3

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/open=
vpn-client@...2221...
index 326bb73..340603e 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -12,7 +12,7 @@
 WorkingDirectory=3D/etc/openvpn/client
 ExecStart=3D@...2235...@/openvpn --suppress-timestamps --nobind --config %i.c=
onf
 CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID =
CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_SYS_NICE
-LimitNPROC=3D10
+TasksMax=3D20
 DeviceAllow=3D/dev/null rw
 DeviceAllow=3D/dev/net/tun rw
 ProtectSystem=3Dtrue
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/open=
vpn-server@...2221...
index d43bce1..3462f33 100644
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
+TasksMax=3D20
 DeviceAllow=3D/dev/null rw
 DeviceAllow=3D/dev/net/tun rw
 ProtectSystem=3Dtrue

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084
Gerrit-Change-Number: 1539
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Yx4qlQCXaRM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1539?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">systemd: Change LimitNPROC to Tasks=
Max and increase limit<br><br>There were some complaints about valid setups=
<br>that ran into problems with LimitNPROC. This<br>is especially true sinc=
e LimitNPROC limits<br>the total amounts of threads running for the<br>same=
 uid, so if multiple openvpn services run<br>under the same user, they will=
 compete for<br>resources. As suggested in the systemd<br>documentation cha=
nge this to TasksMax which<br>really counts the threads running in one<br>s=
pecific service.<br><br>Also increase the limit. When using e.g.<br>resolvc=
onf for DNS configuration the limit<br>can be exhausted just due to the amo=
unt of<br>nested shell scripts.<br><br>Github: Fixes OpenVPN/openvpn#929<br=
>Change-Id: Ic877f9a9c6459c6eb97cde1099f47f0b196b8084<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1539<b=
r>Message-Id: &lt;20260313223833.3813-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36123.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M distro/syst=
emd/openvpn-client@...2221...<br>M distro/systemd/openvpn-server@...2221...=
<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1539/3=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/distro/systemd/openvpn-client@...2221... b/distro/sys=
temd/openvpn-client@...2221...</span><br><span>index 326bb73..340603e 10064=
4</span><br><span>--- a/distro/systemd/openvpn-client@...2221...</span><br>=
<span>+++ b/distro/systemd/openvpn-client@...2221...</span><br><span>@@ -12=
,7 +12,7 @@</span><br><span> WorkingDirectory=3D/etc/openvpn/client</span><=
br><span> ExecStart=3D@...2235...@/openvpn --suppress-timestamps --nobind --co=
nfig %i.conf</span><br><span> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_=
ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_=
OVERRIDE CAP_SYS_NICE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
LimitNPROC=3D10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Task=
sMax=3D20</span><br><span> DeviceAllow=3D/dev/null rw</span><br><span> Devi=
ceAllow=3D/dev/net/tun rw</span><br><span> ProtectSystem=3Dtrue</span><br><=
span>diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd=
/openvpn-server@...2221...</span><br><span>index d43bce1..3462f33 100644</s=
pan><br><span>--- a/distro/systemd/openvpn-server@...2221...</span><br><spa=
n>+++ b/distro/systemd/openvpn-server@...2221...</span><br><span>@@ -12,7 +=
12,7 @@</span><br><span> WorkingDirectory=3D/etc/openvpn/server</span><br><=
span> ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.lo=
g --status-version 2 --suppress-timestamps --config %i.conf</span><br><span=
> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE C=
AP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRID=
E CAP_SYS_NICE CAP_AUDIT_WRITE</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-LimitNPROC=3D10</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+TasksMax=3D20</span><br><span> DeviceAllow=3D/dev/null rw</span><br><s=
pan> DeviceAllow=3D/dev/net/tun rw</span><br><span> ProtectSystem=3Dtrue</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1539?usp=3Demail">change 1539</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1539?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic877f9a9c6459c6eb97cde1099f=
47f0b196b8084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1539 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Yx4qlQCXaRM=--

