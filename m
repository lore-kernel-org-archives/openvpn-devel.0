From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 13 Aug 2025 14:12:26 +0000
References: <gerrit.1755094344000.Id800cad0e92e0abc0d96079fdb5a9d57578e1446@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c3edc8379014e2c6bb82ff3bab6686fde321cbad-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MGztJrLqUI8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: fix systemd
 dns-updown script
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

--MGztJrLqUI8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1144?usp=3Demail

to review the following change.


Change subject: dns: fix systemd dns-updown script
......................................................................

dns: fix systemd dns-updown script

In the resolvconf part of the script there was one instance of a dynamic
variable using _* left. The _* ones do not work as the regular ones, but
only when you directly place them within ${!}, not indirectly using a
variable.

Convert the code to use a loop and a check, like in all the other places
in the script.

Change-Id: Id800cad0e92e0abc0d96079fdb5a9d57578e1446
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/systemd-dns-updown.sh
1 file changed, 5 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1144/1

diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
index 9006e28..ed3947a 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -189,11 +189,13 @@
             domains+=3D"${!domain_var} "
         done
         {
+            local i=3D1
             local maxns=3D3
-            local server_var=3Ddns_server_${n}_address_*
-            for addr_var in ${!server_var}; do
-                [ $((maxns--)) -gt 0 ] || break
+            while [ "${i}" -le "${maxns}" ]; do
+                local addr_var=3Ddns_server_${n}_address_${i}
+                [ -n "${!addr_var}" ] || break
                 echo "nameserver ${!addr_var}"
+                i=3D$((i+1))
             done
             [ -z "$domains" ] || echo "search $domains"
         } | /sbin/resolvconf -a "$dev"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1144?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id800cad0e92e0abc0d96079fdb5a9d57578e1446
Gerrit-Change-Number: 1144
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--MGztJrLqUI8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1144?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: fix systemd dns-updown script<br><br>In the resolvconf =
part of the script there was one instance of a dynamic<br>variable using _*=
 left. The _* ones do not work as the regular ones, but<br>only when you di=
rectly place them within ${!}, not indirectly using a<br>variable.<br><br>C=
onvert the code to use a loop and a check, like in all the other places<br>=
in the script.<br><br>Change-Id: Id800cad0e92e0abc0d96079fdb5a9d57578e1446<=
br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M distro/dn=
s-scripts/systemd-dns-updown.sh<br>1 file changed, 5 insertions(+), 3 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/44/1144/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/distro/dns-scripts/systemd-dns-updown.sh=
 b/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>index 9006e28..=
ed3947a 100644</span><br><span>--- a/distro/dns-scripts/systemd-dns-updown.=
sh</span><br><span>+++ b/distro/dns-scripts/systemd-dns-updown.sh</span><br=
><span>@@ -189,11 +189,13 @@</span><br><span>             domains+=3D&quot;=
${!domain_var} &quot;</span><br><span>         done</span><br><span>       =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            loca=
l i=3D1</span><br><span>             local maxns=3D3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            local server_var=3Ddns_server_$=
{n}_address_*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    for addr_var in ${!server_var}; do</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                [ $((maxns--)) -gt 0 ] || break</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            while [ &quot;${i}=
&quot; -le &quot;${maxns}&quot; ]; do</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                local addr_var=3Ddns_server_${n}_address_=
${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 [ -n &quot;${!addr_var}&quot; ] || break</span><br><span>                 =
echo &quot;nameserver ${!addr_var}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                i=3D$((i+1))</span><br><span>         =
    done</span><br><span>             [ -z &quot;$domains&quot; ] || echo &=
quot;search $domains&quot;</span><br><span>         } | /sbin/resolvconf -a=
 &quot;$dev&quot;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1144?usp=3Demail">change 1144</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1144?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id800cad0e92e0abc0d96079fdb5=
a9d57578e1446 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1144 </div>
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


--MGztJrLqUI8=--

