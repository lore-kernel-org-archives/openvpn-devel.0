From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 14:10:10 +0000
In-Reply-To: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
References: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6d4379c8a29df93cc939222cbd8cb3e532f778b0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nItMJyzDBGw="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nItMJyzDBGw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
76?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250711100700.241668-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
108.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/macos-dns-updown.sh
1 file changed, 17 insertions(+), 0 deletions(-)




diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/ma=
cos-dns-updown.sh
index 73bbee9..fb17b2b0 100644
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
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--nItMJyzDBGw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1076?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">mac dns: do not run dns-updown in parallel<br=
><br>In case more than one openvpn connection is coming up or going down at=
<br>the same time, there is potential for breakage, since the operations<br=
>performed are not atomic.<br><br>Introduce a locking mechanism, which let&=
#39;s scripts run in sequence, to<br>prevent races between them.<br><br>Cha=
nge-Id: I7adfaa08df6a17545cca8264d7230b5e65e49719<br>Signed-off-by: Heiko H=
und &lt;heiko@...2662...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...493...=
1227...&gt;<br>Message-Id: &lt;20250711100700.241668-1-frank@...2641...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg32108.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M distro/dns-scripts/macos-dns-updown.sh<br>1 file changed, 17 insertion=
s(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts=
/macos-dns-updown.sh</span><br><span>index 73bbee9..fb17b2b0 100644</span><=
br><span>--- a/distro/dns-scripts/macos-dns-updown.sh</span><br><span>+++ b=
/distro/dns-scripts/macos-dns-updown.sh</span><br><span>@@ -26,6 +26,23 @@<=
/span><br><span> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+lockdi=
r=3D/var/lock</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ !=
 -d &quot;${lockdir}&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /bin/mkdir &quot;${lockdir}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /bin/chmod 1777 &quot;${lockdir}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+i=3D1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+lockfile=3D&quot;${lockdir}/openvpn-dns-updown.lock&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+while ! /usr/bin/shlock -f $lo=
ckfile -p $$; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if [ $((++i)) -gt 10 ]; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        echo &quot;dns-updown failed, could not acquire lock&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sleep 0.2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+trap &quot;/bin/rm -f ${lockfile}&quot; EXIT</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> [ -z &quot;${=
dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span><br><span> <=
/span><br><span> itf_dns_key=3D&quot;State:/Network/Service/openvpn-${dev}/=
DNS&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1076?usp=3Demail">change 1076</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1076?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7adfaa08df6a17545cca8264d72=
30b5e65e49719 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1076 </div>
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


--nItMJyzDBGw=--

