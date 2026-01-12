From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 12 Jan 2026 14:10:17 +0000
References: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <c6fac0fe3c7ffd834ce45344f50f8789bad88bfd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+Mgweqgr3M4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Require
 script-security 2 when using unix: tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+Mgweqgr3M4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1465?usp=3Demail )


Change subject: Require script-security 2 when using unix: tun
......................................................................

Require script-security 2 when using unix: tun

Since this executes an executable from an arbitrary path, it should follow
the same rules as other scripts/executable.

Reported-By: Petr Simecek, Pavel Kohout and Stanislav Fort from Aisle Resea=
rch
Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/tun_afunix.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1465/1

diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index c410480..a67a472 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -61,7 +61,10 @@

     argv_printf(&argv, "%s", program);

-    tt->afunix.childprocess =3D openvpn_execve_check(&argv, env, S_NOWAITP=
ID, msgprefix);
+    /* exit when executing fails to easier spot errors here and treat this
+     * command like an external script */
+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;
+    tt->afunix.childprocess =3D openvpn_execve_check(&argv, env, flags, ms=
gprefix);
     if (!openvpn_waitpid_check(tt->afunix.childprocess, msgprefix, M_WARN))
     {
         tt->afunix.childprocess =3D 0;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1465?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Gerrit-Change-Number: 1465
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+Mgweqgr3M4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1465?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Require script-security 2 when using unix: tun<br><br>Since this execut=
es an executable from an arbitrary path, it should follow<br>the same rules=
 as other scripts/executable.<br><br>Reported-By: Petr Simecek, Pavel Kohou=
t and Stanislav Fort from Aisle Research<br>Change-Id: I89dcab24ba510094ce1=
672e382960bf15def310a<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>---<br>M src/openvpn/tun_afunix.c<br>1 file changed, 4 insertions(+), =
1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/65/1465/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun_a=
funix.c b/src/openvpn/tun_afunix.c</span><br><span>index c410480..a67a472 1=
00644</span><br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/=
src/openvpn/tun_afunix.c</span><br><span>@@ -61,7 +61,10 @@</span><br><span=
> </span><br><span>     argv_printf(&amp;argv, &quot;%s&quot;, program);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt=
-&gt;afunix.childprocess =3D openvpn_execve_check(&amp;argv, env, S_NOWAITP=
ID, msgprefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* exit when executing fails to easier spot errors here and treat this</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * command like an e=
xternal script */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tt-&gt;afunix.childprocess =3D openvpn_ex=
ecve_check(&amp;argv, env, flags, msgprefix);</span><br><span>     if (!ope=
nvpn_waitpid_check(tt-&gt;afunix.childprocess, msgprefix, M_WARN))</span><b=
r><span>     {</span><br><span>         tt-&gt;afunix.childprocess =3D 0;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1465?usp=3Demail">change 1465</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1465?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89dcab24ba510094ce1672e3829=
60bf15def310a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--+Mgweqgr3M4=--

