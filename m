From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 17:38:39 +0000
References: <gerrit.1699637918000.I0c78ce452135fe2c80275da449215ba926471018@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a1c2ca01febfd77959187552a44476064a15a659-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+c0cuNXNlcU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: platform.c: Do not
 depend Windows build on HAVE_CHDIR
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

--+c0cuNXNlcU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail

to review the following change.


Change subject: platform.c: Do not depend Windows build on HAVE_CHDIR
......................................................................

platform.c: Do not depend Windows build on HAVE_CHDIR

This broke in the CMake build since previously we
just always set HAVE_CHDIR to 1 in the MSVC build.
But actually the code should just not check HAVE_CHDIR
on Windows.

Change-Id: I0c78ce452135fe2c80275da449215ba926471018
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/platform.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/425/1

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 32c4fe6..62acabe 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -392,7 +392,6 @@
 int
 platform_chdir(const char *dir)
 {
-#ifdef HAVE_CHDIR
 #ifdef _WIN32
     int res;
     struct gc_arena gc =3D gc_new();
@@ -400,11 +399,12 @@
     gc_free(&gc);
     return res;
 #else  /* ifdef _WIN32 */
+#ifdef HAVE_CHDIR
     return chdir(dir);
-#endif
 #else  /* ifdef HAVE_CHDIR */
     return -1;
 #endif
+#endif
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c78ce452135fe2c80275da449215ba926471018
Gerrit-Change-Number: 425
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--+c0cuNXNlcU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">platform.c: Do not depend Windows build on HAVE_CHDIR<br><br>=
This broke in the CMake build since previously we<br>just always set HAVE_C=
HDIR to 1 in the MSVC build.<br>But actually the code should just not check=
 HAVE_CHDIR<br>on Windows.<br><br>Change-Id: I0c78ce452135fe2c80275da449215=
ba926471018<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>---<br>M src/openvpn/platform.c<br>1 file changed, 2 insertions(+), 2 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/25/425/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/platform.c b/src/openvpn/pla=
tform.c</span><br><span>index 32c4fe6..62acabe 100644</span><br><span>--- a=
/src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</span>=
<br><span>@@ -392,7 +392,6 @@</span><br><span> int</span><br><span> platfor=
m_chdir(const char *dir)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef HAVE_CHDIR</span><br><span> #ifdef _WIN32</spa=
n><br><span>     int res;</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span>@@ -400,11 +399,12 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span>     return res;</span><br><span> #else  /* ifdef _W=
IN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_=
CHDIR</span><br><span>     return chdir(dir);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span> #else  /* ifdef HAVE_CHDIR =
*/</span><br><span>     return -1;</span><br><span> #endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br>=
<span> </span><br><span> /*</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail">chang=
e 425</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0c78ce452135fe2c80275da4492=
15ba926471018 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--+c0cuNXNlcU=--

