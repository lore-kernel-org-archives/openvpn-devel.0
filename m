From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 28 May 2025 19:19:51 +0000
In-Reply-To: <gerrit.1748444191000.Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5@...2715...>
References: <gerrit.1748444191000.Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8ad319a84cecb38242fd16fb51be276401b50154-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="frrEHIVxxpI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove
 contrib/pull-resolv-conf
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

--frrEHIVxxpI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1034?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Remove contrib/pull-resolv-conf
......................................................................

Remove contrib/pull-resolv-conf

We have an official solution for this now.

Change-Id: Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250528191126.25707-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
820.html
Signed-off-by: Gert Doering <gert@...1296...>
---
D contrib/pull-resolv-conf/client.down
D contrib/pull-resolv-conf/client.up
2 files changed, 0 insertions(+), 155 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1034/2

diff --git a/contrib/pull-resolv-conf/client.down b/contrib/pull-resolv-con=
f/client.down
deleted file mode 100644
index 0cbb476..0000000
--- a/contrib/pull-resolv-conf/client.down
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2005-2018 OpenVPN Inc
-# Licensed under the GPL version 2
-
-# First version by Jesse Adelman
-# someone at boldandbusted dink com
-# http://www.boldandbusted.com/
-
-# PURPOSE: This script automatically removes the /etc/resolv.conf entries =
previously
-# set by the companion script "client.up".
-
-# INSTALL NOTES:
-# Place this in /etc/openvpn/client.down
-# Then, add the following to your /etc/openvpn/<clientconfig>.conf:
-#   client
-#   up /etc/openvpn/client.up
-#   down /etc/openvpn/client.down
-# Next, "chmod a+x /etc/openvpn/client.down"
-
-# USAGE NOTES:
-# Note that this script is best served with the companion "client.up"
-# script.
-
-# Tested under Debian lenny with OpenVPN 2.1_rc11
-# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolv=
conf
-
-# This runs with the context of the OpenVPN UID/GID
-# at the time of execution. This generally means that
-# the client "up" script will run fine, but the "down" script
-# will require the use of the OpenVPN "down-root" plugin
-# which is in the plugins/ directory of the OpenVPN source tree
-# The config example above would have to be changed to:
-#   client
-#   up /etc/openvpn/client.up
-#   plugin openvpn-plugin-down-root.so "/etc/openvpn/client.down"
-
-# A horrid work around, from a security perspective,
-# is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
-# been WARNED.
-PATH=3D/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
-
-if type resolvconf >/dev/null 2>&1; then
-  resolvconf -d "${dev}" -f
-elif [ -e /etc/resolv.conf.ovpnsave ] ; then
-  # cp + rm rather than mv in case it's a symlink
-  cp /etc/resolv.conf.ovpnsave /etc/resolv.conf
-  rm -f /etc/resolv.conf.ovpnsave
-fi
-
-exit 0
diff --git a/contrib/pull-resolv-conf/client.up b/contrib/pull-resolv-conf/=
client.up
deleted file mode 100644
index 220aeb7..0000000
--- a/contrib/pull-resolv-conf/client.up
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2005-2018 OpenVPN Inc
-# Licensed under the GPL version 2
-
-# First version by Jesse Adelman
-# someone at boldandbusted dink com
-# http://www.boldandbusted.com/
-
-# PURPOSE: This script automatically sets the proper /etc/resolv.conf entr=
ies
-# as pulled down from an OpenVPN server.
-
-# INSTALL NOTES:
-# Place this in /etc/openvpn/client.up
-# Then, add the following to your /etc/openvpn/<clientconfig>.conf:
-#   client
-#   up /etc/openvpn/client.up
-# Next, "chmod a+x /etc/openvpn/client.up"
-
-# USAGE NOTES:
-# Note that this script is best served with the companion "client.down"
-# script.
-
-# Tested under Debian lenny with OpenVPN 2.1_rc11
-# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolv=
conf
-
-# This runs with the context of the OpenVPN UID/GID
-# at the time of execution. This generally means that
-# the client "up" script will run fine, but the "down" script
-# will require the use of the OpenVPN "down-root" plugin
-# which is in the plugins/ directory of the OpenVPN source tree
-
-# A horrid work around, from a security perspective,
-# is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
-# been WARNED.
-PATH=3D/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
-
-# init variables
-
-i=3D1
-domains=3D
-fopt=3D
-ndoms=3D0
-nns=3D0
-nl=3D'
-'
-
-# $foreign_option_<n> is something like
-# "dhcp-option DOMAIN example.com" (multiple allowed)
-# or
-# "dhcp-option DNS 10.10.10.10" (multiple allowed)
-
-# each DNS option becomes a "nameserver" option in resolv.conf
-# if we get one DOMAIN, that becomes "domain" in resolv.conf
-# if we get multiple DOMAINS, those become "search" lines in resolv.conf
-# if we get no DOMAINS, then don't use either domain or search.
-
-while true; do
-  eval fopt=3D\$foreign_option_${i}
-  [ -z "${fopt}" ] && break
-
-  case ${fopt} in
-		dhcp-option\ DOMAIN\ *)
-           ndoms=3D$((ndoms + 1))
-           domains=3D"${domains} ${fopt#dhcp-option DOMAIN }"
-           ;;
-		dhcp-option\ DNS\ *)
-           nns=3D$((nns + 1))
-           if [ $nns -le 3 ]; then
-             dns=3D"${dns}${dns:+$nl}nameserver ${fopt#dhcp-option DNS }"
-           else
-             printf "%s\n" "Too many nameservers - ignoring after third" >=
&2
-           fi
-           ;;
-        *)
-           printf "%s\n" "Unknown option \"${fopt}\" - ignored" >&2
-           ;;
-	esac
-  i=3D$((i + 1))
-done
-
-ds=3D""
-if [ $ndoms -eq 1 ]; then
-  ds=3D"${nl}domain"
-elif [ $ndoms -gt 1 ]; then
-  ds=3D"${nl}search"
-fi
-
-# This is the complete file - "$domains" has a leading space already
-out=3D"# resolv.conf autogenerated by ${0} (${dev})${nl}${dns}${ds}${domai=
ns}"
-
-# use resolvconf if it's available
-if type resolvconf >/dev/null 2>&1; then
-  printf "%s\n" "${out}" | resolvconf -a "${dev}"
-else
-  # Preserve the existing resolv.conf
-  if [ -e /etc/resolv.conf ] ; then
-    cp /etc/resolv.conf /etc/resolv.conf.ovpnsave
-  fi
-  printf "%s\n" "${out}" > /etc/resolv.conf
-  chmod 644 /etc/resolv.conf
-fi
-
-exit 0

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1034?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5
Gerrit-Change-Number: 1034
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--frrEHIVxxpI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1034?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove contrib/pull-resolv-conf<br><br>We have an of=
ficial solution for this now.<br><br>Change-Id: Ic30f8514b50f561e7ea8f1ce12=
d740ac53f202e5<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250=
528191126.25707-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg31820.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>D contrib/pull-resolv-conf/client.d=
own<br>D contrib/pull-resolv-conf/client.up<br>2 files changed, 0 insertion=
s(+), 155 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/34/1034/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/contrib/pull-resolv-conf/=
client.down b/contrib/pull-resolv-conf/client.down</span><br><span>deleted =
file mode 100644</span><br><span>index 0cbb476..0000000</span><br><span>---=
 a/contrib/pull-resolv-conf/client.down</span><br><span>+++ /dev/null</span=
