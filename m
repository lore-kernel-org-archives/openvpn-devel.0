From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 09:16:39 +0000
In-Reply-To: <gerrit.1765353329000.I07311f397e6cd278b90c33f024e927c282cd03e4@...2715...>
References: <gerrit.1765353329000.I07311f397e6cd278b90c33f024e927c282cd03e4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <6ed76257f295533f5cc351e9ac0ca48683180ab4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hL0+FZ+xhdg="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hL0+FZ+xhdg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
30?usp=3Demail )

Change subject: tun.c: set IPv4 address temporary on Windows
......................................................................

tun.c: set IPv4 address temporary on Windows

Use store=3Dactive to set IPv4 address temporary so that
it will be removed on reboot. This makes the behavior
consistent with deletion and IPv6, where we already use
store=3Dactive.

https://learn.microsoft.com/en-us/windows-server/administration/windows-com=
mands/netsh-interface

GitHub: fixes OpenVPN/openvpn#915

Change-Id: I07311f397e6cd278b90c33f024e927c282cd03e4
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1430
Message-Id: <20251210075906.27693-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
975.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7236033..409cecb 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07311f397e6cd278b90c33f024e927c282cd03e4
Gerrit-Change-Number: 1430
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hL0+FZ+xhdg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1430?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tun.c: set IPv4 address temporary on Windows<br>=
<br>Use store=3Dactive to set IPv4 address temporary so that<br>it will be =
removed on reboot. This makes the behavior<br>consistent with deletion and =
IPv6, where we already use<br>store=3Dactive.<br><br>https://learn.microsof=
t.com/en-us/windows-server/administration/windows-commands/netsh-interface<=
br><br>GitHub: fixes OpenVPN/openvpn#915<br><br>Change-Id: I07311f397e6cd27=
8b90c33f024e927c282cd03e4<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1430<br>Message-Id: &lt;20251210075906.276=
93-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg34975.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 2 inserti=
ons(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 7236033..409cecb 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -5119,8 +5119,8 @@</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* examp=
le: netsh interface ip set address 42 static 10.3.0.1 255.255.255.0 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            argv_printf(&a=
mp;argv, &quot;%s%s interface ip set address %lu static %s %s&quot;, get_wi=
n_sys_path(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* example: netsh interface ip set address 42 static 10.3.0.1 255.255=
.255.0 store=3Dactive */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            argv_printf(&amp;argv, &quot;%s%s interface ip set address=
 %lu static %s %s store=3Dactive&quot;, get_win_sys_path(),</span><br><span=
>                         NETSH_PATH_SUFFIX, adapter_index, print_in_addr_t=
(ip, 0, &amp;gc),</span><br><span>                         print_in_addr_t(=
netmask, 0, &amp;gc));</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1430?usp=
=3Demail">change 1430</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1430?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07311f397e6cd278b90c33f024e=
927c282cd03e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1430 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--hL0+FZ+xhdg=--

