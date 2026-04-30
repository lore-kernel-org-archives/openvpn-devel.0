From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 13:23:45 +0000
In-Reply-To: <gerrit.1777553270000.Id6832e3f56420debc8b19d0144d53ca41abb678b@...2715...>
References: <gerrit.1777553270000.Id6832e3f56420debc8b19d0144d53ca41abb678b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a842e865bdec4f9356e11a43ec7bf21d90a0b24b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wM8YQa46ZuI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns-scripts: Fix
 dnssec values in comments and Copyright statement fo...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wM8YQa46ZuI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
45?usp=3Demail )

Change subject: dns-scripts: Fix dnssec values in comments and Copyright st=
atement format
......................................................................

dns-scripts: Fix dnssec values in comments and Copyright statement format

- Fix the example value of dnssec to an actual valid one
- Fix the formatting of the Copyright statements to be
  consistent with all other files in the project

Change-Id: Id6832e3f56420debc8b19d0144d53ca41abb678b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1645
Message-Id: <20260430130354.25337-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
800.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
M distro/dns-scripts/macos-dns-updown.sh
M distro/dns-scripts/openresolv-dns-updown.sh
M distro/dns-scripts/resolvconf_file-dns-updown.sh
M distro/dns-scripts/systemd-dns-updown.sh
5 files changed, 10 insertions(+), 10 deletions(-)




diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index 6da0954..e19b2b7 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for modifying Haiku OS resolv.conf
-# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index fb17b2b0..fccc6b5 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -2,7 +2,7 @@
 #
 # dns-updown - add/remove openvpn provided DNS information
 #
-# (C) Copyright 2025 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2025-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scrip=
ts/openresolv-dns-updown.sh
index 1404819..4aca99f 100644
--- a/distro/dns-scripts/openresolv-dns-updown.sh
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for openresolv integration
-# (C) Copyright 2016 Baptiste Daroussin
-#               2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016 Baptiste Daroussin
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -22,7 +22,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-=
scripts/resolvconf_file-dns-updown.sh
index 70872c7..8d23ed6 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for modifying /etc/resolv.conf
-# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
index f91cde6..553056b 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -29,7 +29,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1645?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6832e3f56420debc8b19d0144d53ca41abb678b
Gerrit-Change-Number: 1645
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wM8YQa46ZuI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1645?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dns-scripts: Fix dnssec values in comments and C=
opyright statement format<br><br>- Fix the example value of dnssec to an ac=
tual valid one<br>- Fix the formatting of the Copyright statements to be<br=
>  consistent with all other files in the project<br><br>Change-Id: Id6832e=
3f56420debc8b19d0144d53ca41abb678b<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1645<br>Message-Id: &lt;2=
0260430130354.25337-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg36800.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M distro/dns-scripts/haikuos_fi=
le-dns-updown.sh<br>M distro/dns-scripts/macos-dns-updown.sh<br>M distro/dn=
s-scripts/openresolv-dns-updown.sh<br>M distro/dns-scripts/resolvconf_file-=
dns-updown.sh<br>M distro/dns-scripts/systemd-dns-updown.sh<br>5 files chan=
ged, 10 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-=
scripts/haikuos_file-dns-updown.sh</span><br><span>index 6da0954..e19b2b7 1=
00644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</=
span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><b=
r><span>@@ -1,7 +1,7 @@</span><br><span> #!/bin/sh</span><br><span> #</span=
><br><span> # Simple OpenVPN up/down script for modifying Haiku OS resolv.c=
onf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# (C) Copyright 20=
24 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# Copyright (C) 2024-2026 OpenVPN Inc &lt;sales@...1699...=
.&gt;</span><br><span> #</span><br><span> # SPDX-License-Identifier: BSD-2-=
Clause</span><br><span> #</span><br><span>@@ -21,7 +21,7 @@</span><br><span=
> #   dns_server_1_port_2 53</span><br><span> #   dns_server_1_resolve_doma=
in_1 mycorp.in</span><br><span> #   dns_server_1_resolve_domain_2 eu.mycorp=
.com</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_=
dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_=
server_1_dnssec yes</span><br><span> #   dns_server_1_transport DoH</span><=
br><span> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</span><br><=
span>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scrip=
ts/macos-dns-updown.sh</span><br><span>index fb17b2b0..fccc6b5 100644</span=
><br><span>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++=
 b/distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -2,7 +2,7 @@</=
