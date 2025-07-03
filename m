From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 3 Jul 2025 03:56:26 +0000
References: <gerrit.1751514980000.Id6f70237c7205063b001528a40391678b0d093ac@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <95dbe4615bbbf5b9fc8e2968a9239ec11eeb561c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YnfBVMPsuSk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YnfBVMPsuSk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1074?usp=3Demail

to review the following change.


Change subject: move macOS dns-updown common code into functions
......................................................................

move macOS dns-updown common code into functions

Change-Id: Id6f70237c7205063b001528a40391678b0d093ac
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 40 insertions(+), 45 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1074/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--YnfBVMPsuSk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1074?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">move macOS dns-updown common code into functions<br><br>Chan=
ge-Id: Id6f70237c7205063b001528a40391678b0d093ac<br>Signed-off-by: Heiko Hu=
nd &lt;heiko@...2662...&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown=
.sh<br>1 file changed, 40 insertions(+), 45 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1074/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-=
dns-updown.sh</span><br><span>index f0640ee..56f1009 100644</span><br><span=
>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++ b/distro/=
dns-scripts/macos-dns-updown.sh</span><br><span>@@ -104,7 +104,7 @@</span><=
br><span> </span><br><span>         n=3D$((n+1))</span><br><span>     done<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return $n</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    echo $n</span><br><span>=
 }</span><br><span> </span><br><span> function get_search_domains {</span><=
br><span>@@ -157,41 +157,23 @@</span><br><span>     echo -e &quot;${cmds}&q=
uot; | /usr/sbin/scutil</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-function set_dns {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    find_compat_profile</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    local n=3D$?</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+function addresses_string {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    local n=3D$1</span><br><span>     local i=3D1</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    local addrs=3D&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local addr=
esses=3D&quot;&quot;</span><br><span>     while :; do</span><br><span>     =
    local addr_var=3Ddns_server_${n}_address_${i}</span><br><span>         =
local addr=3D&quot;${!addr_var}&quot;</span><br><span>         [ -n &quot;$=
addr&quot; ] || break</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        local port_va=
r=3Ddns_server_${n}_port_${i}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if [ -n &quot;${!port_var}&quot; ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if [[ &quot;$addr&quot; =3D~=
 : ]]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      addr=3D&quot;[$addr]&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            fi</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            addrs+=3D&quot;${addr}:${!port_var}${sni} &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            addrs+=3D&quot;${addr}${sni} =
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        addresses+=3D&qu=
ot;${addr} &quot;</span><br><span>         i=3D$((i+1))</span><br><span>   =
  done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quo=
t;$addresses&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 i=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local match=
_domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    while :; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    domain_var=3Ddns_server_${n}_resolve_domain_${i}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        [ -n &quot;${!domain_var}&quot; ] |=
| break</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        # Add =
as match domain, if it doesn&#39;t already exist</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        [[ &quot;$match_domains&quot; =3D~ (^| )=
${!domain_var}( |$) ]] \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            || match_domains+=3D&quot;${!domain_var} &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        i=3D$((i+1))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    done</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+func=
tion search_domains_string {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    local n=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    local i=3D1</span><br><span>     local search_domains=3D&quot;&qu=
ot;</span><br><span>     while :; do</span><br><span>         domain_var=3D=
dns_search_domain_${i}</span><br><span>@@ -201,11 +183,34 @@</span><br><spa=
n>             || search_domains+=3D&quot;${!domain_var} &quot;</span><br><=
span>         i=3D$((i+1))</span><br><span>     done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$search_domains&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+function match_domains_string {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    local n=3D$1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    local i=3D1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    local match_domains=3D&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        domain_var=3Ddns_server_${n}_res=
olve_domain_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     [ -n &quot;${!domain_var}&quot; ] || break</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Add as match domain, if it doesn&#39;=
t already exist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    [[ &quot;$match_domains&quot; =3D~ (^| )${!domain_var}( |$) ]] \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            || match_domai=
ns+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        i=3D$((i+1))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    echo &quot;$match_domains&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function set_dns =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local n=3D&quo=
t;$(find_compat_profile)&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    local addresses=3D&quot;$(addresses_string $n)&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    local search_domains=3D=
&quot;$(search_domains_string $n)&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    local match_domains=3D&quot;$(match_domains_string =
$n)&quot;</span><br><span> </span><br><span>     if [ -n &quot;$match_domai=
ns&quot; ]; then</span><br><span>         local cmds=3D&quot;&quot;</span><=
br><span>         cmds+=3D&quot;d.init\n&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        cmds+=3D&quot;d.add ServerAddresses * ${ad=
drs}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmds+=3D&quot;d.add ServerAddresses * ${addresses}\n&quot;</span><br><span=
>         cmds+=3D&quot;d.add SupplementalMatchDomains * ${match_domains}\n=
&quot;</span><br><span>         cmds+=3D&quot;d.add SupplementalMatchDomain=
sNoSearch # 1\n&quot;</span><br><span>         cmds+=3D&quot;add ${itf_dns_=
key}\n&quot;</span><br><span>@@ -222,7 +227,7 @@</span><br><span>         c=
mds+=3D&quot;get $(primary_dns_key)\n&quot;</span><br><span>         cmds+=
=3D&quot;set ${dns_backup_key}\n&quot;</span><br><span>         cmds+=3D&qu=
ot;d.init\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    cmds+=3D&quot;d.add ServerAddresses * ${addrs}\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmds+=3D&quot;d.add ServerAd=
dresses * ${addresses}\n&quot;</span><br><span>         cmds+=3D&quot;d.add=
 SearchDomains * ${search_domains}\n&quot;</span><br><span>         cmds+=
=3D&quot;d.add SearchOrder # 5000\n&quot;</span><br><span>         cmds+=3D=
&quot;set $(primary_dns_key)\n&quot;</span><br><span>@@ -233,22 +238,12 @@<=
/span><br><span> }</span><br><span> </span><br><span> function unset_dns {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    find_compat_profil=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local n=3D$?</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    local n=3D&quot;$(f=
ind_compat_profile)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    local addresses=3D&quot;$(addresses_string $n)&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    local search_domains=3D&quot=
;$(search_domains_string $n)&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    local match_domains=3D&quot;$(match_domains_string $n)&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    local i=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    l=
ocal search_domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    while :; do</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        domain_var=3Ddns_search_domain_${i}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        [ -n &quot;${!domain_var}&quot; ] || b=
reak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        # Add as =
search domain, if it doesn&#39;t already exist</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        [[ &quot;$search_domains&quot; =3D~ (^| )$=
{!domain_var}( |$) ]] \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            || search_domains+=3D&quot;${!domain_var} &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        i=3D$((i+1))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    done</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    domain_var=3Ddns_server_${n}_resolve_domain_1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if [ -n &quot;${!domain_var}&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &q=
uot;$match_domains&quot; ]; then</span><br><span>         echo &quot;remove=
 ${itf_dns_key}&quot; | /usr/sbin/scutil</span><br><span>         unset_sea=
rch_domains &quot;$search_domains&quot;</span><br><span>     else</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1074?usp=3Demail">change 1074</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1074?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6f70237c7205063b001528a403=
91678b0d093ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--YnfBVMPsuSk=--

