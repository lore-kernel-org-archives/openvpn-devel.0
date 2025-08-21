From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 21 Aug 2025 13:44:37 +0000
In-Reply-To: <gerrit.1755776561000.I13ad2b7da6b008bc692b1f08f502fc3fc57e7206@...2715...>
References: <gerrit.1755776561000.I13ad2b7da6b008bc692b1f08f502fc3fc57e7206@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <c4704f899757008790ae1293e10df8b099ec5339-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hJScPLT8DjQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add sample FFDH
 parameters file and use that in t_server_null tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <sasepp@...2783...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hJScPLT8DjQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
47?usp=3Demail )

Change subject: Add sample FFDH parameters file and use that in t_server_nu=
ll tests
......................................................................

Add sample FFDH parameters file and use that in t_server_null tests

Change-Id: I13ad2b7da6b008bc692b1f08f502fc3fc57e7206
Signed-off-by: Samuli Sepp=C3=A4nen <sasepp@...2705...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250821121442.30679-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
643.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A sample/sample-keys/ffdhe2048.pem
M tests/t_server_null_default.rc
2 files changed, 9 insertions(+), 1 deletion(-)




diff --git a/sample/sample-keys/ffdhe2048.pem b/sample/sample-keys/ffdhe204=
8.pem
new file mode 100644
index 0000000..9b182b7
--- /dev/null
+++ b/sample/sample-keys/ffdhe2048.pem
@@ -0,0 +1,8 @@
+-----BEGIN DH PARAMETERS-----
+MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
++8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
+87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
+YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
+7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
+ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=3D
+-----END DH PARAMETERS-----
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 900f189..798cfd0 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -13,7 +13,7 @@
 top_builddir=3D"${top_builddir:-..}"
 sample_keys=3D"${srcdir}/../sample/sample-keys"

-DH=3D"${sample_keys}/dh2048.pem"
+DH=3D"${sample_keys}/ffdhe2048.pem"
 CA=3D"${sample_keys}/ca.crt"
 CLIENT_CERT=3D"${sample_keys}/client.crt"
 CLIENT_KEY=3D"${sample_keys}/client.key"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1147?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13ad2b7da6b008bc692b1f08f502fc3fc57e7206
Gerrit-Change-Number: 1147
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--hJScPLT8DjQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1147?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add sample FFDH parameters file and use that =
in t_server_null tests<br><br>Change-Id: I13ad2b7da6b008bc692b1f08f502fc3fc=
57e7206<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;sasepp@...2705...&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;=
20250821121442.30679-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg32643.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>A sample/sample-keys/ffdhe2048=
.pem<br>M tests/t_server_null_default.rc<br>2 files changed, 9 insertions(+=
), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/sample/sample-keys/ffdhe2048.pem b/sample/sample-keys/ffdhe=
2048.pem</span><br><span>new file mode 100644</span><br><span>index 0000000=
..9b182b7</span><br><span>--- /dev/null</span><br><span>+++ b/sample/sample=
-keys/ffdhe2048.pem</span><br><span>@@ -0,0 +1,8 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----BEGIN DH PARAMETERS-----</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+MIIBCAKCAQEA//////////+t+FRYort=
Kmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz</span><br><span style=3D"color: hsl(120, =
100%, 40%);">++8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVP=
e0a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+87VXE15/V8k1mE8M=
cODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCw=
enyO4KbXCeAvzhzffi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+7=
MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ssbzSibBsu/6iGtCOGEoXJf////////=
//wIBAg=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----E=
ND DH PARAMETERS-----</span><br><span>diff --git a/tests/t_server_null_defa=
ult.rc b/tests/t_server_null_default.rc</span><br><span>index 900f189..798c=
fd0 100755</span><br><span>--- a/tests/t_server_null_default.rc</span><br><=
span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -13,7 +13,7 @@=
</span><br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</span><br>=
<span> sample_keys=3D&quot;${srcdir}/../sample/sample-keys&quot;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-DH=3D&quot;${s=
ample_keys}/dh2048.pem&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+DH=3D&quot;${sample_keys}/ffdhe2048.pem&quot;</span><br><span> CA=
=3D&quot;${sample_keys}/ca.crt&quot;</span><br><span> CLIENT_CERT=3D&quot;$=
{sample_keys}/client.crt&quot;</span><br><span> CLIENT_KEY=3D&quot;${sample=
_keys}/client.key&quot;</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1147?usp=3Demail">change 1=
147</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1147?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ad2b7da6b008bc692b1f08f50=
2fc3fc57e7206 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1147 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--hJScPLT8DjQ=--

