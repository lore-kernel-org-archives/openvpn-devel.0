From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 07:23:28 +0000
In-Reply-To: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
References: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a29613efd2ac22011d701ecbd90f18e87cc8472d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uOyG59nUSUE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uOyG59nUSUE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
66?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466
Message-Id: <20260112180304.8742-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
219.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socks.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 671d33c..078b4e1 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Gerrit-Change-Number: 1466
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uOyG59nUSUE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1466?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socks: Fix wrong success check in socks_username=
_password_auth<br><br>Due to wrong boolean operator the function did not<br=
>correctly detect when the authentication failed.<br><br>Reported-By: Joshu=
a Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https://zeropath=
.com)<br>Github: openvpn-private-issues#4<br>Change-Id: I13b411fb3e8b913ae0=
49c6ca8a1cf5a2edbab0fb<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1466<br>Message-Id: &lt;2026011218030=
4.8742-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg35219.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file changed, 1 i=
nsertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>i=
ndex 671d33c..078b4e1 100644</span><br><span>--- a/src/openvpn/socks.c</spa=
n><br><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -143,7 +143,7 @@</=
span><br><span>     }</span><br><span> </span><br><span>     /* VER =3D 5, =
SUCCESS =3D 0 --&gt; auth success */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (buf[0] !=3D 5 &amp;&amp; buf[1] !=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (buf[0] !=3D 5 || buf[1] =
!=3D 0)</span><br><span>     {</span><br><span>         msg(D_LINK_ERRORS, =
&quot;socks_username_password_auth: server refused the authentication&quot;=
);</span><br><span>         goto cleanup;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=
=3Demail">change 1466</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1=
cf5a2edbab0fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1466 </div>
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

--uOyG59nUSUE=--

