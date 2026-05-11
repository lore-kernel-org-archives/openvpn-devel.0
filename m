From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 11 May 2026 12:11:04 +0000
In-Reply-To: <gerrit.1778239616000.Ia688ec12e642de699811ced8668b40be9fbb6155@...2715...>
References: <gerrit.1778239616000.Ia688ec12e642de699811ced8668b40be9fbb6155@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6638a255339c410a3e62d5babb8c84f6ab1aa573-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vbshCvrIqOc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix some msg()
 calls with wrong number of arguments in Windows-only code
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

--vbshCvrIqOc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
72?usp=3Demail )

Change subject: Fix some msg() calls with wrong number of arguments in Wind=
ows-only code
......................................................................

Fix some msg() calls with wrong number of arguments in Windows-only code

For some reason neither MSVC nor MinGW complained?
cppcheck did (once told that msg is a printf-style
function).

Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1672
Message-Id: <20260508153108.13488-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
862.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnmsica/msiex.c
M src/tapctl/tap.c
2 files changed, 3 insertions(+), 3 deletions(-)




diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index f8bf6ae..4d48f06 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -51,7 +51,7 @@
         *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue =3D=3D NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", dwLength * sizeof(WCHAR)=
);
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength *=
 sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 16e3c0b..1d94988 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -487,8 +487,8 @@
         }

         default:
-            msg(M_NONFATAL, "%s: \"%ls\" registry value is not string (typ=
e %u)", __FUNCTION__,
-                dwValueType);
+            msg(M_NONFATAL, "%s: \"%ls\" registry value is not string (typ=
e %u)",
+                __FUNCTION__, szName, dwValueType);
             return ERROR_UNSUPPORTED_TYPE;
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155
Gerrit-Change-Number: 1672
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vbshCvrIqOc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1672?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix some msg() calls with wrong number of argume=
nts in Windows-only code<br><br>For some reason neither MSVC nor MinGW comp=
lained?<br>cppcheck did (once told that msg is a printf-style<br>function).=
<br><br>Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+=
/1672<br>Message-Id: &lt;20260508153108.13488-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36862.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src=
/openvpnmsica/msiex.c<br>M src/tapctl/tap.c<br>2 files changed, 3 insertion=
s(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c</span><=
br><span>index f8bf6ae..4d48f06 100644</span><br><span>--- a/src/openvpnmsi=
ca/msiex.c</span><br><span>+++ b/src/openvpnmsica/msiex.c</span><br><span>@=
@ -51,7 +51,7 @@</span><br><span>         *pszValue =3D (LPWSTR)malloc(++dw=
Length * sizeof(WCHAR));</span><br><span>         if (*pszValue =3D=3D NULL=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, dwLength=
 * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_FATAL, &quot;%s: malloc(%u) failed&quot;, __FUNCTION__, dw=
Length * sizeof(WCHAR));</span><br><span>             return ERROR_OUTOFMEM=
ORY;</span><br><span>         }</span><br><span> </span><br><span>diff --gi=
t a/src/tapctl/tap.c b/src/tapctl/tap.c</span><br><span>index 16e3c0b..1d94=
988 100644</span><br><span>--- a/src/tapctl/tap.c</span><br><span>+++ b/src=
/tapctl/tap.c</span><br><span>@@ -487,8 +487,8 @@</span><br><span>         =
}</span><br><span> </span><br><span>         default:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_NONFATAL, &quot;%s: \&quo=
t;%ls\&quot; registry value is not string (type %u)&quot;, __FUNCTION__,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                dwValueT=
ype);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_NONFATAL, &quot;%s: \&quot;%ls\&quot; registry value is not string (typ=
e %u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         __FUNCTION__, szName, dwValueType);</span><br><span>             r=
eturn ERROR_UNSUPPORTED_TYPE;</span><br><span>     }</span><br><span> }</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1672?usp=3Demail">change 1672</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1672?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia688ec12e642de699811ced8668=
b40be9fbb6155 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1672 </div>
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

--vbshCvrIqOc=--

