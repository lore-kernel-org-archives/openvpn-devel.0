From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 08:34:26 +0000
References: <gerrit.1761813264000.I75ebf01641db4dcd07041e3b8b3fa8a632d07595@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b8edde97f5d26b512d8957b4363489b728912e00-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="muJLo+Fnpnw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: interactive.c: add
 the upper bound for startupdata size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--muJLo+Fnpnw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1331?usp=3Demail

to review the following change.


Change subject: interactive.c: add the upper bound for startupdata size
......................................................................

interactive.c: add the upper bound for startupdata size

The size is passed from the limited-privileges process.
This check ensures that the service won't allocate
more than needed.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I75ebf01641db4dcd07041e3b8b3fa8a632d07595
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1331/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce0d4dd..cb31267 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -446,9 +446,9 @@
     }

     size =3D bytes / sizeof(*data);
-    if (size =3D=3D 0)
+    if ((size =3D=3D 0) || (size > 4096)) /* our startup data is 1024 wcha=
rs at the moment */
     {
-        MsgToEventLog(M_SYSERR, L"malformed startup data: 1 byte received"=
);
+        MsgToEventLog(M_SYSERR, L"malformed startup data: %lu bytes receiv=
ed", size);
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_=
event);
         goto err;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1331?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I75ebf01641db4dcd07041e3b8b3fa8a632d07595
Gerrit-Change-Number: 1331
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--muJLo+Fnpnw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1331?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">interactive.c: add the upper bound for star=
tupdata size<br><br>The size is passed from the limited-privileges process.=
<br>This check ensures that the service won&#39;t allocate<br>more than nee=
ded.<br><br>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-=
by: ZeroPath (https://zeropath.com/)<br><br>Change-Id: I75ebf01641db4dcd070=
41e3b8b3fa8a632d07595<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 2 insertions(+=
), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/31/1331/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnse=
rv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index ce0d=
4dd..cb31267 100644</span><br><span>--- a/src/openvpnserv/interactive.c</sp=
an><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -446,9 =
+446,9 @@</span><br><span>     }</span><br><span> </span><br><span>     siz=
e =3D bytes / sizeof(*data);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (size =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if ((size =3D=3D 0) || (size &gt; 4096)) /* our startup data =
is 1024 wchars at the moment */</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;mal=
formed startup data: 1 byte received&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;malformed s=
tartup data: %lu bytes received&quot;, size);</span><br><span>         Retu=
rnError(pipe, ERROR_STARTUP_DATA, L&quot;GetStartupData&quot;, 1, &amp;exit=
_event);</span><br><span>         goto err;</span><br><span>     }</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1331?usp=3Demail">change 1331</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1331?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I75ebf01641db4dcd07041e3b8b3=
fa8a632d07595 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1331 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--muJLo+Fnpnw=--

