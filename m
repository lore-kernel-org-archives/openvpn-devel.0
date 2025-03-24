From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 07:20:37 +0000
In-Reply-To: <gerrit.1742731599000.I28a8abd0ee3fa9168a716171b0a405476089c4a1@...2715...>
References: <gerrit.1742731599000.I28a8abd0ee3fa9168a716171b0a405476089c4a1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <3cddf1d0c22b0df5763cff2053df0e8952032609-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Za+tDmfZZYo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix incorrect
 condition for checking password related check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Za+tDmfZZYo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
2?usp=3Demail )

Change subject: Fix incorrect condition for checking password related check
......................................................................

Fix incorrect condition for checking password related check

Commit db48cea chagned logic to move logic from a variable and repeated
checks to an if clause.

The old code had

            const bool ccnr =3D (options->auth_user_pass_verify_script
                                || PLUGIN_OPTION_LIST(options)
                                || MAN_CLIENT_AUTH_ENABLED(options));

followed by several condition that checked !ccnr

This commit fixes the if clause by correctly applying De Morgan's law.

Github: closes OpenVPN/openvpn#706

Change-Id: I28a8abd0ee3fa9168a716171b0a405476089c4a1
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Message-Id: <20250323211359.14117-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59164222/
URL: http://gerrit.openvpn.net/c/openvpn/+/912
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 67ef55b..ab56609 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2752,8 +2752,8 @@

         }
         if (!options->auth_user_pass_verify_script
-            || PLUGIN_OPTION_LIST(options)
-            || MAN_CLIENT_AUTH_ENABLED(options))
+            && !PLUGIN_OPTION_LIST(options)
+            && !MAN_CLIENT_AUTH_ENABLED(options))
         {
             const char *use_err =3D "--%s must be used with --management-c=
lient-auth, an --auth-user-pass-verify script, or plugin";


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/912?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I28a8abd0ee3fa9168a716171b0a405476089c4a1
Gerrit-Change-Number: 912
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Za+tDmfZZYo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/912?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix incorrect condition for checking password =
related check<br><br>Commit db48cea chagned logic to move logic from a vari=
able and repeated<br>checks to an if clause.<br><br>The old code had<br><br=
>            const bool ccnr =3D (options-&gt;auth_user_pass_verify_script<=
br>                                || PLUGIN_OPTION_LIST(options)<br>      =
                          || MAN_CLIENT_AUTH_ENABLED(options));<br><br>foll=
owed by several condition that checked !ccnr<br><br>This commit fixes the i=
f clause by correctly applying De Morgan&#39;s law.<br><br>Github: closes O=
penVPN/openvpn#706<br><br>Change-Id: I28a8abd0ee3fa9168a716171b0a405476089c=
4a1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Ant=
onio Quartulli &lt;antonio@...2726...&gt;<br>Message-Id: &lt;20250323211359=
.14117-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mail=
man/message/59164222/<br>URL: http://gerrit.openvpn.net/c/openvpn/+/912<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
/options.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 67ef55b..ab56609 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2752,8 +2=
752,8 @@</span><br><span> </span><br><span>         }</span><br><span>     =
    if (!options-&gt;auth_user_pass_verify_script</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            || PLUGIN_OPTION_LIST(options)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            || MAN_CLIENT_=
AUTH_ENABLED(options))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; !PLUGIN_OPTION_LIST(options)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !MAN_CLIENT_AUTH_=
ENABLED(options))</span><br><span>         {</span><br><span>             c=
onst char *use_err =3D &quot;--%s must be used with --management-client-aut=
h, an --auth-user-pass-verify script, or plugin&quot;;</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/912?usp=3Demail">change 912</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/912?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28a8abd0ee3fa9168a716171b0a=
405476089c4a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 912 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Za+tDmfZZYo=--

