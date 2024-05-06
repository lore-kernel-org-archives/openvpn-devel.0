From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 6 May 2024 13:50:31 +0000
References: <gerrit.1715003428000.Ie2b62bc95371daf7e1eb58e0323835f169399910@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d0473c7b5b612861479316bf196417acb4d8b491-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0V9oKKfUcCw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Repeat the unknown
 command in errors from management interface
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

--0V9oKKfUcCw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail

to review the following change.


Change subject: Repeat the unknown command in errors from management interf=
ace
......................................................................

Repeat the unknown command in errors from management interface

This help pinpointing errors in logs from my app

Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/manage.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/584/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 43c5507..415ee7a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1663,7 +1663,7 @@
 #endif
     else
     {
-        msg(M_CLIENT, "ERROR: unknown command, enter 'help' for more optio=
ns");
+        msg(M_CLIENT, "ERROR: unknown command [%s], enter 'help' for more =
options", p[0]);
     }

 done:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910
Gerrit-Change-Number: 584
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0V9oKKfUcCw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Repeat the unknown command in errors from management interfac=
e<br><br>This help pinpointing errors in logs from my app<br><br>Change-Id:=
 Ie2b62bc95371daf7e1eb58e0323835f169399910<br>Signed-off-by: Arne Schwabe &=
lt;arne@...1227...&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, =
1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/84/584/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.=
c b/src/openvpn/manage.c</span><br><span>index 43c5507..415ee7a 100644</spa=
n><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/ma=
nage.c</span><br><span>@@ -1663,7 +1663,7 @@</span><br><span> #endif</span>=
<br><span>     else</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;ERROR: unknown command, en=
ter &#39;help&#39; for more options&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: unknown command =
[%s], enter &#39;help&#39; for more options&quot;, p[0]);</span><br><span> =
    }</span><br><span> </span><br><span> done:</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/584=
?usp=3Demail">change 584</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2b62bc95371daf7e1eb58e0323=
835f169399910 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 584 </div>
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


--0V9oKKfUcCw=--

