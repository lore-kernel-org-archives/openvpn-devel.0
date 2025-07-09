From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 9 Jul 2025 08:57:04 +0000
In-Reply-To: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
References: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d75956ca0364ae238705f0643dd5e09d4dbb69e7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dQNAIfpOpc0="; charset=UTF-8
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

--dQNAIfpOpc0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail

to look at the new patch set (#3).


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
1 file changed, 17 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1076/3

diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 282b034..065a725 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -26,6 +26,23 @@
 #   dns_server_1_sni dns.mycorp.in
 #

+lockdir=3D/var/lock
+if [ ! -d "${lockdir}" ]; then
+    /bin/mkdir "${lockdir}"
+    /bin/chmod 1777 "${lockdir}"
+fi
+
+i=3D1
+lockfile=3D"${lockdir}/openvpn-dns-updown.lock"
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
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--dQNAIfpOpc0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">mac dns: do not run dns-updown in parallel<br><br>In case more than one =
openvpn connection is coming up or going down at<br>the same time, there is=
 potential for breakage, since the operations<br>performed are not atomic.<=
br><br>Introduce a locking mechanism, which let&#39;s scripts run in sequen=
ce, to<br>prevent races between them.<br><br>Change-Id: I7adfaa08df6a17545c=
ca8264d7230b5e65e49719<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt=
;<br>---<br>M distro/dns-scripts/macos-dns-updown.sh<br>1 file changed, 17 =
insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/76/1076/3</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/distro/dns-scripts=
/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh</span><br><sp=
an>index 282b034..065a725 100644</span><br><span>--- a/distro/dns-scripts/m=
acos-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/macos-dns-updow=
n.sh</span><br><span>@@ -26,6 +26,23 @@</span><br><span> #   dns_server_1_s=
ni dns.mycorp.in</span><br><span> #</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+lockdir=3D/var/lock</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ ! -d &quot;${lockdir}&quot; ]; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /bin/mkdir &quot=
;${lockdir}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /bin/chmod 1777 &quot;${lockdir}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=3D1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+lockfile=3D&quot;${lockdir}/o=
penvpn-dns-updown.lock&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+while ! /usr/bin/shlock -f $lockfile -p $$; do</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if [ $((++i)) -gt 10 ]; then</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;dns-upd=
own failed, could not acquire lock&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    sleep 0.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+don=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+trap &quot;/bin/rm=
 -f ${lockfile}&quot; EXIT</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> [ -z &quot;${dns_vars_file}&quot; ] || . &quot;${d=
ns_vars_file}&quot;</span><br><span> </span><br><span> itf_dns_key=3D&quot;=
State:/Network/Service/openvpn-${dev}/DNS&quot;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/10=
76?usp=3Demail">change 1076</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7adfaa08df6a17545cca8264d72=
30b5e65e49719 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1076 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--dQNAIfpOpc0=--

