From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 08:01:02 +0000
In-Reply-To: <gerrit.1769513463000.I4ff7983a33426fda9a138fe6e56a1c03522836d3@...2715...>
References: <gerrit.1769513463000.I4ff7983a33426fda9a138fe6e56a1c03522836d3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6f63e51b3b46ae4e043684fc6fd63a381fc16ba1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GtwrXpE8g7A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32-util: Handle
 return value from WideCharToMultiByte better
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

--GtwrXpE8g7A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
95?usp=3Demail )

Change subject: win32-util: Handle return value from WideCharToMultiByte be=
tter
......................................................................

win32-util: Handle return value from WideCharToMultiByte better

Handle the case where the return value is zero
and avoid sign-compare warning.

Change-Id: I4ff7983a33426fda9a138fe6e56a1c03522836d3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1495
Message-Id: <20260304164928.15819-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
906.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/win32-util.c
1 file changed, 8 insertions(+), 9 deletions(-)




diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index e60cbac..6fc3be4 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -146,11 +146,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 const char *
 win_get_tempdir(void)
 {
@@ -162,7 +157,14 @@
         return NULL;
     }

-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) =
> sizeof(tmpdir))
+    int ret =3D WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL=
, NULL);
+    /* According to documentation ret is never < 0, but include it here ju=
st in case */
+    if (ret <=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "Conversion of path name failed.");
+        return NULL;
+    }
+    if ((unsigned int)ret > sizeof(tmpdir))
     {
         msg(M_WARN, "Could not get temporary directory. Path is too long."
                     "  Consider using --tmp-dir");
@@ -173,7 +175,4 @@
     return tmpdir;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #endif /* _WIN32 */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ff7983a33426fda9a138fe6e56a1c03522836d3
Gerrit-Change-Number: 1495
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GtwrXpE8g7A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1495?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">win32-util: Handle return value from WideCharToM=
ultiByte better<br><br>Handle the case where the return value is zero<br>an=
d avoid sign-compare warning.<br><br>Change-Id: I4ff7983a33426fda9a138fe6e5=
6a1c03522836d3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1495<br>Message-Id: &lt;2026030416492=
8.15819-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg35906.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M src/openvpn/win32-util.c<br>1 file change=
d, 8 insertions(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c</span><=
br><span>index e60cbac..6fc3be4 100644</span><br><span>--- a/src/openvpn/wi=
n32-util.c</span><br><span>+++ b/src/openvpn/win32-util.c</span><br><span>@=
@ -146,11 +146,6 @@</span><br><span>     return true;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const char *</=
span><br><span> win_get_tempdir(void)</span><br><span> {</span><br><span>@@=
 -162,7 +157,14 @@</span><br><span>         return NULL;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) =
&gt; sizeof(tmpdir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int ret =3D WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Acco=
rding to documentation ret is never &lt; 0, but include it here just in cas=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt=
;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERR=
NO, &quot;Conversion of path name failed.&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if ((unsigned int)ret &gt; sizeof(tmpdir))</span><br><=
span>     {</span><br><span>         msg(M_WARN, &quot;Could not get tempor=
ary directory. Path is too long.&quot;</span><br><span>                    =
 &quot;  Consider using --tmp-dir&quot;);</span><br><span>@@ -173,7 +175,4 =
@@</span><br><span>     return tmpdir;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span> #endif /* _WIN32 */</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1495?usp=3Demail">change 1495</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/149=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ff7983a33426fda9a138fe6e56=
a1c03522836d3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1495 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--GtwrXpE8g7A=--

