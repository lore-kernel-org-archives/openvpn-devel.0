From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 16:18:28 +0000
In-Reply-To: <gerrit.1751514980000.Ide2cddad193c636eb440c9752751176dae0a6897@...2715...>
References: <gerrit.1751514980000.Ide2cddad193c636eb440c9752751176dae0a6897@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ee61bb92c1ee8236409321147b253334155849d3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ausPM86f1c0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: prevent search
 domain races with macOS dns-updown
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

--ausPM86f1c0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
73?usp=3Demail )

Change subject: prevent search domain races with macOS dns-updown
......................................................................

prevent search domain races with macOS dns-updown

When connections go up and down there are situations where search
domains of a split DNS connection are either lost, or survive the
lifetime of the connction. This can happen when there is also a
connection that modifies the global DNS setting. When it backs-up the
global settings before modifying them, or when it restores the backup,
the search domains could contain or miss VPN domains from other
connections, leading to misconfiguration.

The fix is to also update the backed-up search domains when a split DNS
connection comes up or goes down. That way the backup is always up to
date and restoring it will keep the global search domains as expected.

Change-Id: Ide2cddad193c636eb440c9752751176dae0a6897
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250714160903.7479-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
127.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 67 insertions(+), 20 deletions(-)




diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index c15abaa..f0640ee 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -29,14 +29,49 @@
 [ -z "${dns_vars_file}" ] || . "${dns_vars_file}"

 itf_dns_key=3D"State:/Network/Service/openvpn-${dev}/DNS"
-dns_backup_key=3D"State:/Network/Service/openvpn-${dev}/DnsBackup"
-dns_backup_key_pattern=3D"State:/Network/Service/openvpn-.*/DnsBackup"

 function primary_dns_key {
     local uuid=3D$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scut=
il | grep "PrimaryService" | cut -d: -f2 | xargs)
     echo "Setup:/Network/Service/${uuid}/DNS"
 }

+function dns_backup_key {
+    local key=3D"$(echo "list State:/Network/Service/openvpn-.*/DnsBackup"=
 | /usr/sbin/scutil | cut -d=3D -f2 | xargs)"
