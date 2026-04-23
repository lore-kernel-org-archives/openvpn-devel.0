From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 23 Apr 2026 00:12:29 +0000
References: <gerrit.1776903146000.I4d46c3672691b159cbd98a17020c4f30782bc202@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6255c5d3e20e479530c456341fdb38505064add6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S2prT2TVQs0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fixup: prompting
 password from management
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

--S2prT2TVQs0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail

to review the following change.


Change subject: Fixup: prompting password from management
......................................................................

Fixup: prompting password from management

Commit b450414 added logic for reading password from management
when not in file or inline, but it was made conditional on
`response_from_stdin` which is always true! Fix by explicitly
checking for `password_from_stdin`.

Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/misc.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1638/1

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 979293f..10bfc35 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -336,6 +336,7 @@
              */
             if (management && (flags & GET_USER_PASS_MANAGEMENT)
                 && management_query_user_pass_enabled(management)
+                && password_from_stdin
                 && !(flags & GET_USER_PASS_USERNAME_ONLY))
             {
                 msg(D_LOW,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202
Gerrit-Change-Number: 1638
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--S2prT2TVQs0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fixup: prompting password from management<b=
r><br>Commit b450414 added logic for reading password from management<br>wh=
en not in file or inline, but it was made conditional on<br>`response_from_=
stdin` which is always true! Fix by explicitly<br>checking for `password_fr=
om_stdin`.<br><br>Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202<br>S=
igned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openv=
pn/misc.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38=
/1638/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span>=
<br><span>index 979293f..10bfc35 100644</span><br><span>--- a/src/openvpn/m=
isc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -336,6 +3=
36,7 @@</span><br><span>              */</span><br><span>             if (m=
anagement &amp;&amp; (flags &amp; GET_USER_PASS_MANAGEMENT)</span><br><span=
>                 &amp;&amp; management_query_user_pass_enabled(management)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &am=
p;&amp; password_from_stdin</span><br><span>                 &amp;&amp; !(f=
lags &amp; GET_USER_PASS_USERNAME_ONLY))</span><br><span>             {</sp=
an><br><span>                 msg(D_LOW,</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=
=3Demail">change 1638</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d46c3672691b159cbd98a17020=
c4f30782bc202 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1638 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--S2prT2TVQs0=--

