From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Sep 2025 18:51:01 +0000
In-Reply-To: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
References: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <86e2129c348bfa79dffd854716e1a0101fbbd0fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+JrwPqI5R3U="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco-win: fix broken
 ASSERT in dco_new_key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+JrwPqI5R3U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1223?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: dco-win: fix broken ASSERT in dco_new_key
......................................................................

dco-win: fix broken ASSERT in dco_new_key

Commit

  e77c343 ("dco_win: In dco_new_key, document size assumptions for the inte=
ger casts")

has added an ASSERT on key-id, but didn't take into account that
key-id 0 is a perfectly valid value and is the first key-id. This
essentially broke dco-win.

Fix by adjusting ASSERT to >=3D 0.

Change-Id: I3b1243461ec9b6e85897f452f78dc4b05f7e126d
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1223
Message-Id: <20250929152841.177424-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59240115/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1223/2

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 4dd307f..30307de 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -541,7 +541,7 @@
     ZeroMemory(&crypto_data, sizeof(crypto_data));

     crypto_data.CipherAlg =3D dco_get_cipher(ciphername);
-    ASSERT(keyid > 0 && keyid <=3D UCHAR_MAX);
+    ASSERT(keyid >=3D 0 && keyid <=3D UCHAR_MAX);
     crypto_data.KeyId =3D (unsigned char)keyid;
     crypto_data.PeerId =3D peerid;
     crypto_data.KeySlot =3D slot;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1223?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b1243461ec9b6e85897f452f78dc4b05f7e126d
Gerrit-Change-Number: 1223
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+JrwPqI5R3U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1223=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco-win: fix broken ASSERT in dco_new_key<br>=
<br>Commit<br><br>  e77c343 (&quot;dco_win: In dco_new_key, document size a=
ssumptions for the integer casts&quot;)<br><br>has added an ASSERT on key-i=
d, but didn&#39;t take into account that<br>key-id 0 is a perfectly valid v=
alue and is the first key-id. This<br>essentially broke dco-win.<br><br>Fix=
 by adjusting ASSERT to &gt;=3D 0.<br><br>Change-Id: I3b1243461ec9b6e85897f=
452f78dc4b05f7e126d<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br=
>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1223<br>Message-Id: &lt;20250929152841.177=
424-1-frank@...2641...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailma=
n/message/59240115/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/dco_win.c<br>1 file changed, 1 insertion(+), 1 dele=
tion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/23/1223/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_=
win.c</span><br><span>index 4dd307f..30307de 100644</span><br><span>--- a/s=
rc/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br>=
<span>@@ -541,7 +541,7 @@</span><br><span>     ZeroMemory(&amp;crypto_data,=
 sizeof(crypto_data));</span><br><span> </span><br><span>     crypto_data.C=
ipherAlg =3D dco_get_cipher(ciphername);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ASSERT(keyid &gt; 0 &amp;&amp; keyid &lt;=3D UCHAR_M=
AX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(keyi=
d &gt;=3D 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX);</span><br><span>     crypt=
o_data.KeyId =3D (unsigned char)keyid;</span><br><span>     crypto_data.Pee=
rId =3D peerid;</span><br><span>     crypto_data.KeySlot =3D slot;</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1223?usp=3Demail">change 1223</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1223?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b1243461ec9b6e85897f452f78=
dc4b05f7e126d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1223 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+JrwPqI5R3U=--

