From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 13:43:23 +0000
References: <gerrit.1736862200000.I2791d09ab698d89dc7e0183151f77b84024ad6d1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d87c0c72c3c6dd06d7f978da27f368425f2f45f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PoCy5bl2yJY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 remove the timeout when using `systemd-ask-password`
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

--PoCy5bl2yJY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/866?usp=3Demail

to review the following change.


Change subject: console_systemd: remove the timeout when using `systemd-ask=
-password`
......................................................................

console_systemd: remove the timeout when using `systemd-ask-password`

Without this, the password request will expire after 90 seconds leaving
no way to provide the password without OpenVPN asking for it again.
Given that interactive use will wait for input without a timeout, it
makes sense to have non-interactive usage also wait until the user is
ready instead of forcing users to race against the timeout.

Change-Id: I2791d09ab698d89dc7e0183151f77b84024ad6d1
Signed-off-by: Ben Boeckel <ben.boeckel@...2851...>
Acked-By: David Sommerseth <davids@...515...>
---
M src/openvpn/console_systemd.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/866/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--PoCy5bl2yJY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/866?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">console_systemd: remove the timeout when using `systemd-ask-p=
assword`<br><br>Without this, the password request will expire after 90 sec=
onds leaving<br>no way to provide the password without OpenVPN asking for i=
t again.<br>Given that interactive use will wait for input without a timeou=
t, it<br>makes sense to have non-interactive usage also wait until the user=
 is<br>ready instead of forcing users to race against the timeout.<br><br>C=
hange-Id: I2791d09ab698d89dc7e0183151f77b84024ad6d1<br>Signed-off-by: Ben B=
oeckel &lt;ben.boeckel@...2851...&gt;<br>Acked-By: David Sommerseth &lt;dav=
ids@...515...&gt;<br>---<br>M src/openvpn/console_systemd.c<br>1 file chang=
ed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/66/866/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/co=
nsole_systemd.c b/src/openvpn/console_systemd.c</span><br><span>index 85850=
4d..91ebb35 100644</span><br><span>--- a/src/openvpn/console_systemd.c</spa=
n><br><span>+++ b/src/openvpn/console_systemd.c</span><br><span>@@ -72,6 +7=
2,7 @@</span><br><span>     }</span><br><span> #endif</span><br><span>     =
argv_printf_cat(&amp;argv, &quot;--icon network-vpn&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    argv_printf_cat(&amp;argv, &quo=
t;--timeout=3D0&quot;);</span><br><span>     argv_printf_cat(&amp;argv, &qu=
ot;%s&quot;, prompt);</span><br><span> </span><br><span>     if ((std_out =
=3D openvpn_popen(&amp;argv, NULL)) &lt; 0)</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/866?us=
p=3Demail">change 866</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/866?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2791d09ab698d89dc7e0183151f=
77b84024ad6d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 866 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--PoCy5bl2yJY=--

