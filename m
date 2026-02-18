From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 11:49:17 +0000
References: <gerrit.1771415352000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2652dfd778c9fcdc1e48ccf79529d13cc6dcafbd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QWEk8v0n2ro="; charset=UTF-8
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

--QWEk8v0n2ro=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail

to review the following change.


Change subject: auth-pam: fix discards 'const' qualifier from pointer targe=
t type
......................................................................

auth-pam: fix discards 'const' qualifier from pointer target type

strstr now returns const char*.

Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/plugins/auth-pam/utils.c
1 file changed, 1 insertion(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1545/1

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Gerrit-Change-Number: 1545
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--QWEk8v0n2ro=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">auth-pam: fix discards &#39;const&#39; qual=
ifier from pointer target type<br><br>strstr now returns const char*.<br><b=
r>Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/plugins/auth-pam/u=
tils.c<br>1 file changed, 1 insertion(+), 2 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/15=
45/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-p=
am/utils.c</span><br><span>index 97befd6..bd5c382 100644</span><br><span>--=
- a/src/plugins/auth-pam/utils.c</span><br><span>+++ b/src/plugins/auth-pam=
/utils.c</span><br><span>@@ -66,12 +66,11 @@</span><br><span>     /* state:=
 all parameters are valid */</span><br><span> </span><br><span>     const c=
har *searching =3D tosearch;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    char *scratch;</span><br><span> </span><br><span>     char temp[=
templen+1];</span><br><span>     temp[0] =3D 0;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    scratch =3D strstr(searchin=
g, searchfor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *scratch =3D strstr(searching, searchfor);</span><br><span>     i=
f (!scratch)</span><br><span>     {</span><br><span>         return strdup(=
tosearch);</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail">change 1545</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1545?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I632368451923116e0a169ddb5b6=
e86a8f8486afc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--QWEk8v0n2ro=--

