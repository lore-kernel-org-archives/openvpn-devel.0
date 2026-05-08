From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:26:56 +0000
In-Reply-To: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
References: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <9fbf647b4cc7406e8063e0c86153d42239fdd198-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YJdPsRg3Wfs="; charset=UTF-8
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

--YJdPsRg3Wfs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail

to look at the new patch set (#2).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1669/2

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index f92f7f4..2e3350b 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -62,6 +62,8 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--YJdPsRg3Wfs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">dco_freebsd: Add check_malloc_return=
 after realloc<br><br>cppcheck complained about a potential memleak<br>due =
to realloc failure. But trying to handle that<br>is probably not useful. Ju=
st abort like we do<br>for other malloc failures.<br><br>Change-Id: Icd8ea0=
93dfe9f1888570f3d7b786b951b5262e47<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/op=
envpn/dco_freebsd.c<br>2 files changed, 3 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/69/1669/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/d=
ev-tools/cppcheck-suppression</span><br><span>index f92f7f4..2e3350b 100644=
</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b=
/dev-tools/cppcheck-suppression</span><br><span>@@ -62,6 +62,8 @@</span><br=
><span> knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164</span><br><s=
pan> # FP: cppcheck seems to be confused since we cast the pointer to integ=
er</span><br><span> memleak:src/plugins/down-root/down-root.c:337</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: we just abort instead<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+memleakOnRealloc:src=
/openvpn/dco_freebsd.c:845</span><br><span> # FP: eventmsg.h is not built o=
n Unix</span><br><span> missingInclude:src/openvpnserv/common.c:25</span><b=
r><span> # IGN: strlen(NULL) is not nice code, but seems to work</span><br>=
<span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</s=
pan><br><span>index 718cd8b..eaca86b 100644</span><br><span>--- a/src/openv=
pn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br>=
<span>@@ -842,6 +842,7 @@</span><br><span> </span><br><span> retry:</span><=
br><span>     buf =3D realloc(buf, buf_size);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    check_malloc_return(buf);</span><br><span>   =
  drv.ifd_len =3D buf_size;</span><br><span>     drv.ifd_data =3D buf;</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail">change 1669</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1669?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b78=
6b951b5262e47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1669 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--YJdPsRg3Wfs=--

