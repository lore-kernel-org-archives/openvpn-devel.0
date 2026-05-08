From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 15:48:46 +0000
In-Reply-To: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
References: <gerrit.1778102459000.Icd8ea093dfe9f1888570f3d7b786b951b5262e47@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d4dc0dd5e985e3e3cf6df86773e2207e2c35bf48-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cH5xrzI0JU4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cH5xrzI0JU4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
69?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd8ea093dfe9f1888570f3d7b786b951b5262e47
Gerrit-Change-Number: 1669
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cH5xrzI0JU4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1669?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco_freebsd: Add check_malloc_return after reall=
oc<br><br>cppcheck complained about a potential memleak<br>due to realloc f=
ailure. But trying to handle that<br>is probably not useful. Just abort lik=
e we do<br>for other malloc failures.<br><br>Change-Id: Icd8ea093dfe9f18885=
70f3d7b786b951b5262e47<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1669<br>Message-Id: &lt;2026050707532=
1.25123-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg36842.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/o=
penvpn/dco_freebsd.c<br>2 files changed, 3 insertions(+), 0 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppres=
sion</span><br><span>index 1f31edb..439cbb1 100644</span><br><span>--- a/de=
v-tools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppr=
ession</span><br><span>@@ -44,6 +44,8 @@</span><br><span> knownConditionTru=
eFalse:src/openvpnmsica/dllmain.c:164</span><br><span> # FP: cppcheck seems=
 to be confused since we cast the pointer to integer</span><br><span> memle=
ak:src/plugins/down-root/down-root.c:337</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# IGN: we just abort instead</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+memleakOnRealloc:src/openvpn/dco_freebsd.c:84=
5</span><br><span> # FP: eventmsg.h is not built on Unix</span><br><span> m=
issingInclude:src/openvpnserv/common.c:25</span><br><span> # IGN: strlen(NU=
LL) is not nice code, but seems to work</span><br><span>diff --git a/src/op=
envpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index 718cd=
8b..eaca86b 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><b=
r><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -842,6 +842,7 @@=
</span><br><span> </span><br><span> retry:</span><br><span>     buf =3D rea=
lloc(buf, buf_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    check_malloc_return(buf);</span><br><span>     drv.ifd_len =3D buf_siz=
e;</span><br><span>     drv.ifd_data =3D buf;</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1669?usp=3Demail">change 1669</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1669?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--cH5xrzI0JU4=--

