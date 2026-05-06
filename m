From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:21:27 +0000
References: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f9930df071b1778f8f2e7c91db88160d65e46100-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ua+J8t9Ubk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7ua+J8t9Ubk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail

to review the following change.


Change subject: dco_freebsd: Add check_malloc_return after realloc
......................................................................

dco_freebsd: Add check_malloc_return after realloc

cppcheck complained about a potential memleak
due to realloc failure. But trying to handle that
is probably not useful. Just abort like we do
for other malloc failures.

Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/cppcheck-suppression
M src/openvpn/dco_freebsd.c
2 files changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1669/1

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 1fefb51..c9d4714 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -49,6 +49,8 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Gerrit-Change-Number: 1669
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7ua+J8t9Ubk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_freebsd: Add check_malloc_return after =
realloc<br><br>cppcheck complained about a potential memleak<br>due to real=
loc failure. But trying to handle that<br>is probably not useful. Just abor=
t like we do<br>for other malloc failures.<br><br>Change-Id: Icd8ea093dfe9f=
1888570f3d7b786b951b5262e47<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/openvpn/d=
co_freebsd.c<br>2 files changed, 3 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/69/1669/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tool=
s/cppcheck-suppression</span><br><span>index 1fefb51..c9d4714 100644</span>=
<br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-to=
ols/cppcheck-suppression</span><br><span>@@ -49,6 +49,8 @@</span><br><span>=
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164</span><br><span> # =
FP: cppcheck seems to be confused since we cast the pointer to integer</spa=
n><br><span> memleak:src/plugins/down-root/down-root.c:337</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# IGN: we just abort instead</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+memleakOnRealloc:src/openvp=
n/dco_freebsd.c:845</span><br><span> # FP: eventmsg.h is not built on Unix<=
/span><br><span> missingInclude:src/openvpnserv/common.c:25</span><br><span=
> # IGN: strlen(NULL) is not nice code, but seems to work</span><br><span>d=
iff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br=
><span>index 718cd8b..eaca86b 100644</span><br><span>--- a/src/openvpn/dco_=
freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@=
@ -842,6 +842,7 @@</span><br><span> </span><br><span> retry:</span><br><spa=
n>     buf =3D realloc(buf, buf_size);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    check_malloc_return(buf);</span><br><span>     drv.i=
fd_len =3D buf_size;</span><br><span>     drv.ifd_data =3D buf;</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail">change 1669</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1669?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b78=
6b951b5262e47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1669 </div>
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

--7ua+J8t9Ubk=--

