From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:00:52 +0000
In-Reply-To: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
References: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b1142adb69400234bdba393c4b1ca2ced602b367-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sQ+jrqzoELc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: fix
 discards 'const' qualifier from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sQ+jrqzoELc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
43?usp=3Demail )

Change subject: auth-pam: fix discards 'const' qualifier from pointer targe=
t type
......................................................................

auth-pam: fix discards 'const' qualifier from pointer target type

strstr now returns const char*.

Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543
Message-Id: <20260218214712.27119-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
728.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/plugins/auth-pam/utils.c
1 file changed, 1 insertion(+), 2 deletions(-)




diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index d7b544a..a4d2d0b 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -66,12 +66,11 @@
     /* state: all parameters are valid */

     const char *searching =3D tosearch;
-    char *scratch;

     char temp[templen + 1];
     temp[0] =3D 0;

-    scratch =3D strstr(searching, searchfor);
+    const char *scratch =3D strstr(searching, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Gerrit-Change-Number: 1543
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sQ+jrqzoELc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1543?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">auth-pam: fix discards &#39;const&#39; qualifier=
 from pointer target type<br><br>strstr now returns const char*.<br><br>Cha=
nge-Id: I632368451923116e0a169ddb5b6e86a8f8486afc<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543<br>Me=
ssage-Id: &lt;20260218214712.27119-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35728.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/plugins/au=
th-pam/utils.c<br>1 file changed, 1 insertion(+), 2 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c=
</span><br><span>index d7b544a..a4d2d0b 100644</span><br><span>--- a/src/pl=
ugins/auth-pam/utils.c</span><br><span>+++ b/src/plugins/auth-pam/utils.c</=
span><br><span>@@ -66,12 +66,11 @@</span><br><span>     /* state: all param=
eters are valid */</span><br><span> </span><br><span>     const char *searc=
hing =3D tosearch;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 char *scratch;</span><br><span> </span><br><span>     char temp[templen + =
1];</span><br><span>     temp[0] =3D 0;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    scratch =3D strstr(searching, searc=
hfor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *scratch =3D strstr(searching, searchfor);</span><br><span>     if (!scra=
tch)</span><br><span>     {</span><br><span>         return strdup(tosearch=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1543?usp=3Demail">change 1543</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1543?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I632368451923116e0a169ddb5b6=
e86a8f8486afc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1543 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--sQ+jrqzoELc=--

