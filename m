From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 3 Jul 2025 03:56:32 +0000
References: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1e751e26de29953125e6029499f8ebdf3d986cc6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QylsivAmPnY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mac dns: do not run
 dns-updown in parallel
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

--QylsivAmPnY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail

to review the following change.


Change subject: mac dns: do not run dns-updown in parallel
......................................................................

mac dns: do not run dns-updown in parallel

In case more than one openvpn connection is coming up or going down at
the same time, there is potential for breakage, since the operations
performed are not atomic.

Introduce a locking mechanism, which let's scripts run in sequence, to
prevent races between them.

Change-Id: I7adfaa08df6a17545cca8264d7230b5e65e49719
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 11 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1076/1

diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 282b034..536235e 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -26,6 +26,17 @@
 #   dns_server_1_sni dns.mycorp.in
 #

+i=3D1
+lockfile=3D/tmp/openvpn-dns-updown.lock
+while ! /usr/bin/shlock -f $lockfile -p $$; do
+    if [ $((++i)) -gt 10 ]; then
+        echo "dns-updown failed, could not acquire lock"
+        exit 1
+    fi
+    sleep 0.2
+done
+trap "/bin/rm -f ${lockfile}" EXIT
+
 [ -z "${dns_vars_file}" ] || . "${dns_vars_file}"

 itf_dns_key=3D"State:/Network/Service/openvpn-${dev}/DNS"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7adfaa08df6a17545cca8264d7230b5e65e49719
Gerrit-Change-Number: 1076
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--QylsivAmPnY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">mac dns: do not run dns-updown in parallel<br><br>In case mo=
re than one openvpn connection is coming up or going down at<br>the same ti=
me, there is potential for breakage, since the operations<br>performed are =
not atomic.<br><br>Introduce a locking mechanism, which let&#39;s scripts r=
un in sequence, to<br>prevent races between them.<br><br>Change-Id: I7adfaa=
08df6a17545cca8264d7230b5e65e49719<br>Signed-off-by: Heiko Hund &lt;heiko@...220...=
..2662...&gt;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<br>1 file =
changed, 11 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/76/1076/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/distro=
/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh</=
span><br><span>index 282b034..536235e 100644</span><br><span>--- a/distro/d=
ns-scripts/macos-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/mac=
os-dns-updown.sh</span><br><span>@@ -26,6 +26,17 @@</span><br><span> #   dn=
s_server_1_sni dns.mycorp.in</span><br><span> #</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+i=3D1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+lockfile=3D/tmp/openvpn-dns-updown.lock</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+while ! /usr/bin/shlo=
ck -f $lockfile -p $$; do</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if [ $((++i)) -gt 10 ]; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        echo &quot;dns-updown failed, could not acquire =
lock&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
xit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sleep 0.2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+done</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+trap &quot;/bin/rm -f ${lockfile}&quot; EXIT</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> [ -z =
&quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span><br>=
<span> </span><br><span> itf_dns_key=3D&quot;State:/Network/Service/openvpn=
-${dev}/DNS&quot;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail">change 1076</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1076?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7adfaa08df6a17545cca8264d72=
30b5e65e49719 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1076 </div>
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


--QylsivAmPnY=--

