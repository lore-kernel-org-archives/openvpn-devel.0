From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 09:26:37 +0000
In-Reply-To: <gerrit.1750848307000.I7b413578a8fc0c65fca26f72b901a9f7bc34b137@...2715...>
References: <gerrit.1750848307000.I7b413578a8fc0c65fca26f72b901a9f7bc34b137@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9c5fcf9f5d86195510e4cf8f6ea62e093c472110-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NSsfH6sHqdU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: fix macOS
 dns-updown handling of parallel full redirects
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

--NSsfH6sHqdU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1066?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: fix macOS dns-updown handling of parallel full redirects
......................................................................

fix macOS dns-updown handling of parallel full redirects

The script didn't handle scenarios well where two or more parallel VPN
connections want to replace the default DNS server. The DNS configuration
has a chance to get broken by the connections going down in a different
order than they came up in.

Disallowing all but the first connection to modify the default DNS server
will effectively prevent this issue. While it may break DNS for the
latter connections, it is the best we can do without knowing specifics
about the configurations.

Change-Id: I7b413578a8fc0c65fca26f72b901a9f7bc34b137
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250626091959.23505-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
988.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 9 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1066/3

diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 89d6882..c15abaa 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -30,6 +30,7 @@

 itf_dns_key=3D"State:/Network/Service/openvpn-${dev}/DNS"
 dns_backup_key=3D"State:/Network/Service/openvpn-${dev}/DnsBackup"
+dns_backup_key_pattern=3D"State:/Network/Service/openvpn-.*/DnsBackup"

 function primary_dns_key {
     local uuid=3D$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scut=
il | grep "PrimaryService" | cut -d: -f2 | xargs)
@@ -166,6 +167,11 @@
         echo -e "${cmds}" | /usr/sbin/scutil
         set_search_domains "$search_domains"
     else
+        echo list ${dns_backup_key_pattern} | /usr/sbin/scutil | grep -q '=
no key' || {
+            echo "setting DNS failed, already redirecting to another tunne=
l"
+            exit 1
+        }
+
         local cmds=3D""
         cmds+=3D"get $(primary_dns_key)\n"
         cmds+=3D"set ${dns_backup_key}\n"
@@ -200,6 +206,9 @@
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else
+        # Do not unset if this tunnel did not set/backup DNS before
+        echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv 'no key'=
 || return
+
         local cmds=3D""
         cmds+=3D"get ${dns_backup_key}\n"
         cmds+=3D"set $(primary_dns_key)\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1066?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b413578a8fc0c65fca26f72b901a9f7bc34b137
Gerrit-Change-Number: 1066
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--NSsfH6sHqdU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1066=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">fix macOS dns-updown handling of parallel full r=
edirects<br><br>The script didn&#39;t handle scenarios well where two or mo=
re parallel VPN<br>connections want to replace the default DNS server. The =
DNS configuration<br>has a chance to get broken by the connections going do=
wn in a different<br>order than they came up in.<br><br>Disallowing all but=
 the first connection to modify the default DNS server<br>will effectively =
prevent this issue. While it may break DNS for the<br>latter connections, i=
t is the best we can do without knowing specifics<br>about the configuratio=
ns.<br><br>Change-Id: I7b413578a8fc0c65fca26f72b901a9f7bc34b137<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Arne Schwabe &lt;ar=
ne-openvpn@...1227...&gt;<br>Message-Id: &lt;20250626091959.23505-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg31988.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<br>1 file changed, =
9 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/66/1066/3</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/distro/dns-scrip=
ts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh</span><br><=
span>index 89d6882..c15abaa 100644</span><br><span>--- a/distro/dns-scripts=
/macos-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/macos-dns-upd=
own.sh</span><br><span>@@ -30,6 +30,7 @@</span><br><span> </span><br><span>=
 itf_dns_key=3D&quot;State:/Network/Service/openvpn-${dev}/DNS&quot;</span>=
<br><span> dns_backup_key=3D&quot;State:/Network/Service/openvpn-${dev}/Dns=
Backup&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_bac=
kup_key_pattern=3D&quot;State:/Network/Service/openvpn-.*/DnsBackup&quot;</=
span><br><span> </span><br><span> function primary_dns_key {</span><br><spa=
n>     local uuid=3D$(echo &quot;show State:/Network/Global/IPv4&quot; | /u=
sr/sbin/scutil | grep &quot;PrimaryService&quot; | cut -d: -f2 | xargs)</sp=
an><br><span>@@ -166,6 +167,11 @@</span><br><span>         echo -e &quot;${=
cmds}&quot; | /usr/sbin/scutil</span><br><span>         set_search_domains =
&quot;$search_domains&quot;</span><br><span>     else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo list ${dns_backup_key_patter=
n} | /usr/sbin/scutil | grep -q &#39;no key&#39; || {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;setting DNS failed=
, already redirecting to another tunnel&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            exit 1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>         local cmds=3D&quot;&quot;</span><b=
r><span>         cmds+=3D&quot;get $(primary_dns_key)\n&quot;</span><br><sp=
an>         cmds+=3D&quot;set ${dns_backup_key}\n&quot;</span><br><span>@@ =
-200,6 +206,9 @@</span><br><span>         echo &quot;remove ${itf_dns_key}&=
quot; | /usr/sbin/scutil</span><br><span>         unset_search_domains &quo=
t;$search_domains&quot;</span><br><span>     else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        # Do not unset if this tunnel did not=
 set/backup DNS before</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv &#39;n=
o key&#39; || return</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>         local cmds=3D&quot;&quot;</span><br><span>      =
   cmds+=3D&quot;get ${dns_backup_key}\n&quot;</span><br><span>         cmd=
s+=3D&quot;set $(primary_dns_key)\n&quot;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1066?usp=
=3Demail">change 1066</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1066?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b413578a8fc0c65fca26f72b90=
1a9f7bc34b137 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1066 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--NSsfH6sHqdU=--

