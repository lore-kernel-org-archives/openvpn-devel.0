From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 08:46:52 +0000
In-Reply-To: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
References: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ca76316302cb9738e6c2451dba1b0080bb07c941-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aFtTpL8Kf3I="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aFtTpL8Kf3I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1465?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Require script-security 2 when using unix: tun
......................................................................

Require script-security 2 when using unix: tun

Since this executes an executable from an arbitrary path, it should follow
the same rules as other scripts/executable.

Reported-By: Petr Simecek, Pavel Kohout and Stanislav Fort from Aisle Resea=
rch
Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1465
Message-Id: <20260113072750.16015-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
223.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun_afunix.c
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1465/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Gerrit-Change-Number: 1465
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aFtTpL8Kf3I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1465?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Require script-security 2 wh=
en using unix: tun<br><br>Since this executes an executable from an arbitra=
ry path, it should follow<br>the same rules as other scripts/executable.<br=
><br>Reported-By: Petr Simecek, Pavel Kohout and Stanislav Fort from Aisle =
Research<br>Change-Id: I89dcab24ba510094ce1672e382960bf15def310a<br>Signed-=
off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1465<br>Message-Id: &lt;20260113072750.16015-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
223.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/tun_afunix.c<br>1 file changed, 4 insertions(+), 1 deletion(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/65/1465/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun_afunix.c b/src=
/openvpn/tun_afunix.c</span><br><span>index c410480..a67a472 100644</span><=
br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/src/openvpn/t=
un_afunix.c</span><br><span>@@ -61,7 +61,10 @@</span><br><span> </span><br>=
<span>     argv_printf(&amp;argv, &quot;%s&quot;, program);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;afunix.c=
hildprocess =3D openvpn_execve_check(&amp;argv, env, S_NOWAITPID, msgprefix=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* exit when =
executing fails to easier spot errors here and treat this</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * command like an external scrip=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =
=3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    tt-&gt;afunix.childprocess =3D openvpn_execve_check(&=
amp;argv, env, flags, msgprefix);</span><br><span>     if (!openvpn_waitpid=
_check(tt-&gt;afunix.childprocess, msgprefix, M_WARN))</span><br><span>    =
 {</span><br><span>         tt-&gt;afunix.childprocess =3D 0;</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1465?usp=3Demail">change 1465</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1465?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89dcab24ba510094ce1672e3829=
60bf15def310a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--aFtTpL8Kf3I=--

