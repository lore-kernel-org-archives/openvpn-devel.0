From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 19 Aug 2025 10:52:00 +0000
In-Reply-To: <gerrit.1755094344000.Id800cad0e92e0abc0d96079fdb5a9d57578e1446@...2715...>
References: <gerrit.1755094344000.Id800cad0e92e0abc0d96079fdb5a9d57578e1446@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a8bf7cfd0d66cabe7718db2c1be4b5ece04fba33-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BNCvLY32xao="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BNCvLY32xao=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
44?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250818164608.39836-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
621.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/systemd-dns-updown.sh
1 file changed, 5 insertions(+), 3 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--BNCvLY32xao=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1144?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: fix systemd dns-updown script<br><br>In =
the resolvconf part of the script there was one instance of a dynamic<br>va=
riable using _* left. The _* ones do not work as the regular ones, but<br>o=
nly when you directly place them within ${!}, not indirectly using a<br>var=
iable.<br><br>Convert the code to use a loop and a check, like in all the o=
ther places<br>in the script.<br><br>Change-Id: Id800cad0e92e0abc0d96079fdb=
5a9d57578e1446<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202508=
18164608.39836-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg32621.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M distro/dns-scripts/systemd-dns-up=
down.sh<br>1 file changed, 5 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scrip=
ts/systemd-dns-updown.sh</span><br><span>index 9006e28..ed3947a 100644</spa=
n><br><span>--- a/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>=
+++ b/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>@@ -189,11 +=
189,13 @@</span><br><span>             domains+=3D&quot;${!domain_var} &quo=
t;</span><br><span>         done</span><br><span>         {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            local i=3D1</span><br><=
span>             local maxns=3D3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            local server_var=3Ddns_server_${n}_address_*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            for addr_var in =
${!server_var}; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             [ $((maxns--)) -gt 0 ] || break</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            while [ &quot;${i}&quot; -le &quot;${m=
axns}&quot; ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              local addr_var=3Ddns_server_${n}_address_${i}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                [ -n &quot;${!addr_=
var}&quot; ] || break</span><br><span>                 echo &quot;nameserve=
r ${!addr_var}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                i=3D$((i+1))</span><br><span>             done</span><br><=
span>             [ -z &quot;$domains&quot; ] || echo &quot;search $domains=
&quot;</span><br><span>         } | /sbin/resolvconf -a &quot;$dev&quot;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1144?usp=3Demail">change 1144</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1144?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id800cad0e92e0abc0d96079fdb5=
a9d57578e1446 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1144 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--BNCvLY32xao=--

