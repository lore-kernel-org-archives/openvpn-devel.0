From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 3 Jul 2025 03:56:30 +0000
References: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4b5eb17d0f9acf689e61bd07ba9b49979fd6c7c1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uDSfDAYvmvI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mac dns: compare
 servers before restoring backup
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

--uDSfDAYvmvI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail

to review the following change.


Change subject: mac dns: compare servers before restoring backup
......................................................................

mac dns: compare servers before restoring backup

In case anything changed the global DNS server addresses, while the
tunnel was connected, do not restore the backup of the global DNS
configuration we made when connecting. Doing so would likely change
DNS to something unexpected. Instead just clear the backup and leave
a message in the log.

Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 14 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1075/1

diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 56f1009..282b034 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -111,6 +111,10 @@
     property_value State:/Network/Global/DNS SearchDomains
 }

+function get_server_addresses {
+    property_value State:/Network/Global/DNS ServerAddresses
+}
+
 function set_search_domains {
     [ -n "$1" ] || return
     local dns_key=3D$(primary_dns_key)
@@ -239,11 +243,10 @@

 function unset_dns {
     local n=3D"$(find_compat_profile)"
-    local addresses=3D"$(addresses_string $n)"
-    local search_domains=3D"$(search_domains_string $n)"
     local match_domains=3D"$(match_domains_string $n)"

     if [ -n "$match_domains" ]; then
+        local search_domains=3D"$(search_domains_string $n)"
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else
@@ -252,8 +255,15 @@
         [[ "${dns_backup_key}" =3D~ ${dev}/ ]] || return

         local cmds=3D""
-        cmds+=3D"get ${dns_backup_key}\n"
-        cmds+=3D"set $(primary_dns_key)\n"
+        local servers=3D"$(get_server_addresses)"
+        local addresses=3D"$(addresses_string $n)"
+        # Only restore backup if the server addresses match
+        if [ "${servers}" =3D "${addresses}" ]; then
+            cmds+=3D"get ${dns_backup_key}\n"
+            cmds+=3D"set $(primary_dns_key)\n"
+        else
+            echo "not restoring global DNS configuration, server addresses=
 have changed"
+        fi
         cmds+=3D"remove ${dns_backup_key}\n"
         echo -e "${cmds}" | /usr/sbin/scutil
     fi

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67
Gerrit-Change-Number: 1075
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--uDSfDAYvmvI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">mac dns: compare servers before restoring backup<br><br>In c=
ase anything changed the global DNS server addresses, while the<br>tunnel w=
as connected, do not restore the backup of the global DNS<br>configuration =
we made when connecting. Doing so would likely change<br>DNS to something u=
nexpected. Instead just clear the backup and leave<br>a message in the log.=
<br><br>Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67<br>Signed-off-=
by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M distro/dns-scripts/maco=
s-dns-updown.sh<br>1 file changed, 14 insertions(+), 4 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1075/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scr=
ipts/macos-dns-updown.sh</span><br><span>index 56f1009..282b034 100644</spa=
n><br><span>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>++=
+ b/distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -111,6 +111,1=
0 @@</span><br><span>     property_value State:/Network/Global/DNS SearchDo=
mains</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+function get_server_addresses {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    property_value State:/Network/Global=
/DNS ServerAddresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 function set_search_domains {</span><br><span>     [ -n &quot;$1&quot; ] |=
| return</span><br><span>     local dns_key=3D$(primary_dns_key)</span><br>=
<span>@@ -239,11 +243,10 @@</span><br><span> </span><br><span> function uns=
et_dns {</span><br><span>     local n=3D&quot;$(find_compat_profile)&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local addresses=3D=
&quot;$(addresses_string $n)&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    local search_domains=3D&quot;$(search_domains_string $n)&q=
uot;</span><br><span>     local match_domains=3D&quot;$(match_domains_strin=
g $n)&quot;</span><br><span> </span><br><span>     if [ -n &quot;$match_dom=
ains&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       local search_domains=3D&quot;$(search_domains_string $n)&quot;</span=
><br><span>         echo &quot;remove ${itf_dns_key}&quot; | /usr/sbin/scut=
il</span><br><span>         unset_search_domains &quot;$search_domains&quot=
;</span><br><span>     else</span><br><span>@@ -252,8 +255,15 @@</span><br>=
<span>         [[ &quot;${dns_backup_key}&quot; =3D~ ${dev}/ ]] || return</=
span><br><span> </span><br><span>         local cmds=3D&quot;&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cmds+=3D&quot;get ${d=
ns_backup_key}\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        cmds+=3D&quot;set $(primary_dns_key)\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        local servers=3D&quot;$(get_serve=
r_addresses)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       local addresses=3D&quot;$(addresses_string $n)&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # Only restore backup if th=
e server addresses match</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if [ &quot;${servers}&quot; =3D &quot;${addresses}&quot; ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cmds+=
=3D&quot;get ${dns_backup_key}\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            cmds+=3D&quot;set $(primary_dns_key)\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;not=
 restoring global DNS configuration, server addresses have changed&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><=
span>         cmds+=3D&quot;remove ${dns_backup_key}\n&quot;</span><br><spa=
n>         echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><span> =
    fi</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail">change 1075</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1075?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aabd62e60dd18408a57baccbb0=
f4ebd6d2f8d67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1075 </div>
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


--uDSfDAYvmvI=--

