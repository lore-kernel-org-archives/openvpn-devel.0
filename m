From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 26 Oct 2025 16:30:11 +0000
References: <gerrit.1761496209000.I92804da010bab36cd0326759c04f955f2bda74de@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <30c0e371453964661c41379556e3fb72c162c28d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o5pvAlEDTqQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: check
 return value of MultiByteToWideChar
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

--o5pvAlEDTqQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail

to review the following change.


Change subject: iservice: check return value of MultiByteToWideChar
......................................................................

iservice: check return value of MultiByteToWideChar

If the first call to MultiByteToWideChar returns 0, something must have
failed, because it returns the required buffer size including the
terminating zero. When it does return 0, just return NULL and indicate
that the call to utf8to16(_size) failed.

Found by ZeroPath.

Reported-By: Joshua Rogers <contact@...2949...>
Change-Id: I92804da010bab36cd0326759c04f955f2bda74de
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/common.c
1 file changed, 4 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1306/1

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e975cc7..d25d9c0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -276,6 +276,10 @@
 utf8to16_size(const char *utf8, int size)
 {
     int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
+    if (n =3D=3D 0)
+    {
+        return NULL;
+    }
     wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));
     if (!utf16)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I92804da010bab36cd0326759c04f955f2bda74de
Gerrit-Change-Number: 1306
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--o5pvAlEDTqQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: check return value of MultiByteTo=
WideChar<br><br>If the first call to MultiByteToWideChar returns 0, somethi=
ng must have<br>failed, because it returns the required buffer size includi=
ng the<br>terminating zero. When it does return 0, just return NULL and ind=
icate<br>that the call to utf8to16(_size) failed.<br><br>Found by ZeroPath.=
<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Change-Id:=
 I92804da010bab36cd0326759c04f955f2bda74de<br>Signed-off-by: Heiko Hund &lt=
;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/common.c<br>1 file change=
d, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/06/1306/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><span>i=
ndex e975cc7..d25d9c0 100644</span><br><span>--- a/src/openvpnserv/common.c=
</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -276,6 +=
276,10 @@</span><br><span> utf8to16_size(const char *utf8, int size)</span>=
<br><span> {</span><br><span>     int n =3D MultiByteToWideChar(CP_UTF8, 0,=
 utf8, size, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (n =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span>     wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));</span><br>=
<span>     if (!utf16)</span><br><span>     {</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1306=
?usp=3Demail">change 1306</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1306?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92804da010bab36cd0326759c04=
f955f2bda74de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1306 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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

--o5pvAlEDTqQ=--

