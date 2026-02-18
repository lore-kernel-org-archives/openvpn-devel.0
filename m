From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 11:51:43 +0000
In-Reply-To: <gerrit.1771415352000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
References: <gerrit.1771415352000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <536d9db961e524ac5b9230443798f890d1c0354f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GmJOOlGERPs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: auth-pam: fix
 discards 'const' qualifier from pointer target type
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

--GmJOOlGERPs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail

to look at the new patch set (#2).


Change subject: auth-pam: fix discards 'const' qualifier from pointer targe=
t type
......................................................................

auth-pam: fix discards 'const' qualifier from pointer target type

strstr now returns const char*.

Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
(cherry picked from commit 7212f49d2f773a4f0d28d1450b9ee0b369385ea5)
---
M src/plugins/auth-pam/utils.c
1 file changed, 1 insertion(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1545/2

diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 97befd6..bd5c382 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -66,12 +66,11 @@
     /* state: all parameters are valid */

     const char *searching =3D tosearch;
-    char *scratch;

     char temp[templen+1];
     temp[0] =3D 0;

-    scratch =3D strstr(searching, searchfor);
+    const char *scratch =3D strstr(searching, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Gerrit-Change-Number: 1545
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--GmJOOlGERPs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">auth-pam: fix discards &#39;const&#39; qualifier=
 from pointer target type<br><br>strstr now returns const char*.<br><br>Cha=
nge-Id: I632368451923116e0a169ddb5b6e86a8f8486afc<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>(cherry picked from commit 7212f49d2=
f773a4f0d28d1450b9ee0b369385ea5)<br>---<br>M src/plugins/auth-pam/utils.c<b=
r>1 file changed, 1 insertion(+), 2 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1545/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils=
.c</span><br><span>index 97befd6..bd5c382 100644</span><br><span>--- a/src/=
plugins/auth-pam/utils.c</span><br><span>+++ b/src/plugins/auth-pam/utils.c=
</span><br><span>@@ -66,12 +66,11 @@</span><br><span>     /* state: all par=
ameters are valid */</span><br><span> </span><br><span>     const char *sea=
rching =3D tosearch;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   char *scratch;</span><br><span> </span><br><span>     char temp[templen+=
1];</span><br><span>     temp[0] =3D 0;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    scratch =3D strstr(searching, searc=
hfor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *scratch =3D strstr(searching, searchfor);</span><br><span>     if (!scra=
tch)</span><br><span>     {</span><br><span>         return strdup(tosearch=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1545?usp=3Demail">change 1545</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1545?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I632368451923116e0a169ddb5b6=
e86a8f8486afc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--GmJOOlGERPs=--

