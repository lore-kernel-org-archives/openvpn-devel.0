From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 14:02:47 +0000
In-Reply-To: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
References: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <37f4a196cbab5bd98b76878583bf2ce543d185e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5mvtQ2ViQxU="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5mvtQ2ViQxU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
75?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250711152309.286177-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
110.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 14 insertions(+), 4 deletions(-)




diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 56f1009..73bbee9 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -111,6 +111,10 @@
     property_value State:/Network/Global/DNS SearchDomains
 }

+function get_server_addresses {
+    property_value "$(primary_dns_key)" ServerAddresses
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
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--5mvtQ2ViQxU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1075?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">mac dns: compare servers before restoring bac=
kup<br><br>In case anything changed the global DNS server addresses, while =
the<br>tunnel was connected, do not restore the backup of the global DNS<br=
>configuration we made when connecting. Doing so would likely change<br>DNS=
 to something unexpected. Instead just clear the backup and leave<br>a mess=
age in the log.<br><br>Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67=
<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250711152309.28617=
7-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg32110.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<br>1 fi=
le changed, 14 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts=
/macos-dns-updown.sh</span><br><span>index 56f1009..73bbee9 100644</span><b=
r><span>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++ b/=
distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -111,6 +111,10 @@=
</span><br><span>     property_value State:/Network/Global/DNS SearchDomain=
s</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+function get_server_addresses {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    property_value &quot;$(primary_dns_key)&=
quot; ServerAddresses</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> function set_search_domains {</span><br><span>     [ -n &quot;$1&quot; ] =
|| return</span><br><span>     local dns_key=3D$(primary_dns_key)</span><br=
><span>@@ -239,11 +243,10 @@</span><br><span> </span><br><span> function un=
set_dns {</span><br><span>     local n=3D&quot;$(find_compat_profile)&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local addresses=
=3D&quot;$(addresses_string $n)&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    local search_domains=3D&quot;$(search_domains_string $n=
)&quot;</span><br><span>     local match_domains=3D&quot;$(match_domains_st=
ring $n)&quot;</span><br><span> </span><br><span>     if [ -n &quot;$match_=
domains&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        local search_domains=3D&quot;$(search_domains_string $n)&quot;</s=
pan><br><span>         echo &quot;remove ${itf_dns_key}&quot; | /usr/sbin/s=
cutil</span><br><span>         unset_search_domains &quot;$search_domains&q=
uot;</span><br><span>     else</span><br><span>@@ -252,8 +255,15 @@</span><=
br><span>         [[ &quot;${dns_backup_key}&quot; =3D~ ${dev}/ ]] || retur=
n</span><br><span> </span><br><span>         local cmds=3D&quot;&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmds+=3D&quot;get =
${dns_backup_key}\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        cmds+=3D&quot;set $(primary_dns_key)\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        local servers=3D&quot;$(get_se=
rver_addresses)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        local addresses=3D&quot;$(addresses_string $n)&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # Only restore backup if=
 the server addresses match</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if [ &quot;${servers}&quot; =3D &quot;${addresses}&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cm=
ds+=3D&quot;get ${dns_backup_key}\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            cmds+=3D&quot;set $(primary_dns_key)\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;=
not restoring global DNS configuration, server addresses have changed&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><b=
r><span>         cmds+=3D&quot;remove ${dns_backup_key}\n&quot;</span><br><=
span>         echo -e &quot;${cmds}&quot; | /usr/sbin/scutil</span><br><spa=
n>     fi</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail">change 1075</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1075?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aabd62e60dd18408a57baccbb0=
f4ebd6d2f8d67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1075 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--5mvtQ2ViQxU=--

