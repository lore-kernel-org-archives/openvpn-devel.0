From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 11:22:51 +0000
In-Reply-To: <gerrit.1751514980000.Id6f70237c7205063b001528a40391678b0d093ac@...2715...>
References: <gerrit.1751514980000.Id6f70237c7205063b001528a40391678b0d093ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <13baba59d8156b339405e7e3d11c71fcf58a7c2b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SniaG5E6UAg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: move macOS
 dns-updown common code into functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SniaG5E6UAg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1074?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: move macOS dns-updown common code into functions
......................................................................

move macOS dns-updown common code into functions

Change-Id: Id6f70237c7205063b001528a40391678b0d093ac
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250711100853.242102-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
105.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 40 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1074/4

diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index f0640ee..56f1009 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -104,7 +104,7 @@

         n=3D$((n+1))
     done
-    return $n
+    echo $n
 }

 function get_search_domains {
@@ -157,41 +157,23 @@
     echo -e "${cmds}" | /usr/sbin/scutil
 }

-function set_dns {
-    find_compat_profile
-    local n=3D$?
-
+function addresses_string {
+    local n=3D$1
     local i=3D1
-    local addrs=3D""
+    local addresses=3D""
     while :; do
         local addr_var=3Ddns_server_${n}_address_${i}
         local addr=3D"${!addr_var}"
         [ -n "$addr" ] || break
-
-        local port_var=3Ddns_server_${n}_port_${i}
-        if [ -n "${!port_var}" ]; then
-            if [[ "$addr" =3D~ : ]]; then
-                addr=3D"[$addr]"
-            fi
-            addrs+=3D"${addr}:${!port_var}${sni} "
-        else
-            addrs+=3D"${addr}${sni} "
-        fi
+        addresses+=3D"${addr} "
         i=3D$((i+1))
     done
+    echo "$addresses"
+}

-    i=3D1
-    local match_domains=3D""
-    while :; do
-        domain_var=3Ddns_server_${n}_resolve_domain_${i}
-        [ -n "${!domain_var}" ] || break
-        # Add as match domain, if it doesn't already exist
-        [[ "$match_domains" =3D~ (^| )${!domain_var}( |$) ]] \
-            || match_domains+=3D"${!domain_var} "
-        i=3D$((i+1))
-    done
-
-    i=3D1
+function search_domains_string {
+    local n=3D$1
+    local i=3D1
     local search_domains=3D""
     while :; do
         domain_var=3Ddns_search_domain_${i}
@@ -201,11 +183,34 @@
             || search_domains+=3D"${!domain_var} "
         i=3D$((i+1))
     done
+    echo "$search_domains"
+}
+
+function match_domains_string {
+    local n=3D$1
+    local i=3D1
+    local match_domains=3D""
+    while :; do
+        domain_var=3Ddns_server_${n}_resolve_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as match domain, if it doesn't already exist
+        [[ "$match_domains" =3D~ (^| )${!domain_var}( |$) ]] \
+            || match_domains+=3D"${!domain_var} "
+        i=3D$((i+1))
+    done
+    echo "$match_domains"
+}
+
+function set_dns {
+    local n=3D"$(find_compat_profile)"
+    local addresses=3D"$(addresses_string $n)"
+    local search_domains=3D"$(search_domains_string $n)"
+    local match_domains=3D"$(match_domains_string $n)"

     if [ -n "$match_domains" ]; then
         local cmds=3D""
         cmds+=3D"d.init\n"
-        cmds+=3D"d.add ServerAddresses * ${addrs}\n"
+        cmds+=3D"d.add ServerAddresses * ${addresses}\n"
         cmds+=3D"d.add SupplementalMatchDomains * ${match_domains}\n"
         cmds+=3D"d.add SupplementalMatchDomainsNoSearch # 1\n"
         cmds+=3D"add ${itf_dns_key}\n"
@@ -222,7 +227,7 @@
         cmds+=3D"get $(primary_dns_key)\n"
         cmds+=3D"set ${dns_backup_key}\n"
         cmds+=3D"d.init\n"
-        cmds+=3D"d.add ServerAddresses * ${addrs}\n"
+        cmds+=3D"d.add ServerAddresses * ${addresses}\n"
         cmds+=3D"d.add SearchDomains * ${search_domains}\n"
         cmds+=3D"d.add SearchOrder # 5000\n"
         cmds+=3D"set $(primary_dns_key)\n"
@@ -233,22 +238,12 @@
 }

 function unset_dns {
-    find_compat_profile
-    local n=3D$?
+    local n=3D"$(find_compat_profile)"
+    local addresses=3D"$(addresses_string $n)"
+    local search_domains=3D"$(search_domains_string $n)"
+    local match_domains=3D"$(match_domains_string $n)"

-    local i=3D1
-    local search_domains=3D""
-    while :; do
-        domain_var=3Ddns_search_domain_${i}
-        [ -n "${!domain_var}" ] || break
-        # Add as search domain, if it doesn't already exist
-        [[ "$search_domains" =3D~ (^| )${!domain_var}( |$) ]] \
-            || search_domains+=3D"${!domain_var} "
-        i=3D$((i+1))
-    done
-
-    domain_var=3Ddns_server_${n}_resolve_domain_1
-    if [ -n "${!domain_var}" ]; then
+    if [ -n "$match_domains" ]; then
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1074?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6f70237c7205063b001528a40391678b0d093ac
Gerrit-Change-Number: 1074
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--SniaG5E6UAg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1074=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">move macOS dns-updown common code into functi=
ons<br><br>Change-Id: Id6f70237c7205063b001528a40391678b0d093ac<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>Message-Id: &lt;20250711100853.242102-1-frank@...1186...=
.2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg32105.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<br>1 file changed, =
40 insertions(+), 45 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/74/1074/4</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/distro/dns-scr=
ipts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh</span><br=
><span>index f0640ee..56f1009 100644</span><br><span>--- a/distro/dns-scrip=
ts/macos-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/macos-dns-u=
pdown.sh</span><br><span>@@ -104,7 +104,7 @@</span><br><span> </span><br><s=
pan>         n=3D$((n+1))</span><br><span>     done</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return $n</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    echo $n</span><br><span> }</span><br><span> <=
/span><br><span> function get_search_domains {</span><br><span>@@ -157,41 +=
157,23 @@</span><br><span>     echo -e &quot;${cmds}&quot; | /usr/sbin/scut=
il</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-function set_dns {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    find_compat_profile</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    local n=3D$?</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+functio=
n addresses_string {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    local n=3D$1</span><br><span>     local i=3D1</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    local addrs=3D&quot;&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    local addresses=3D&quot;&quot;<=
/span><br><span>     while :; do</span><br><span>         local addr_var=3D=
dns_server_${n}_address_${i}</span><br><span>         local addr=3D&quot;${=
!addr_var}&quot;</span><br><span>         [ -n &quot;$addr&quot; ] || break=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        local port_var=3Ddns_server_${n}_p=
ort_${i}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ =
-n &quot;${!port_var}&quot; ]; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if [[ &quot;$addr&quot; =3D~ : ]]; then</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                addr=3D&quot;[$=
addr]&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            addrs=
+=3D&quot;${addr}:${!port_var}${sni} &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            addrs+=3D&quot;${addr}${sni} &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        fi</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        addresses+=3D&quot;${addr} &quot;</sp=
an><br><span>         i=3D$((i+1))</span><br><span>     done</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$addresses&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=3D1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    local match_domains=3D&quot;&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while :; do</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_var=3Ddns_=
server_${n}_resolve_domain_${i}</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        [ -n &quot;${!domain_var}&quot; ] || break</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        # Add as match domain, if it=
 doesn&#39;t already exist</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        [[ &quot;$match_domains&quot; =3D~ (^| )${!domain_var}( |$) ]]=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || matc=
h_domains+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        i=3D$((i+1))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    done</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=3D1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+function search_domains_st=
ring {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local n=
=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local i=3D=
1</span><br><span>     local search_domains=3D&quot;&quot;</span><br><span>=
     while :; do</span><br><span>         domain_var=3Ddns_search_domain_${=
i}</span><br><span>@@ -201,11 +183,34 @@</span><br><span>             || se=
arch_domains+=3D&quot;${!domain_var} &quot;</span><br><span>         i=3D$(=
(i+1))</span><br><span>     done</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    echo &quot;$search_domains&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+functio=
n match_domains_string {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    local n=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    local i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  local match_domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        domain_var=3Ddns_server_${n}_resolve_domain_${i}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;${!dom=
ain_var}&quot; ] || break</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        # Add as match domain, if it doesn&#39;t already exist</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        [[ &quot;$match_do=
mains&quot; =3D~ (^| )${!domain_var}( |$) ]] \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            || match_domains+=3D&quot;${!domain_=
var} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
i=3D$((i+1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    don=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$ma=
tch_domains&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+function set_dns {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    local n=3D&quot;$(find_compat_profil=
e)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local a=
ddresses=3D&quot;$(addresses_string $n)&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    local search_domains=3D&quot;$(search_domains=
_string $n)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  local match_domains=3D&quot;$(match_domains_string $n)&quot;</span><br><s=
pan> </span><br><span>     if [ -n &quot;$match_domains&quot; ]; then</span=
><br><span>         local cmds=3D&quot;&quot;</span><br><span>         cmds=
+=3D&quot;d.init\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        cmds+=3D&quot;d.add ServerAddresses * ${addrs}\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.add S=
erverAddresses * ${addresses}\n&quot;</span><br><span>         cmds+=3D&quo=
t;d.add SupplementalMatchDomains * ${match_domains}\n&quot;</span><br><span=
>         cmds+=3D&quot;d.add SupplementalMatchDomainsNoSearch # 1\n&quot;<=
/span><br><span>         cmds+=3D&quot;add ${itf_dns_key}\n&quot;</span><br=
><span>@@ -222,7 +227,7 @@</span><br><span>         cmds+=3D&quot;get $(pri=
mary_dns_key)\n&quot;</span><br><span>         cmds+=3D&quot;set ${dns_back=
up_key}\n&quot;</span><br><span>         cmds+=3D&quot;d.init\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmds+=3D&quot;d.add=
 ServerAddresses * ${addrs}\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmds+=3D&quot;d.add ServerAddresses * ${addresses}\=
n&quot;</span><br><span>         cmds+=3D&quot;d.add SearchDomains * ${sear=
ch_domains}\n&quot;</span><br><span>         cmds+=3D&quot;d.add SearchOrde=
r # 5000\n&quot;</span><br><span>         cmds+=3D&quot;set $(primary_dns_k=
ey)\n&quot;</span><br><span>@@ -233,22 +238,12 @@</span><br><span> }</span>=
<br><span> </span><br><span> function unset_dns {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    find_compat_profile</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    local n=3D$?</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    local n=3D&quot;$(find_compat_profile)&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local address=
es=3D&quot;$(addresses_string $n)&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    local search_domains=3D&quot;$(search_domains_strin=
g $n)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    loca=
l match_domains=3D&quot;$(match_domains_string $n)&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local i=3D1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    local search_domains=3D&=
quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while =
:; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_v=
ar=3Ddns_search_domain_${i}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        [ -n &quot;${!domain_var}&quot; ] || break</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        # Add as search domain, if it do=
esn&#39;t already exist</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        [[ &quot;$search_domains&quot; =3D~ (^| )${!domain_var}( |$) ]] \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || search=
_domains+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        i=3D$((i+1))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    done</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    domain_var=3D=
dns_server_${n}_resolve_domain_1</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if [ -n &quot;${!domain_var}&quot; ]; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$match_domains&quot=
; ]; then</span><br><span>         echo &quot;remove ${itf_dns_key}&quot; |=
 /usr/sbin/scutil</span><br><span>         unset_search_domains &quot;$sear=
ch_domains&quot;</span><br><span>     else</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1074?us=
p=3Demail">change 1074</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1074?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6f70237c7205063b001528a403=
91678b0d093ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SniaG5E6UAg=--

