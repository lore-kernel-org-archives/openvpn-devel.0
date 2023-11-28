From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 16:50:33 +0000
References: <gerrit.1701190231000.I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <167adb29ac632674529953ac722cb59974b20063-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OmSHMK0nlVA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OmSHMK0nlVA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/461?usp=3Demail

to review the following change.


Change subject: GHA: clean up libressl builds with newer libressl
......................................................................

GHA: clean up libressl builds with newer libressl

- Update to latest stable release
- Work-around patches not required anymore
- Official URL of repo has changed

Change-Id: I9b8e69f2b9838cea4cb9001f4e8960b8a39724ef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/461/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--OmSHMK0nlVA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/461?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: clean up libressl builds with newer libressl<br><br>- Up=
date to latest stable release<br>- Work-around patches not required anymore=
<br>- Official URL of repo has changed<br><br>Change-Id: I9b8e69f2b9838cea4=
cb9001f4e8960b8a39724ef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 2 ins=
ertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/61/461/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/bui=
ld.yaml b/.github/workflows/build.yaml</span><br><span>index cd72f3d..4393f=
5c 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><spa=
n>+++ b/.github/workflows/build.yaml</span><br><span>@@ -323,22 +323,11 @@<=
/span><br><span>         uses: actions/checkout@...2689...</span><br><span>=
         with:</span><br><span>           path: libressl</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          repository: libressl-portable/=
portable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref=
: v3.7.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # Libre=
SSL has master in the OPENBSD_BRANCH by default even in the tagged releases=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # Manually use =
the OpenBSD branch that is more appropiate and remove git pull that</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-      # breaks when checking =
out a tag instead of branch</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      - name: &quot;libressl: fix build&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        run: |</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-           echo libressl-v3.7.0 &gt; OPENBSD_BRANC=
H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           sed -i -e=
 &#39;s/ git pull --rebase//&#39; update.sh</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        working-directory: libressl</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          repository: libressl/portab=
le</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v3=
.8.2</span><br><span>       - name: &quot;libressl: autogen.sh&quot;</span>=
<br><span>         run: ./autogen.sh</span><br><span>         working-direc=
tory: libressl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 name: &quot;libressl: autoconf&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        run: autoreconf -fvi</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        working-directory: libressl</span><br><span>=
       - name: &quot;libressl: configure&quot;</span><br><span>         run=
: ./configure</span><br><span>         working-directory: libressl</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/461?usp=3Demail">change 461</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
461?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b8e69f2b9838cea4cb9001f4e8=
960b8a39724ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 461 </div>
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


--OmSHMK0nlVA=--

