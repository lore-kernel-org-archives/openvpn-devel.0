From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 14:13:07 +0000
In-Reply-To: <gerrit.1701190231000.I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef@...2715...>
References: <gerrit.1701190231000.I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2eeb2a0da64d941dbd71519cd31995bfb5fb5ade-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YYfxVY8DNaY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: clean up
 libressl builds with newer libressl
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

--YYfxVY8DNaY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/46=
1?usp=3Demail )

Change subject: GHA: clean up libressl builds with newer libressl
......................................................................

GHA: clean up libressl builds with newer libressl

- Update to latest stable release
- Work-around patches not required anymore
- Official URL of repo has changed

Change-Id: I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231201123649.18127-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
635.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 13 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cd72f3d..4393f5c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -323,22 +323,11 @@
         uses: actions/checkout@...2689...
         with:
           path: libressl
-          repository: libressl-portable/portable
-          ref: v3.7.0
-      # LibreSSL has master in the OPENBSD_BRANCH by default even in the t=
agged releases
-      # Manually use the OpenBSD branch that is more appropiate and remove=
 git pull that
-      # breaks when checking out a tag instead of branch
-      - name: "libressl: fix build"
-        run: |
-           echo libressl-v3.7.0 > OPENBSD_BRANCH
-           sed -i -e 's/ git pull --rebase//' update.sh
-        working-directory: libressl
+          repository: libressl/portable
+          ref: v3.8.2
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
-      - name: "libressl: autoconf"
-        run: autoreconf -fvi
-        working-directory: libressl
       - name: "libressl: configure"
         run: ./configure
         working-directory: libressl

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/461?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef
Gerrit-Change-Number: 461
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--YYfxVY8DNaY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/461?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: clean up libressl builds with newer libre=
ssl<br><br>- Update to latest stable release<br>- Work-around patches not r=
equired anymore<br>- Official URL of repo has changed<br><br>Change-Id: I9b=
8e69f2b9838cea4cb9001f4e8960b8a39724ef<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1830...=
...&gt;<br>Message-Id: &lt;20231201123649.18127-1-frank@...2641...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg276=
35.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
.github/workflows/build.yaml<br>1 file changed, 2 insertions(+), 13 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index cd72f3d..4393f5c 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -323,22 +323,11 @@</span><br><span>         uses: actions=
/checkout@...2689...</span><br><span>         with:</span><br><span>       =
    path: libressl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       repository: libressl-portable/portable</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-          ref: v3.7.0</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      # LibreSSL has master in the OPENBSD_BRANCH b=
y default even in the tagged releases</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      # Manually use the OpenBSD branch that is more approp=
iate and remove git pull that</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      # breaks when checking out a tag instead of branch</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;libressl: fi=
x build&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
run: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           echo=
 libressl-v3.7.0 &gt; OPENBSD_BRANCH</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-           sed -i -e &#39;s/ git pull --rebase//&#39; update=
.sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-di=
rectory: libressl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        repository: libressl/portable</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+          ref: v3.8.2</span><br><span>       - name: &quo=
t;libressl: autogen.sh&quot;</span><br><span>         run: ./autogen.sh</sp=
an><br><span>         working-directory: libressl</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      - name: &quot;libressl: autoconf&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: autoreconf =
-fvi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-d=
irectory: libressl</span><br><span>       - name: &quot;libressl: configure=
&quot;</span><br><span>         run: ./configure</span><br><span>         w=
orking-directory: libressl</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/461?usp=3Demail">change=
 461</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/461?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b8e69f2b9838cea4cb9001f4e8=
960b8a39724ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 461 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--YYfxVY8DNaY=--