span><br><span> #</span><br><span> # dns-updown - add/remove openvpn provid=
ed DNS information</span><br><span> #</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# (C) Copyright 2025 OpenVPN Inc &lt;sales@...515...&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 2025-2=
026 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span> #</span><br><span>=
 # SPDX-License-Identifier: BSD-2-Clause</span><br><span> #</span><br><span=
>@@ -21,7 +21,7 @@</span><br><span> #   dns_server_1_port_2 53</span><br><s=
pan> #   dns_server_1_resolve_domain_1 mycorp.in</span><br><span> #   dns_s=
erver_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#   dns_server_1_dnssec true</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec yes</span><br><span> #   =
dns_server_1_transport DoH</span><br><span> #   dns_server_1_sni dns.mycorp=
.in</span><br><span> #</span><br><span>diff --git a/distro/dns-scripts/open=
resolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.sh</span><b=
r><span>index 1404819..4aca99f 100644</span><br><span>--- a/distro/dns-scri=
pts/openresolv-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/openr=
esolv-dns-updown.sh</span><br><span>@@ -1,8 +1,8 @@</span><br><span> #!/bin=
/sh</span><br><span> #</span><br><span> # Simple OpenVPN up/down script for=
 openresolv integration</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# (C) Copyright 2016 Baptiste Daroussin</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#               2024 OpenVPN Inc &lt;sales@...515...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 20=
16 Baptiste Daroussin</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Copyright (C) 2024-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><br><=
span> #</span><br><span> # SPDX-License-Identifier: BSD-2-Clause</span><br>=
<span> #</span><br><span>@@ -22,7 +22,7 @@</span><br><span> #   dns_server_=
1_port_2 53</span><br><span> #   dns_server_1_resolve_domain_1 mycorp.in</s=
pan><br><span> #   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_dnssec true</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec y=
es</span><br><span> #   dns_server_1_transport DoH</span><br><span> #   dns=
_server_1_sni dns.mycorp.in</span><br><span> #</span><br><span>diff --git a=
/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/reso=
lvconf_file-dns-updown.sh</span><br><span>index 70872c7..8d23ed6 100644</sp=
an><br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><=
br><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><=
span>@@ -1,7 +1,7 @@</span><br><span> #!/bin/sh</span><br><span> #</span><b=
r><span> # Simple OpenVPN up/down script for modifying /etc/resolv.conf</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# (C) Copyright 2024 Open=
VPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Copyright (C) 2024-2026 OpenVPN Inc &lt;sales@...515...&gt;</=
span><br><span> #</span><br><span> # SPDX-License-Identifier: BSD-2-Clause<=
/span><br><span> #</span><br><span>@@ -21,7 +21,7 @@</span><br><span> #   d=
ns_server_1_port_2 53</span><br><span> #   dns_server_1_resolve_domain_1 my=
corp.in</span><br><span> #   dns_server_1_resolve_domain_2 eu.mycorp.com</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_dnssec =
true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_=
1_dnssec yes</span><br><span> #   dns_server_1_transport DoH</span><br><spa=
n> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</span><br><span>di=
ff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/sy=
stemd-dns-updown.sh</span><br><span>index f91cde6..553056b 100644</span><br=
><span>--- a/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>+++ b=
/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>@@ -29,7 +29,7 @@=
</span><br><span> #   dns_server_1_port_2 53</span><br><span> #   dns_serve=
r_1_resolve_domain_1 mycorp.in</span><br><span> #   dns_server_1_resolve_do=
main_2 eu.mycorp.com</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
   dns_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dns_server_1_dnssec yes</span><br><span> #   dns_server_1_trans=
port DoH</span><br><span> #   dns_server_1_sni dns.mycorp.in</span><br><spa=
n> #</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1645?usp=3Demail">change 1645</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1645?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6832e3f56420debc8b19d0144d=
53ca41abb678b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1645 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--wM8YQa46ZuI=--

