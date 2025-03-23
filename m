From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 23 Mar 2025 12:06:42 +0000
References: <gerrit.1742731599000.I28a8abd0ee3fa9168a716171b0a405476089c4a1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c40e436ae0879108dbd2a075747a37794438c8f8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="af5a6DpR5O0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--af5a6DpR5O0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/912?usp=3Demail

to review the following change.


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

This commit fixes the if clause by correctly applying De Margan's law.

Change-Id: I28a8abd0ee3fa9168a716171b0a405476089c4a1
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/912/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--af5a6DpR5O0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/912?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix incorrect condition for checking password related check<b=
r><br>Commit db48cea chagned logic to move logic from a variable and repeat=
ed<br>checks to an if clause.<br><br>The old code had<br><br>            co=
nst bool ccnr =3D (options-&gt;auth_user_pass_verify_script<br>            =
                    || PLUGIN_OPTION_LIST(options)<br>                     =
           || MAN_CLIENT_AUTH_ENABLED(options));<br><br>followed by several=
 condition that checked !ccnr<br><br>This commit fixes the if clause by cor=
rectly applying De Margan&#39;s law.<br><br>Change-Id: I28a8abd0ee3fa9168a7=
16171b0a405476089c4a1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>---<br>M src/openvpn/options.c<br>1 file changed, 2 insertions(+), 2 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/12/912/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index 67ef55b..ab56609 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -2752,8 +2752,8 @@</span><br><span> </span><br><span>         }=
</span><br><span>         if (!options-&gt;auth_user_pass_verify_script</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            || PLUGIN_OPT=
ION_LIST(options)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        || MAN_CLIENT_AUTH_ENABLED(options))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &amp;&amp; !PLUGIN_OPTION_LIST(options=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&=
amp; !MAN_CLIENT_AUTH_ENABLED(options))</span><br><span>         {</span><b=
r><span>             const char *use_err =3D &quot;--%s must be used with -=
-management-client-auth, an --auth-user-pass-verify script, or plugin&quot;=
;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/912?usp=3Demail">change 912</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/912?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28a8abd0ee3fa9168a716171b0a=
405476089c4a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 912 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--af5a6DpR5O0=--

