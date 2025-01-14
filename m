From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 17:18:06 +0000
In-Reply-To: <gerrit.1736862200000.I2791d09ab698d89dc7e0183151f77b84024ad6d1@...2715...>
References: <gerrit.1736862200000.I2791d09ab698d89dc7e0183151f77b84024ad6d1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cb896c7b6eef39e6993ed2037a260ccb9ed9adfc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tUmQRKZDTbQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 remove the timeout when using 'systemd-ask-password'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tUmQRKZDTbQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/866?usp=3Demail )


Change subject: console_systemd: remove the timeout when using 'systemd-ask=
-password'
......................................................................

console_systemd: remove the timeout when using 'systemd-ask-password'

Without this, the password request will expire after 90 seconds leaving
no way to provide the password without OpenVPN asking for it again.
Given that interactive use will wait for input without a timeout, it
makes sense to have non-interactive usage also wait until the user is
ready instead of forcing users to race against the timeout.

Change-Id: I2791d09ab698d89dc7e0183151f77b84024ad6d1
Signed-off-by: Ben Boeckel <ben.boeckel@...2851...>
Acked-By: David Sommerseth <davids@...515...>
Message-Id: <20241231204629.1210040-2-ben.boeckel@...2851...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
336.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/console_systemd.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/866/2

diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 858504d..91ebb35 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -72,6 +72,7 @@
     }
 #endif
     argv_printf_cat(&argv, "--icon network-vpn");
+    argv_printf_cat(&argv, "--timeout=3D0");
     argv_printf_cat(&argv, "%s", prompt);

     if ((std_out =3D openvpn_popen(&argv, NULL)) < 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/866?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2791d09ab698d89dc7e0183151f77b84024ad6d1
Gerrit-Change-Number: 866
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--tUmQRKZDTbQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/866?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">console_systemd: remove the timeout whe=
n using &#39;systemd-ask-password&#39;<br><br>Without this, the password re=
quest will expire after 90 seconds leaving<br>no way to provide the passwor=
d without OpenVPN asking for it again.<br>Given that interactive use will w=
ait for input without a timeout, it<br>makes sense to have non-interactive =
usage also wait until the user is<br>ready instead of forcing users to race=
 against the timeout.<br><br>Change-Id: I2791d09ab698d89dc7e0183151f77b8402=
4ad6d1<br>Signed-off-by: Ben Boeckel &lt;ben.boeckel@...2851...&gt;<br>Acke=
d-By: David Sommerseth &lt;davids@...515...&gt;<br>Message-Id: &lt;20241231=
204629.1210040-2-ben.boeckel@...2851...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg30336.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/console_systemd=
.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/66/866/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c</span><=
br><span>index 858504d..91ebb35 100644</span><br><span>--- a/src/openvpn/co=
nsole_systemd.c</span><br><span>+++ b/src/openvpn/console_systemd.c</span><=
br><span>@@ -72,6 +72,7 @@</span><br><span>     }</span><br><span> #endif</=
span><br><span>     argv_printf_cat(&amp;argv, &quot;--icon network-vpn&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf=
_cat(&amp;argv, &quot;--timeout=3D0&quot;);</span><br><span>     argv_print=
f_cat(&amp;argv, &quot;%s&quot;, prompt);</span><br><span> </span><br><span=
>     if ((std_out =3D openvpn_popen(&amp;argv, NULL)) &lt; 0)</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/866?usp=3Demail">change 866</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/866?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2791d09ab698d89dc7e0183151f=
77b84024ad6d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 866 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tUmQRKZDTbQ=--

