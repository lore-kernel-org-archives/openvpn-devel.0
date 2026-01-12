From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 12 Jan 2026 14:19:25 +0000
References: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6927f293386f37439ef2badd02e25fc730b072b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Js4y4pzC3Yc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: Fix wrong
 success check in socks_username_password_auth
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

--Js4y4pzC3Yc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail

to review the following change.


Change subject: socks: Fix wrong success check in socks_username_password_a=
uth
......................................................................

socks: Fix wrong success check in socks_username_password_auth

Due to wrong boolean operator the function did not
correctly detect when the authentication failed.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#4
Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socks.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1466/1

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ed2d9e9..1e99c9a 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -143,7 +143,7 @@
     }

     /* VER =3D 5, SUCCESS =3D 0 --> auth success */
-    if (buf[0] !=3D 5 && buf[1] !=3D 0)
+    if (buf[0] !=3D 5 || buf[1] !=3D 0)
     {
         msg(D_LINK_ERRORS, "socks_username_password_auth: server refused t=
he authentication");
         goto cleanup;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Gerrit-Change-Number: 1466
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Js4y4pzC3Yc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socks: Fix wrong success check in socks_use=
rname_password_auth<br><br>Due to wrong boolean operator the function did n=
ot<br>correctly detect when the authentication failed.<br><br>Reported-By: =
Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https://zer=
opath.com)<br>Github: openvpn-private-issues#4<br>Change-Id: I13b411fb3e8b9=
13ae049c6ca8a1cf5a2edbab0fb<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/66/1466/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/socks.c b/src/openvpn/socks.c</span><br><span>index ed2d9e9..1e99c9a 10064=
4</span><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openv=
pn/socks.c</span><br><span>@@ -143,7 +143,7 @@</span><br><span>     }</span=
><br><span> </span><br><span>     /* VER =3D 5, SUCCESS =3D 0 --&gt; auth s=
uccess */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf[=
0] !=3D 5 &amp;&amp; buf[1] !=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (buf[0] !=3D 5 || buf[1] !=3D 0)</span><br><span>   =
  {</span><br><span>         msg(D_LINK_ERRORS, &quot;socks_username_passwo=
rd_auth: server refused the authentication&quot;);</span><br><span>        =
 goto cleanup;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail">change 1466</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1=
cf5a2edbab0fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1466 </div>
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

--Js4y4pzC3Yc=--

