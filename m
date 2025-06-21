From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 21 Jun 2025 12:30:37 +0000
In-Reply-To: <gerrit.1749787477000.Iade06a8454ccf53668deef61f07217ead8ec6c63@...2715...>
References: <gerrit.1749787477000.Iade06a8454ccf53668deef61f07217ead8ec6c63@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2efdd9d0dd3a461659f3ff67613082342fb93ee1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sBc+HWdp9gs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: add updown
 script for macOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sBc+HWdp9gs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
62?usp=3Demail )

Change subject: dns: add updown script for macOS
......................................................................

dns: add updown script for macOS

Change-Id: Iade06a8454ccf53668deef61f07217ead8ec6c63
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250621121301.27509-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
942.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M distro/dns-scripts/Makefile.am
A distro/dns-scripts/macos-dns-updown.sh
3 files changed, 219 insertions(+), 2 deletions(-)




diff --git a/configure.ac b/configure.ac
index 8bdec32..02b45f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,8 +364,7 @@
 	*-*-darwin*)
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
-		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
-		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["macos"])
 		have_tap_header=3D"yes"
 		ac_cv_type_struct_in_pktinfo=3Dno
 		;;
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
index 9fcd3f7..e3f9043 100644
--- a/distro/dns-scripts/Makefile.am
+++ b/distro/dns-scripts/Makefile.am
@@ -12,6 +12,7 @@
 	$(srcdir)/Makefile.in

 EXTRA_DIST =3D \
