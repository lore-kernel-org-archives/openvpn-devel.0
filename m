From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 21 Sep 2023 14:07:45 +0000
References: <gerrit.1695305263000.I30f4ea502a36eca155cbc79b89c0d18ee3419877@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c258eb0e81197a749dcbde7ff316a81c8401706c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HfI6lkTpXOk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMake: fix
 HAVE_DAEMON detection on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HfI6lkTpXOk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail

to review the following change.


Change subject: CMake: fix HAVE_DAEMON detection on Linux
......................................................................

CMake: fix HAVE_DAEMON detection on Linux

On Linux, daemon() is defined in unistd.h, not in
stdlib.h like in MacOS or FreeBSD.

Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877
Signed-off-by: Lev Stipakov <lev@...515...>
---
M CMakeLists.txt
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/362/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9de6aba..76351c1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -158,7 +158,7 @@
 check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
 check_symbol_exists(basename libgen.h HAVE_BASENAME)
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
-check_symbol_exists(daemon stdlib.h HAVE_DAEMON)
+check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
 check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
 check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877
Gerrit-Change-Number: 362
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HfI6lkTpXOk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">CMake: fix HAVE_DAEMON detection on Linux<br><br>On Linux, da=
emon() is defined in unistd.h, not in<br>stdlib.h like in MacOS or FreeBSD.=
<br><br>Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877<br>Signed-off-=
by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M CMakeLists.txt<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/62/362/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s.txt b/CMakeLists.txt</span><br><span>index 9de6aba..76351c1 100644</span>=
<br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><=
br><span>@@ -158,7 +158,7 @@</span><br><span> check_symbol_exists(gettimeof=
day sys/time.h HAVE_GETTIMEOFDAY)</span><br><span> check_symbol_exists(base=
name libgen.h HAVE_BASENAME)</span><br><span> check_symbol_exists(chsize io=
.h HAVE_CHSIZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_=
symbol_exists(daemon stdlib.h HAVE_DAEMON)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_symbol_exists(daemon &quot;unistd.h;stdlib.h&q=
uot; HAVE_DAEMON)</span><br><span> check_symbol_exists(dirname libgen.h HAV=
E_DIRNAME)</span><br><span> check_symbol_exists(getrlimit sys/resource.h HA=
VE_GETRLIMIT)</span><br><span> check_symbol_exists(mlockall sys/mman.h HAVE=
_MLOCKALL)</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail">change 362</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/362?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I30f4ea502a36eca155cbc79b89c=
0d18ee3419877 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 362 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HfI6lkTpXOk=--