><br><span>@@ -1,51 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (c) 2005-2018 O=
penVPN Inc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Licensed =
under the GPL version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# First version by =
Jesse Adelman</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# someon=
e at boldandbusted dink com</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# http://www.boldandbusted.com/</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# PUR=
POSE: This script automatically removes the /etc/resolv.conf entries previo=
usly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# set by the comp=
anion script &quot;client.up&quot;.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# INSTA=
LL NOTES:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Place this=
 in /etc/openvpn/client.down</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# Then, add the following to your /etc/openvpn/&lt;clientconfig&gt;.=
conf:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   client</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#   up /etc/openvpn/client.=
up</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   down /etc/openv=
pn/client.down</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Next,=
 &quot;chmod a+x /etc/openvpn/client.down&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# USAGE NOTES:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
Note that this script is best served with the companion &quot;client.up&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# script.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# Tested under Debian lenny with OpenVPN 2.1_rc11</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# It should work with an=
y UNIX with a POSIX sh, /etc/resolv.conf or resolvconf</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# This runs with the context of the OpenVPN UID/GID </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# at the time of execution. This=
 generally means that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# the client &quot;up&quot; script will run fine, but the &quot;down&quot; =
script</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# will require =
the use of the OpenVPN &quot;down-root&quot; plugin</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# which is in the plugins/ directory of the=
 OpenVPN source tree</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 The config example above would have to be changed to:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#   client</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#   up /etc/openvpn/client.up</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#   plugin openvpn-plugin-down-root.so &quo=
t;/etc/openvpn/client.down&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# A horrid=
 work around, from a security perspective,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# is to run OpenVPN as root. THIS IS NOT RECOMMENDED. =
