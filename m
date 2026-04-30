From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 12:47:53 +0000
References: <gerrit.1777553270000.Id6832e3f56420debc8b19d0144d53ca41abb678b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <64e364bfbe180d8e394b4739785972e6ed743e0b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QLUicTr3Y24="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QLUicTr3Y24=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1645?usp=3Demail

to review the following change.


Change subject: dns-scripts: Fix dnssec values in comments and Copyright st=
atement format
......................................................................

dns-scripts: Fix dnssec values in comments and Copyright statement format

- Fix the example value of dnssec to an actual valid one
- Fix the formatting of the Copyright statements to be
  consistent with all other files in the project

Change-Id: Id6832e3f56420debc8b19d0144d53ca41abb678b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
M distro/dns-scripts/macos-dns-updown.sh
M distro/dns-scripts/openresolv-dns-updown.sh
M distro/dns-scripts/resolvconf_file-dns-updown.sh
M distro/dns-scripts/systemd-dns-updown.sh
5 files changed, 10 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1645/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6832e3f56420debc8b19d0144d53ca41abb678b
Gerrit-Change-Number: 1645
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--QLUicTr3Y24=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1645?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dns-scripts: Fix dnssec values in comments =
and Copyright statement format<br><br>- Fix the example value of dnssec to =
an actual valid one<br>- Fix the formatting of the Copyright statements to =
be<br>  consistent with all other files in the project<br><br>Change-Id: Id=
6832e3f56420debc8b19d0144d53ca41abb678b<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M distro/dns-scripts/haikuos_file-dns-u=
pdown.sh<br>M distro/dns-scripts/macos-dns-updown.sh<br>M distro/dns-script=
s/openresolv-dns-updown.sh<br>M distro/dns-scripts/resolvconf_file-dns-updo=
wn.sh<br>M distro/dns-scripts/systemd-dns-updown.sh<br>5 files changed, 10 =
insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/45/1645/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_=
file-dns-updown.sh</span><br><span>index 6da0954..e19b2b7 100644</span><br>=
<span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>+=
++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>@@ -1,7 =
+1,7 @@</span><br><span> #!/bin/sh</span><br><span> #</span><br><span> # Si=
mple OpenVPN up/down script for modifying Haiku OS resolv.conf</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# (C) Copyright 2024 OpenVPN Inc &=
lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# Copyright (C) 2024-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><br>=
<span> #</span><br><span> # SPDX-License-Identifier: BSD-2-Clause</span><br=
><span> #</span><br><span>@@ -21,7 +21,7 @@</span><br><span> #   dns_server=
_1_port_2 53</span><br><span> #   dns_server_1_resolve_domain_1 mycorp.in</=
span><br><span> #   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_dnssec true</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec =
yes</span><br><span> #   dns_server_1_transport DoH</span><br><span> #   dn=
s_server_1_sni dns.mycorp.in</span><br><span> #</span><br><span>diff --git =
a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-upd=
own.sh</span><br><span>index fb17b2b0..fccc6b5 100644</span><br><span>--- a=
/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++ b/distro/dns-sc=
ripts/macos-dns-updown.sh</span><br><span>@@ -2,7 +2,7 @@</span><br><span> =
#</span><br><span> # dns-updown - add/remove openvpn provided DNS informati=
on</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# (C) Copyright 2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 2025-2026 OpenVPN Inc =
&lt;sales@...515...&gt;</span><br><span> #</span><br><span> # SPDX-License-=
Identifier: BSD-2-Clause</span><br><span> #</span><br><span>@@ -21,7 +21,7 =
@@</span><br><span> #   dns_server_1_port_2 53</span><br><span> #   dns_ser=
ver_1_resolve_domain_1 mycorp.in</span><br><span> #   dns_server_1_resolve_=
domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#   dns_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#   dns_server_1_dnssec yes</span><br><span> #   dns_server_1_tra=
nsport DoH</span><br><span> #   dns_server_1_sni dns.mycorp.in</span><br><s=
pan> #</span><br><span>diff --git a/distro/dns-scripts/openresolv-dns-updow=
n.sh b/distro/dns-scripts/openresolv-dns-updown.sh</span><br><span>index 14=
04819..4aca99f 100644</span><br><span>--- a/distro/dns-scripts/openresolv-d=
ns-updown.sh</span><br><span>+++ b/distro/dns-scripts/openresolv-dns-updown=
.sh</span><br><span>@@ -1,8 +1,8 @@</span><br><span> #!/bin/sh</span><br><s=
pan> #</span><br><span> # Simple OpenVPN up/down script for openresolv inte=
gration</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# (C) Copyrigh=
t 2016 Baptiste Daroussin</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#               2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 2016 Baptiste Daro=
ussin</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C=
) 2024-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span> #</span><b=
r><span> # SPDX-License-Identifier: BSD-2-Clause</span><br><span> #</span><=
br><span>@@ -22,7 +22,7 @@</span><br><span> #   dns_server_1_port_2 53</spa=
n><br><span> #   dns_server_1_resolve_domain_1 mycorp.in</span><br><span> #=
   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#   dns_server_1_dnssec true</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec yes</span><br><sp=
an> #   dns_server_1_transport DoH</span><br><span> #   dns_server_1_sni dn=
s.mycorp.in</span><br><span> #</span><br><span>diff --git a/distro/dns-scri=
pts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-=
updown.sh</span><br><span>index 70872c7..8d23ed6 100644</span><br><span>---=
 a/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><span>+++ b/d=
istro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><span>@@ -1,7 +1,=
7 @@</span><br><span> #!/bin/sh</span><br><span> #</span><br><span> # Simpl=
e OpenVPN up/down script for modifying /etc/resolv.conf</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# (C) Copyright 2024 OpenVPN Inc &lt;sale=
s@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Co=
pyright (C) 2024-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span> =
#</span><br><span> # SPDX-License-Identifier: BSD-2-Clause</span><br><span>=
 #</span><br><span>@@ -21,7 +21,7 @@</span><br><span> #   dns_server_1_port=
_2 53</span><br><span> #   dns_server_1_resolve_domain_1 mycorp.in</span><b=
r><span> #   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_dnssec true</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec yes</sp=
an><br><span> #   dns_server_1_transport DoH</span><br><span> #   dns_serve=
r_1_sni dns.mycorp.in</span><br><span> #</span><br><span>diff --git a/distr=
o/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown=
.sh</span><br><span>index f91cde6..553056b 100644</span><br><span>--- a/dis=
tro/dns-scripts/systemd-dns-updown.sh</span><br><span>+++ b/distro/dns-scri=
pts/systemd-dns-updown.sh</span><br><span>@@ -29,7 +29,7 @@</span><br><span=
> #   dns_server_1_port_2 53</span><br><span> #   dns_server_1_resolve_doma=
in_1 mycorp.in</span><br><span> #   dns_server_1_resolve_domain_2 eu.mycorp=
.com</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   dns_server_1_=
dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_=
server_1_dnssec yes</span><br><span> #   dns_server_1_transport DoH</span><=
br><span> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1645?usp=3Demail">change 1645</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1645?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6832e3f56420debc8b19d0144d=
53ca41abb678b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1645 </div>
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

--QLUicTr3Y24=--

