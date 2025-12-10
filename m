From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 07:55:31 +0000
References: <gerrit.1765353329000.I07311f397e6cd278b90c33f024e927c282cd03e4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <41986998bb42874286b39f0bc4146898b2c1d49b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ouTJd3K8xGo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun.c: set IPv4
 address temporary on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ouTJd3K8xGo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3Demail

to review the following change.


Change subject: tun.c: set IPv4 address temporary on Windows
......................................................................

tun.c: set IPv4 address temporary on Windows

Use store=3Dactive to set IPv4 address temporary so that
it will be removed on reboot. This makes the behavior
consistent with deletion and IPv6, where we already use
store=3Dactive.

https://learn.microsoft.com/en-us/windows-server/administration/windows-com=
mands/netsh-interface

GitHub: https://github.com/OpenVPN/openvpn/issues/915

Change-Id: I07311f397e6cd278b90c33f024e927c282cd03e4
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1430/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0299285..849eddc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5119,8 +5119,8 @@
         }
         else
         {
-            /* example: netsh interface ip set address 42 static 10.3.0.1 =
255.255.255.0 */
-            argv_printf(&argv, "%s%s interface ip set address %lu static %=
s %s", get_win_sys_path(),
+            /* example: netsh interface ip set address 42 static 10.3.0.1 =
255.255.255.0 store=3Dactive */
+            argv_printf(&argv, "%s%s interface ip set address %lu static %=
s %s store=3Dactive", get_win_sys_path(),
                         NETSH_PATH_SUFFIX, adapter_index, print_in_addr_t(=
ip, 0, &gc),
                         print_in_addr_t(netmask, 0, &gc));


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07311f397e6cd278b90c33f024e927c282cd03e4
Gerrit-Change-Number: 1430
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ouTJd3K8xGo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>stipa would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tun.c: set IPv4 address temporary on Window=
s<br><br>Use store=3Dactive to set IPv4 address temporary so that<br>it wil=
l be removed on reboot. This makes the behavior<br>consistent with deletion=
 and IPv6, where we already use<br>store=3Dactive.<br><br>https://learn.mic=
rosoft.com/en-us/windows-server/administration/windows-commands/netsh-inter=
face<br><br>GitHub: https://github.com/OpenVPN/openvpn/issues/915<br><br>Ch=
ange-Id: I07311f397e6cd278b90c33f024e927c282cd03e4<br>Signed-off-by: Lev St=
ipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file change=
d, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/30/1430/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 0299285..=
849eddc 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ =
b/src/openvpn/tun.c</span><br><span>@@ -5119,8 +5119,8 @@</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /* example: netsh =
interface ip set address 42 static 10.3.0.1 255.255.255.0 */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            argv_printf(&amp;argv, &=
quot;%s%s interface ip set address %lu static %s %s&quot;, get_win_sys_path=
(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* e=
xample: netsh interface ip set address 42 static 10.3.0.1 255.255.255.0 sto=
re=3Dactive */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       argv_printf(&amp;argv, &quot;%s%s interface ip set address %lu stati=
c %s %s store=3Dactive&quot;, get_win_sys_path(),</span><br><span>         =
                NETSH_PATH_SUFFIX, adapter_index, print_in_addr_t(ip, 0, &a=
mp;gc),</span><br><span>                         print_in_addr_t(netmask, 0=
, &amp;gc));</span><br><span> </span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3Demail">c=
hange 1430</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07311f397e6cd278b90c33f024e=
927c282cd03e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1430 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ouTJd3K8xGo=--