+    if [[ "${key}" =3D~ no\ key ]]; then
+        echo "State:/Network/Service/openvpn-${dev}/DnsBackup"
+    else
+        echo "${key}"
+    fi
+}
+
+function property_value {
+    local key=3D"$1"
+    local prop=3D"$2"
+
+    [ -n "${key}" -a -n "${prop}" ] || return
+
+    local match_prop=3D"${prop} : (.*)"
+    local match_array_start=3D"${prop} : <array>"
+    local match_array_elem=3D"[0-9]* : (.*)"
+    local match_array_end=3D"}"
+    local in_array=3Dfalse
+    local values=3D""
+
+    echo "show ${key}" | /usr/sbin/scutil | while read line; do
+        if [ "${in_array}" =3D false ] && [[ "${line}" =3D~ "${match_array=
_start}" ]]; then
+            in_array=3Dtrue
+        elif [ "${in_array}" =3D true ] && [[ "${line}" =3D~ ${match_array=
_elem} ]]; then
+            values+=3D"${BASH_REMATCH[1]} "
+        elif [ "${in_array}" =3D true ] && [[ "${line}" =3D~ "${match_arra=
y_end}" ]]; then
+            echo "${values}"
+            break
+        elif [[ "${line}" =3D~ ${match_prop} ]]; then
+            echo "${BASH_REMATCH[1]}"
+            break
+        fi
+    done
+}
+
 function only_standard_server_ports {
     local i=3D1
     while :; do
@@ -73,42 +108,52 @@
 }

 function get_search_domains {
-    local search_domains=3D""
-    local resolver=3D0
-    /usr/sbin/scutil --dns | while read line; do
-        if [[ "$line" =3D~ resolver.# ]]; then
-            resolver=3D$((resolver+1))
-        elif [ "$resolver" =3D 1 ] && [[ "$line" =3D~ search.domain ]]; th=
en
-            search_domains+=3D"$(echo $line | cut -d: -f2 | xargs) "
-        elif [ "$resolver" -gt 1 ]; then
-            echo "$search_domains"
-            break
-        fi
-    done
+    property_value State:/Network/Global/DNS SearchDomains
 }

 function set_search_domains {
     [ -n "$1" ] || return
-    dns_key=3D$(primary_dns_key)
-    search_domains=3D"${1}$(get_search_domains)"
+    local dns_key=3D$(primary_dns_key)
+    local dns_backup_key=3D"$(dns_backup_key)"
+    local search_domains=3D"${1}$(get_search_domains)"

     local cmds=3D""
     cmds+=3D"get ${dns_key}\n"
     cmds+=3D"d.add SearchDomains * ${search_domains}\n"
     cmds+=3D"set ${dns_key}\n"
+
+    if ! [[ "${dns_backup_key}" =3D~ ${dev}/ ]]; then
+        # Add the domains to the backup in case the default goes down
+        local existing=3D"$(property_value ${dns_backup_key} SearchDomains=
)"
+        cmds+=3D"get ${dns_backup_key}\n"
+        cmds+=3D"d.add SearchDomains * ${search_domains} ${existing}\n"
+        cmds+=3D"set ${dns_backup_key}\n"
+    fi
+
     echo -e "${cmds}" | /usr/sbin/scutil
 }

 function unset_search_domains {
     [ -n "$1" ] || return
-    dns_key=3D$(primary_dns_key)
-    search_domains=3D"$(get_search_domains)"
+    local dns_key=3D$(primary_dns_key)
+    local dns_backup_key=3D"$(dns_backup_key)"
+    local search_domains=3D"$(get_search_domains)"
     search_domains=3D$(echo $search_domains | sed -e "s/$1//")

     local cmds=3D""
     cmds+=3D"get ${dns_key}\n"
     cmds+=3D"d.add SearchDomains * ${search_domains}\n"
     cmds+=3D"set ${dns_key}\n"
+
+    if ! [[ "${dns_backup_key}" =3D~ ${dev}/ ]]; then
+        # Remove the domains from the backup for when the default goes down
+        search_domains=3D"$(property_value ${dns_backup_key} SearchDomains=
)"
+        search_domains=3D$(echo $search_domains | sed -e "s/$1//")
+        cmds+=3D"get ${dns_backup_key}\n"
+        cmds+=3D"d.add SearchDomains * ${search_domains}\n"
+        cmds+=3D"set ${dns_backup_key}\n"
+    fi
+
     echo -e "${cmds}" | /usr/sbin/scutil
 }

@@ -167,7 +212,8 @@
         echo -e "${cmds}" | /usr/sbin/scutil
         set_search_domains "$search_domains"
     else
-        echo list ${dns_backup_key_pattern} | /usr/sbin/scutil | grep -q '=
no key' || {
+        local dns_backup_key=3D"$(dns_backup_key)"
+        [[ "${dns_backup_key}" =3D~ ${dev}/ ]] || {
             echo "setting DNS failed, already redirecting to another tunne=
l"
             exit 1
         }
@@ -207,7 +253,8 @@
         unset_search_domains "$search_domains"
     else
         # Do not unset if this tunnel did not set/backup DNS before
-        echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv 'no key'=
 || return
+        local dns_backup_key=3D"$(dns_backup_key)"
+        [[ "${dns_backup_key}" =3D~ ${dev}/ ]] || return

         local cmds=3D""
         cmds+=3D"get ${dns_backup_key}\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1073?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide2cddad193c636eb440c9752751176dae0a6897
Gerrit-Change-Number: 1073
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ausPM86f1c0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1073?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">prevent search domain races with macOS dns-up=
down<br><br>When connections go up and down there are situations where sear=
ch<br>domains of a split DNS connection are either lost, or survive the<br>=
lifetime of the connction. This can happen when there is also a<br>connecti=
on that modifies the global DNS setting. When it backs-up the<br>global set=
tings before modifying them, or when it restores the backup,<br>the search =
domains could contain or miss VPN domains from other<br>connections, leadin=
g to misconfiguration.<br><br>The fix is to also update the backed-up searc=
h domains when a split DNS<br>connection comes up or goes down. That way th=
e backup is always up to<br>date and restoring it will keep the global sear=
ch domains as expected.<br><br>Change-Id: Ide2cddad193c636eb440c9752751176d=
ae0a6897<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;2025071416=
0903.7479-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg32127.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<=
br>1 file changed, 67 insertions(+), 20 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts=
/macos-dns-updown.sh</span><br><span>index c15abaa..f0640ee 100644</span><b=
r><span>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++ b/=
distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -29,14 +29,49 @@<=
/span><br><span> [ -z &quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_=
file}&quot;</span><br><span> </span><br><span> itf_dns_key=3D&quot;State:/N=
etwork/Service/openvpn-${dev}/DNS&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-dns_backup_key=3D&quot;State:/Network/Service/openvpn-${d=
ev}/DnsBackup&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dn=
s_backup_key_pattern=3D&quot;State:/Network/Service/openvpn-.*/DnsBackup&qu=
ot;</span><br><span> </span><br><span> function primary_dns_key {</span><br=
><span>     local uuid=3D$(echo &quot;show State:/Network/Global/IPv4&quot;=
 | /usr/sbin/scutil | grep &quot;PrimaryService&quot; | cut -d: -f2 | xargs=
)</span><br><span>     echo &quot;Setup:/Network/Service/${uuid}/DNS&quot;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+function dns_backup_key {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    local key=3D&quot;$(echo &quot;list State:/Netwo=
rk/Service/openvpn-.*/DnsBackup&quot; | /usr/sbin/scutil | cut -d=3D -f2 | =
xargs)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
[[ &quot;${key}&quot; =3D~ no\ key ]]; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        echo &quot;State:/Network/Service/openvpn-$=
{dev}/DnsBackup&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
cho &quot;${key}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+function property_value {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    local key=3D&quot;$1&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    local prop=3D&quot;$2&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    [ -n &quot;${key}&quot; -a -n &qu=
ot;${prop}&quot; ] || return</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local =
match_prop=3D&quot;${prop} : (.*)&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    local match_array_start=3D&quot;${prop} : &lt;array=
&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local=
 match_array_elem=3D&quot;[0-9]* : (.*)&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    local match_array_end=3D&quot;}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    local in_array=3Dfalse<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local values=3D&=
quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;show ${key}&=
quot; | /usr/sbin/scutil | while read line; do</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if [ &quot;${in_array}&quot; =3D false ]=
 &amp;&amp; [[ &quot;${line}&quot; =3D~ &quot;${match_array_start}&quot; ]]=
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
n_array=3Dtrue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   elif [ &quot;${in_array}&quot; =3D true ] &amp;&amp; [[ &quot;${line}&qu=
ot; =3D~ ${match_array_elem} ]]; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            values+=3D&quot;${BASH_REMATCH[1]} &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif [ &quot;${=
in_array}&quot; =3D true ] &amp;&amp; [[ &quot;${line}&quot; =3D~ &quot;${m=
atch_array_end}&quot; ]]; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            echo &quot;${values}&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        elif [[ &quot;${line}&quot; =3D~ ${matc=
h_prop} ]]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         echo &quot;${BASH_REMATCH[1]}&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            break</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> function only_standard_server_ports {</span><br><span>     local i=3D1</=
span><br><span>     while :; do</span><br><span>@@ -73,42 +108,52 @@</span>=
<br><span> }</span><br><span> </span><br><span> function get_search_domains=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local search_do=
mains=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   local resolver=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /usr/sbin/scutil --dns | while read line; do</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if [[ &quot;$line&quot; =3D~ resolver.# =
]]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
esolver=3D$((resolver+1))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        elif [ &quot;$resolver&quot; =3D 1 ] &amp;&amp; [[ &quot;$line&=
quot; =3D~ search.domain ]]; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            search_domains+=3D&quot;$(echo $line | cut -d: -f2 =
| xargs) &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  elif [ &quot;$resolver&quot; -gt 1 ]; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            echo &quot;$search_domains&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            break</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    done</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    property_value State:/Network/Global/DNS SearchDom=
ains</span><br><span> }</span><br><span> </span><br><span> function set_sea=
rch_domains {</span><br><span>     [ -n &quot;$1&quot; ] || return</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    dns_key=3D$(primary_dns_ke=
y)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    search_domains=
=3D&quot;${1}$(get_search_domains)&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    local dns_key=3D$(primary_dns_key)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    local dns_backup_key=3D&quot;$(=
dns_backup_key)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    local search_domains=3D&quot;${1}$(get_search_domains)&quot;</span><b=
r><span> </span><br><span>     local cmds=3D&quot;&quot;</span><br><span>  =
   cmds+=3D&quot;get ${dns_key}\n&quot;</span><br><span>     cmds+=3D&quot;=
d.add SearchDomains * ${search_domains}\n&quot;</span><br><span>     cmds+=
=3D&quot;set ${dns_key}\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
! [[ &quot;${dns_backup_key}&quot; =3D~ ${dev}/ ]]; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        # Add the domains to the backu=
p in case the default goes down</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        local existing=3D&quot;$(property_value ${dns_backup_ke=
y} SearchDomains)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmds+=3D&quot;get ${dns_backup_key}\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.add SearchDomai=
ns * ${search_domains} ${existing}\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmds+=3D&quot;set ${dns_backup_key}\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     echo -e &qu=
ot;${cmds}&quot; | /usr/sbin/scutil</span><br><span> }</span><br><span> </s=
pan><br><span> function unset_search_domains {</span><br><span>     [ -n &q=
uot;$1&quot; ] || return</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    dns_key=3D$(primary_dns_key)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    search_domains=3D&quot;$(get_search_domains)&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    local dns_key=3D$(prim=
ary_dns_key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    loc=
al dns_backup_key=3D&quot;$(dns_backup_key)&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    local search_domains=3D&quot;$(get_search=
_domains)&quot;</span><br><span>     search_domains=3D$(echo $search_domain=
s | sed -e &quot;s/$1//&quot;)</span><br><span> </span><br><span>     local=
 cmds=3D&quot;&quot;</span><br><span>     cmds+=3D&quot;get ${dns_key}\n&qu=
ot;</span><br><span>     cmds+=3D&quot;d.add SearchDomains * ${search_domai=
ns}\n&quot;</span><br><span>     cmds+=3D&quot;set ${dns_key}\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if ! [[ &quot;${dns_backup_key}&quot; =
=3D~ ${dev}/ ]]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        # Remove the domains from the backup for when the default goes do=
wn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        search_do=
mains=3D&quot;$(property_value ${dns_backup_key} SearchDomains)&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        search_domains=3D=
$(echo $search_domains | sed -e &quot;s/$1//&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;get ${dns_backup_ke=
y}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mds+=3D&quot;d.add SearchDomains * ${search_domains}\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;set ${dns_ba=
ckup_key}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><span> }</s=
pan><br><span> </span><br><span>@@ -167,7 +212,8 @@</span><br><span>       =
  echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><span>         s=
et_search_domains &quot;$search_domains&quot;</span><br><span>     else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo list ${dns_b=
ackup_key_pattern} | /usr/sbin/scutil | grep -q &#39;no key&#39; || {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        local dns_backup_=
key=3D&quot;$(dns_backup_key)&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        [[ &quot;${dns_backup_key}&quot; =3D~ ${dev}/ ]] ||=
 {</span><br><span>             echo &quot;setting DNS failed, already redi=
recting to another tunnel&quot;</span><br><span>             exit 1</span><=
br><span>         }</span><br><span>@@ -207,7 +253,8 @@</span><br><span>   =
      unset_search_domains &quot;$search_domains&quot;</span><br><span>    =
 else</span><br><span>         # Do not unset if this tunnel did not set/ba=
ckup DNS before</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv &#39;no key&#39=
; || return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
local dns_backup_key=3D&quot;$(dns_backup_key)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        [[ &quot;${dns_backup_key}&quot; =
=3D~ ${dev}/ ]] || return</span><br><span> </span><br><span>         local =
cmds=3D&quot;&quot;</span><br><span>         cmds+=3D&quot;get ${dns_backup=
_key}\n&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1073?usp=3Demail">change 1073</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1073?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide2cddad193c636eb440c975275=
1176dae0a6897 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1073 </div>
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


--ausPM86f1c0=--

