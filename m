From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Sep 2025 18:51:03 +0000
In-Reply-To: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
References: <gerrit.1759135650000.I3b1243461ec9b6e85897f452f78dc4b05f7e126d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <86e2129c348bfa79dffd854716e1a0101fbbd0fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gGh3mL8O6qQ="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gGh3mL8O6qQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
23?usp=3Demail )

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
Gerrit-MessageType: merged

--gGh3mL8O6qQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1223?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
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
tion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><sp=
an>index 4dd307f..30307de 100644</span><br><span>--- a/src/openvpn/dco_win.=
c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -541,7 +54=
1,7 @@</span><br><span>     ZeroMemory(&amp;crypto_data, sizeof(crypto_data=
));</span><br><span> </span><br><span>     crypto_data.CipherAlg =3D dco_ge=
t_cipher(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ASSERT(keyid &gt; 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(keyid &gt;=3D 0 &amp;&a=
mp; keyid &lt;=3D UCHAR_MAX);</span><br><span>     crypto_data.KeyId =3D (u=
nsigned char)keyid;</span><br><span>     crypto_data.PeerId =3D peerid;</sp=
an><br><span>     crypto_data.KeySlot =3D slot;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
23?usp=3Demail">change 1223</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1223?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--gGh3mL8O6qQ=--