+	macos-dns-updown.sh \
 	systemd-dns-updown.sh \
 	openresolv-dns-updown.sh \
 	haikuos_file-dns-updown.sh \
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
new file mode 100644
index 0000000..89d6882
--- /dev/null
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -0,0 +1,217 @@
+#!/bin/bash
+#
+# dns-updown - add/remove openvpn provided DNS information
+#
+# (C) Copyright 2025 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
+#   dev utun0
+#   script_type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
+#   dns_server_1_port_2 53
+#   dns_server_1_resolve_domain_1 mycorp.in
+#   dns_server_1_resolve_domain_2 eu.mycorp.com
+#   dns_server_1_dnssec true
+#   dns_server_1_transport DoH
+#   dns_server_1_sni dns.mycorp.in
+#
+
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
+
+itf_dns_key=3D"State:/Network/Service/openvpn-${dev}/DNS"
+dns_backup_key=3D"State:/Network/Service/openvpn-${dev}/DnsBackup"
+
+function primary_dns_key {
+    local uuid=3D$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scut=
il | grep "PrimaryService" | cut -d: -f2 | xargs)
+    echo "Setup:/Network/Service/${uuid}/DNS"
+}
+
+function only_standard_server_ports {
+    local i=3D1
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_${i}
+        [ -n "${!addr_var}" ] || return 0
+
+        local port_var=3Ddns_server_${n}_port_${i}
+        [ -z "${!port_var}" -o "${!port_var}" =3D "53" ] || return 1
+
+        i=3D$((i+1))
+    done
+}
+
+function find_compat_profile {
+    local n=3D1
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_1
+        [ -n "${!addr_var}" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        local dnssec_var=3Ddns_server_${n}_dnssec
+        local transport_var=3Ddns_server_${n}_transport
+        [ -z "${!transport_var}" -o "${!transport_var}" =3D "plain" ] \
+            && [ -z "${!dnssec_var}" -o "${!dnssec_var}" =3D "no" ] \
+            && only_standard_server_ports && break
+
+        n=3D$((n+1))
+    done
+    return $n
+}
+
+function get_search_domains {
+    local search_domains=3D""
+    local resolver=3D0
+    /usr/sbin/scutil --dns | while read line; do
+        if [[ "$line" =3D~ resolver.# ]]; then
+            resolver=3D$((resolver+1))
+        elif [ "$resolver" =3D 1 ] && [[ "$line" =3D~ search.domain ]]; th=
en
+            search_domains+=3D"$(echo $line | cut -d: -f2 | xargs) "
+        elif [ "$resolver" -gt 1 ]; then
+            echo "$search_domains"
+            break
+        fi
+    done
+}
+
+function set_search_domains {
+    [ -n "$1" ] || return
+    dns_key=3D$(primary_dns_key)
+    search_domains=3D"${1}$(get_search_domains)"
+
+    local cmds=3D""
+    cmds+=3D"get ${dns_key}\n"
+    cmds+=3D"d.add SearchDomains * ${search_domains}\n"
+    cmds+=3D"set ${dns_key}\n"
+    echo -e "${cmds}" | /usr/sbin/scutil
+}
+
+function unset_search_domains {
+    [ -n "$1" ] || return
+    dns_key=3D$(primary_dns_key)
+    search_domains=3D"$(get_search_domains)"
+    search_domains=3D$(echo $search_domains | sed -e "s/$1//")
+
+    local cmds=3D""
+    cmds+=3D"get ${dns_key}\n"
+    cmds+=3D"d.add SearchDomains * ${search_domains}\n"
+    cmds+=3D"set ${dns_key}\n"
+    echo -e "${cmds}" | /usr/sbin/scutil
+}
+
+function set_dns {
+    find_compat_profile
+    local n=3D$?
+
+    local i=3D1
+    local addrs=3D""
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_${i}
+        local addr=3D"${!addr_var}"
+        [ -n "$addr" ] || break
+
+        local port_var=3Ddns_server_${n}_port_${i}
+        if [ -n "${!port_var}" ]; then
+            if [[ "$addr" =3D~ : ]]; then
+                addr=3D"[$addr]"
+            fi
+            addrs+=3D"${addr}:${!port_var}${sni} "
+        else
+            addrs+=3D"${addr}${sni} "
+        fi
+        i=3D$((i+1))
+    done
+
+    i=3D1
+    local match_domains=3D""
+    while :; do
+        domain_var=3Ddns_server_${n}_resolve_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as match domain, if it doesn't already exist
+        [[ "$match_domains" =3D~ (^| )${!domain_var}( |$) ]] \
+            || match_domains+=3D"${!domain_var} "
+        i=3D$((i+1))
+    done
+
+    i=3D1
+    local search_domains=3D""
+    while :; do
+        domain_var=3Ddns_search_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as search domain, if it doesn't already exist
+        [[ "$search_domains" =3D~ (^| )${!domain_var}( |$) ]] \
+            || search_domains+=3D"${!domain_var} "
+        i=3D$((i+1))
+    done
+
+    if [ -n "$match_domains" ]; then
+        local cmds=3D""
+        cmds+=3D"d.init\n"
+        cmds+=3D"d.add ServerAddresses * ${addrs}\n"
+        cmds+=3D"d.add SupplementalMatchDomains * ${match_domains}\n"
+        cmds+=3D"d.add SupplementalMatchDomainsNoSearch # 1\n"
+        cmds+=3D"add ${itf_dns_key}\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+        set_search_domains "$search_domains"
+    else
+        local cmds=3D""
+        cmds+=3D"get $(primary_dns_key)\n"
+        cmds+=3D"set ${dns_backup_key}\n"
+        cmds+=3D"d.init\n"
+        cmds+=3D"d.add ServerAddresses * ${addrs}\n"
+        cmds+=3D"d.add SearchDomains * ${search_domains}\n"
+        cmds+=3D"d.add SearchOrder # 5000\n"
+        cmds+=3D"set $(primary_dns_key)\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+    fi
+
+    /usr/bin/dscacheutil -flushcache
+}
+
+function unset_dns {
+    find_compat_profile
+    local n=3D$?
+
+    local i=3D1
+    local search_domains=3D""
+    while :; do
+        domain_var=3Ddns_search_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as search domain, if it doesn't already exist
+        [[ "$search_domains" =3D~ (^| )${!domain_var}( |$) ]] \
+            || search_domains+=3D"${!domain_var} "
+        i=3D$((i+1))
+    done
+
+    domain_var=3Ddns_server_${n}_resolve_domain_1
+    if [ -n "${!domain_var}" ]; then
+        echo "remove ${itf_dns_key}" | /usr/sbin/scutil
+        unset_search_domains "$search_domains"
+    else
+        local cmds=3D""
+        cmds+=3D"get ${dns_backup_key}\n"
+        cmds+=3D"set $(primary_dns_key)\n"
+        cmds+=3D"remove ${dns_backup_key}\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+    fi
+
+    /usr/bin/dscacheutil -flushcache
+}
+
+if [ "$script_type" =3D "dns-up" ]; then
+    set_dns
+else
+    unset_dns
+fi

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1062?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iade06a8454ccf53668deef61f07217ead8ec6c63
Gerrit-Change-Number: 1062
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--sBc+HWdp9gs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1062?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: add updown script for macOS<br><br>Chang=
e-Id: Iade06a8454ccf53668deef61f07217ead8ec6c63<br>Signed-off-by: Heiko Hun=
d &lt;heiko@...2662...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1711...=
27...&gt;<br>Message-Id: &lt;20250621121301.27509-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
942.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 configure.ac<br>M distro/dns-scripts/Makefile.am<br>A distro/dns-scripts/m=
acos-dns-updown.sh<br>3 files changed, 219 insertions(+), 2 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 8bdec32..=
02b45f8 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -364,8 +364,7 @@</span><br><span> 	*-*-darwin*=
)</span><br><span> 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac=
 OS X?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;M&qu=
ot;], [Target prefix])</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_f=
ile&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUB=
ST([DNS_UPDOWN_TYPE], [&quot;macos&quot;])</span><br><span> 		have_tap_head=
er=3D&quot;yes&quot;</span><br><span> 		ac_cv_type_struct_in_pktinfo=3Dno</=
span><br><span> 		;;</span><br><span>diff --git a/distro/dns-scripts/Makefi=
le.am b/distro/dns-scripts/Makefile.am</span><br><span>index 9fcd3f7..e3f90=
43 100644</span><br><span>--- a/distro/dns-scripts/Makefile.am</span><br><s=
pan>+++ b/distro/dns-scripts/Makefile.am</span><br><span>@@ -12,6 +12,7 @@<=
/span><br><span> 	$(srcdir)/Makefile.in</span><br><span> </span><br><span> =
EXTRA_DIST =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ma=
cos-dns-updown.sh \</span><br><span> 	systemd-dns-updown.sh \</span><br><sp=
an> 	openresolv-dns-updown.sh \</span><br><span> 	haikuos_file-dns-updown.s=
h \</span><br><span>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/d=
istro/dns-scripts/macos-dns-updown.sh</span><br><span>new file mode 100644<=
/span><br><span>index 0000000..89d6882</span><br><span>--- /dev/null</span>=
<br><span>+++ b/distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -=
0,0 +1,217 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin=
/bash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# dns-updown - add/remove openvp=
n provided DNS information</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# (C) Copyr=
ight 2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# SPDX-License-Identifier: BSD-2-Clause</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# Example env from openvpn (most are not applied):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43a=
fb5d745f986c53c.tmp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#      or</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   dev utun0</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#   script_type dns-up</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.c=
om</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_=
address_1 192.168.99.254</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   dns_server_1_address_2 fd00::99:53</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_res=
olve_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dns_server_1_dnssec true</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   dns_server_1_transport DoH</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+[ -z &quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+itf_dns_key=3D&quot;State:/Network/Ser=
vice/openvpn-${dev}/DNS&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dns_backup_key=3D&quot;State:/Network/Service/openvpn-${dev}/DnsB=
ackup&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+function primary_dns_key {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local uuid=3D$(e=
cho &quot;show State:/Network/Global/IPv4&quot; | /usr/sbin/scutil | grep &=
quot;PrimaryService&quot; | cut -d: -f2 | xargs)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    echo &quot;Setup:/Network/Service/${uuid}/=
DNS&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+function only_standard_server_ports {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    local i=3D1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        local addr_var=3Ddns_server_$=
{n}_address_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     [ -n &quot;${!addr_var}&quot; ] || return 0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        local port_var=3Ddns_server_${n}_port_${i}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;${!port_var}&qu=
ot; -o &quot;${!port_var}&quot; =3D &quot;53&quot; ] || return 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        i=3D$((i+1))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+function find_compat_=
profile {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local =
n=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while :; d=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local addr=
_var=3Ddns_server_${n}_address_1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        [ -n &quot;${!addr_var}&quot; ] || {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            echo &quot;setting DNS fa=
iled, no compatible server profile&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            exit 1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #=
 Skip server profiles which require DNSSEC,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # secure transport or use a custom port</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        local dnssec_va=
r=3Ddns_server_${n}_dnssec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        local transport_var=3Ddns_server_${n}_transport</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;${!transport_=
var}&quot; -o &quot;${!transport_var}&quot; =3D &quot;plain&quot; ] \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; [ =
-z &quot;${!dnssec_var}&quot; -o &quot;${!dnssec_var}&quot; =3D &quot;no&qu=
ot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; only_standard_server_ports &amp;&amp; break</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        n=3D$((n+1))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return $n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+function get_search_domains {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    local search_domains=3D=
&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    loc=
al resolver=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/usr/sbin/scutil --dns | while read line; do</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if [[ &quot;$line&quot; =3D~ resolver.# ]]=
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
esolver=3D$((resolver+1))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        elif [ &quot;$resolver&quot; =3D 1 ] &amp;&amp; [[ &quot;$lin=
e&quot; =3D~ search.domain ]]; then</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            search_domains+=3D&quot;$(echo $line | cut -d: =
-f2 | xargs) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        elif [ &quot;$resolver&quot; -gt 1 ]; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            echo &quot;$search_domains&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fun=
ction set_search_domains {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    [ -n &quot;$1&quot; ] || return</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dns_key=3D$(primary_dns_key)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    search_domains=3D&quot;${1}$(get_se=
arch_domains)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local cmds=3D&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmds+=
=3D&quot;get ${dns_key}\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    cmds+=3D&quot;d.add SearchDomains * ${search_domains}\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmds+=3D&quot=
;set ${dns_key}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fu=
nction unset_search_domains {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    [ -n &quot;$1&quot; ] || return</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    dns_key=3D$(primary_dns_key)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    search_domains=3D&quot;$(get_sea=
rch_domains)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   search_domains=3D$(echo $search_domains | sed -e &quot;s/$1//&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    local cmds=3D&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmds+=3D&quot;get ${dns_key=
}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmds+=
=3D&quot;d.add SearchDomains * ${search_domains}\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    cmds+=3D&quot;set ${dns_key}\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo -e &quot=
;${cmds}&quot; | /usr/sbin/scutil</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+function set_dns {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    find_compat_profile<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local n=3D$?</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    local i=3D1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    local addrs=3D&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        local addr_var=3Ddns_server_${=
n}_address_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    local addr=3D&quot;${!addr_var}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] || break</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        local port_var=3Ddns_server_${n}_port_${i}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &qu=
ot;${!port_var}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if [[ &quot;$addr&quot; =3D~ : ]]; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                addr=3D&quot;[$ad=
dr]&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add=
rs+=3D&quot;${addr}:${!port_var}${sni} &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            addrs+=3D&quot;${addr}${sni} &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        i=3D$((i+1))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   local match_domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        domain_var=3Ddns_server_${n}_resolve_domain_${i}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;${!do=
main_var}&quot; ] || break</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        # Add as match domain, if it doesn&#39;t already exist</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        [[ &quot;$match_d=
omains&quot; =3D~ (^| )${!domain_var}( |$) ]] \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            || match_domains+=3D&quot;${!domain=
_var} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 i=3D$((i+1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do=
ne</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    i=3D1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    local search_domains=3D&quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        domain_var=3Ddns_searc=
h_domain_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  [ -n &quot;${!domain_var}&quot; ] || break</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        # Add as search domain, if it doesn&#39;t =
already exist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  [[ &quot;$search_domains&quot; =3D~ (^| )${!domain_var}( |$) ]] \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            || search_domai=
ns+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        i=3D$((i+1))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &qu=
ot;$match_domains&quot; ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        local cmds=3D&quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.init\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.add Serv=
erAddresses * ${addrs}\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmds+=3D&quot;d.add SupplementalMatchDomains * ${match_d=
omains}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmds+=3D&quot;d.add SupplementalMatchDomainsNoSearch # 1\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;add =
${itf_dns_key}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        set_search_domains &quot;$sea=
rch_domains&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local=
 cmds=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmds+=3D&quot;get $(primary_dns_key)\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;set ${dns_backup_ke=
y}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mds+=3D&quot;d.init\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmds+=3D&quot;d.add ServerAddresses * ${addrs}\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.=
add SearchDomains * ${search_domains}\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.add SearchOrder # 5000\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmds+=
=3D&quot;set $(primary_dns_key)\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        echo -e &quot;${cmds}&quot; | /usr/sbin/scutil<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /usr/bin/dscacheutil -flushcache</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+function unset_dns {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    find_compat_profile</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    local n=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local i=3D=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local search_d=
omains=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      domain_var=3Ddns_search_domain_${i}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        [ -n &quot;${!domain_var}&quot; ] || break</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Add as searc=
h domain, if it doesn&#39;t already exist</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        [[ &quot;$search_domains&quot; =3D~ (^| )${!d=
omain_var}( |$) ]] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            || search_domains+=3D&quot;${!domain_var} &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        i=3D$((i+1))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    domain_var=3Ddns_server_${n}_resolve_domain_1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;${!domain_va=
r}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     echo &quot;remove ${itf_dns_key}&quot; | /usr/sbin/scutil</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        unset_search_domains &qu=
ot;$search_domains&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  local cmds=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmds+=3D&quot;get ${dns_backup_key}\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;set $(primary=
_dns_key)\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmds+=3D&quot;remove ${dns_backup_key}\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo -e &quot;${cmds}&quot; | /us=
r/sbin/scutil</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /usr/bin/dscacheutil -flushcache</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+if [ &quot;$script_type&quot; =3D &quot;dns-up&quot; ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_dns</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unset_dns</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+fi</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1062?usp=3Demail">=
change 1062</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1062?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iade06a8454ccf53668deef61f07=
217ead8ec6c63 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1062 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--sBc+HWdp9gs=--

