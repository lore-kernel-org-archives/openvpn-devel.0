From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 15:48:45 +0000
In-Reply-To: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
References: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d4dc0dd5e985e3e3cf6df86773e2207e2c35bf48-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sYFihn8jrRE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_freebsd: Add
 check_malloc_return after realloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sYFihn8jrRE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco_freebsd: Add check_malloc_return after realloc
......................................................................

dco_freebsd: Add check_malloc_return after realloc

cppcheck complained about a potential memleak
due to realloc failure. But trying to handle that
is probably not useful. Just abort like we do
for other malloc failures.

Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1669
Message-Id: <20260507075321.25123-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
842.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M dev-tools/cppcheck-suppression
M src/openvpn/dco_freebsd.c
2 files changed, 3 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1669/3

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 1f31edb..439cbb1 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -44,6 +44,8 @@
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
 # FP: cppcheck seems to be confused since we cast the pointer to integer
 memleak:src/plugins/down-root/down-root.c:337
+# IGN: we just abort instead
+memleakOnRealloc:src/openvpn/dco_freebsd.c:845
 # FP: eventmsg.h is not built on Unix
 missingInclude:src/openvpnserv/common.c:25
 # IGN: strlen(NULL) is not nice code, but seems to work
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 718cd8b..eaca86b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -842,6 +842,7 @@

 retry:
     buf =3D realloc(buf, buf_size);
+    check_malloc_return(buf);
     drv.ifd_len =3D buf_size;
     drv.ifd_data =3D buf;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Gerrit-Change-Number: 1669
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sYFihn8jrRE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco_freebsd: Add check_malloc_retur=
n after realloc<br><br>cppcheck complained about a potential memleak<br>due=
 to realloc failure. But trying to handle that<br>is probably not useful. J=
ust abort like we do<br>for other malloc failures.<br><br>Change-Id: Icd8ea=
093dfe9f1888570f3d7b786b951b5262e47<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1669<br>Message-Id: &lt;=
20260507075321.25123-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg36842.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M dev-tools/cppcheck-suppressi=
on<br>M src/openvpn/dco_freebsd.c<br>2 files changed, 3 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/69/1669/3</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-s=
uppression b/dev-tools/cppcheck-suppression</span><br><span>index 1f31edb..=
439cbb1 100644</span><br><span>--- a/dev-tools/cppcheck-suppression</span><=
br><span>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ -44,6 +44,=
8 @@</span><br><span> knownConditionTrueFalse:src/openvpnmsica/dllmain.c:16=
4</span><br><span> # FP: cppcheck seems to be confused since we cast the po=
inter to integer</span><br><span> memleak:src/plugins/down-root/down-root.c=
:337</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: we just =
abort instead</span><br><span style=3D"color: hsl(120, 100%, 40%);">+memlea=
kOnRealloc:src/openvpn/dco_freebsd.c:845</span><br><span> # FP: eventmsg.h =
is not built on Unix</span><br><span> missingInclude:src/openvpnserv/common=
.c:25</span><br><span> # IGN: strlen(NULL) is not nice code, but seems to w=
ork</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dc=
o_freebsd.c</span><br><span>index 718cd8b..eaca86b 100644</span><br><span>-=
-- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebs=
d.c</span><br><span>@@ -842,6 +842,7 @@</span><br><span> </span><br><span> =
retry:</span><br><span>     buf =3D realloc(buf, buf_size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    check_malloc_return(buf);</span=
><br><span>     drv.ifd_len =3D buf_size;</span><br><span>     drv.ifd_data=
 =3D buf;</span><br><span> </span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail">chan=
ge 1669</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b78=
6b951b5262e47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1669 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--sYFihn8jrRE=--

