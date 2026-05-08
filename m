From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:29 +0000
References: <gerrit.1778239616000.Ia688ec12e642de699811ced8668b40be9fbb6155@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7bc71d4689e24a0b405985dca995e8ff15daca69-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ka51XU07Ouc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ka51XU07Ouc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1672?usp=3Demail

to review the following change.


Change subject: Fix some msg() calls with wrong number of arguments in Wind=
ows-only code
......................................................................

Fix some msg() calls with wrong number of arguments in Windows-only code

For some reason neither MSVC nor MinGW complained?
cppcheck did (once told that msg is a printf-style
function).

Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnmsica/msiex.c
M src/tapctl/tap.c
2 files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1672/1

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
index 6ed395d..cccc0e1 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155
Gerrit-Change-Number: 1672
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ka51XU07Ouc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1672?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix some msg() calls with wrong number of a=
rguments in Windows-only code<br><br>For some reason neither MSVC nor MinGW=
 complained?<br>cppcheck did (once told that msg is a printf-style<br>funct=
ion).<br><br>Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn=
msica/msiex.c<br>M src/tapctl/tap.c<br>2 files changed, 3 insertions(+), 3 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/72/1672/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/m=
siex.c b/src/openvpnmsica/msiex.c</span><br><span>index f8bf6ae..4d48f06 10=
0644</span><br><span>--- a/src/openvpnmsica/msiex.c</span><br><span>+++ b/s=
rc/openvpnmsica/msiex.c</span><br><span>@@ -51,7 +51,7 @@</span><br><span> =
        *pszValue =3D (LPWSTR)malloc(++dwLength * sizeof(WCHAR));</span><br=
><span>         if (*pszValue =3D=3D NULL)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &q=
uot;%s: malloc(%u) failed&quot;, dwLength * sizeof(WCHAR));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;%s: =
malloc(%u) failed&quot;, __FUNCTION__, dwLength * sizeof(WCHAR));</span><br=
><span>             return ERROR_OUTOFMEMORY;</span><br><span>         }</s=
pan><br><span> </span><br><span>diff --git a/src/tapctl/tap.c b/src/tapctl/=
tap.c</span><br><span>index 6ed395d..cccc0e1 100644</span><br><span>--- a/s=
rc/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap.c</span><br><span>@@ -=
487,8 +487,8 @@</span><br><span>         }</span><br><span> </span><br><spa=
n>         default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_NONFATAL, &quot;%s: \&quot;%ls\&quot; registry value is not=
 string (type %u)&quot;, __FUNCTION__,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                dwValueType);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;%s: \&quot;%ls=
\&quot; registry value is not string (type %u)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                __FUNCTION__, szName, dwV=
alueType);</span><br><span>             return ERROR_UNSUPPORTED_TYPE;</spa=
n><br><span>     }</span><br><span> }</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1672?usp=3De=
mail">change 1672</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1672?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia688ec12e642de699811ced8668=
b40be9fbb6155 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1672 </div>
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

--ka51XU07Ouc=--