You have</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# been WARNED=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-PATH=3D/bin:/usr/bin=
:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-if type resolvconf &gt;/dev/null 2&gt;&amp;1; then</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  resolvconf -d &quot;${dev}&quot; -f</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ -e /etc/resolv.con=
f.ovpnsave ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
# cp + rm rather than mv in case it&#39;s a symlink</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  cp /etc/resolv.conf.ovpnsave /etc/resolv.=
conf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  rm -f /etc/reso=
lv.conf.ovpnsave</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-exit 0</span><br><span>diff --git a/contrib=
/pull-resolv-conf/client.up b/contrib/pull-resolv-conf/client.up</span><br>=
<span>deleted file mode 100644</span><br><span>index 220aeb7..0000000</span=
><br><span>--- a/contrib/pull-resolv-conf/client.up</span><br><span>+++ /de=
v/null</span><br><span>@@ -1,104 +0,0 @@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (c=
) 2005-2018 OpenVPN Inc</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# Licensed under the GPL version 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Firs=
t version by Jesse Adelman</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# someone at boldandbusted dink com</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# http://www.boldandbusted.com/</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# PURPOSE: This script automatically sets the proper /etc/resolv.co=
nf entries</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# as pulled=
 down from an OpenVPN server.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# INSTALL NOT=
ES:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Place this in /e=
tc/openvpn/client.up</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 Then, add the following to your /etc/openvpn/&lt;clientconfig&gt;.conf:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#   client</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#   up /etc/openvpn/client.up</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# Next, &quot;chmod a+x /et=
c/openvpn/client.up&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# USAGE NOTES:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# Note that this script =
is best served with the companion &quot;client.down&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# script.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# Tested under Debian lenny with OpenVPN 2.1_rc11</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# It should work with any UNIX with a POSIX=
 sh, /etc/resolv.conf or resolvconf</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This =
runs with the context of the OpenVPN UID/GID </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# at the time of execution. This generally means th=
at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# the client &quot;=
up&quot; script will run fine, but the &quot;down&quot; script</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# will require the use of the Open=
VPN &quot;down-root&quot; plugin</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# which is in the plugins/ directory of the OpenVPN source tree<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# A horrid work around, from a security per=
spective,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# is to run =
OpenVPN as root. THIS IS NOT RECOMMENDED. You have</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# been WARNED.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-PATH=3D/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/=
usr/local/sbin</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# init variables</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-i=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-domains=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fopt=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ndoms=3D0</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-nns=3D0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-nl=3D&#39;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# $foreign_optio=
n_&lt;n&gt; is something like</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# &quot;dhcp-option DOMAIN example.com&quot; (multiple allowed)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# or</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# &quot;dhcp-option DNS 10.10.10.10&quot; =
(multiple allowed)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# each DNS option become=
s a &quot;nameserver&quot; option in resolv.conf</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# if we get one DOMAIN, that becomes &quot;domai=
n&quot; in resolv.conf</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# if we get multiple DOMAINS, those become &quot;search&quot; lines in res=
olv.conf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# if we get n=
o DOMAINS, then don&#39;t use either domain or search.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-while true; do</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  eval fopt=3D\$foreign_option_${i}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  [ -z &quot;${fopt}&quot; ] &amp;&amp; break</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  case ${fopt} in</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-		dhcp-option\ DOMAIN\ *)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-           ndoms=3D$((ndoms + 1))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-           domains=3D&quot;${domains} ${f=
opt#dhcp-option DOMAIN }&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-           ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-		dhcp-option\ DNS\ *)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-           nns=3D$((nns + 1))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           if [ $nns -le 3 ]; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-             dns=3D&quot;${dns}${dns:+$nl}nameserver=
 ${fopt#dhcp-option DNS }&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             printf &quot;%s\n&quot; &quot;Too many nameservers - ignor=
ing after third&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-           fi</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-           ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   *)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           print=
f &quot;%s\n&quot; &quot;Unknown option \&quot;${fopt}\&quot; - ignored&quo=
t; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	esac</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  i=3D$((i + 1))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-done</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ds=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [=
 $ndoms -eq 1 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  ds=3D&quot;${nl}domain&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-elif [ $ndoms -gt 1 ]; then</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  ds=3D&quot;${nl}search&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This is the co=
mplete file - &quot;$domains&quot; has a leading space already</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-out=3D&quot;# resolv.conf autogene=
rated by ${0} (${dev})${nl}${dns}${ds}${domains}&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# use resolvconf if it&#39;s available</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-if type resolvconf &gt;/dev/null 2&gt;&amp;1; =
then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  printf &quot;%s=
\n&quot; &quot;${out}&quot; | resolvconf -a &quot;${dev}&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  # Preserve the existing resolv.conf</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  if [ -e /etc/resolv.conf ] ; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cp /etc/resolv.co=
nf /etc/resolv.conf.ovpnsave</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  printf &=
quot;%s\n&quot; &quot;${out}&quot; &gt; /etc/resolv.conf</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  chmod 644 /etc/resolv.conf</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-exit 0</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1034?usp=3Demail">change 1034</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1034?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic30f8514b50f561e7ea8f1ce12d=
740ac53f202e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1034 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--frrEHIVxxpI=--

