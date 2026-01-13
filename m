From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 08:46:54 +0000
In-Reply-To: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
References: <gerrit.1768227015000.I89dcab24ba510094ce1672e382960bf15def310a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ca76316302cb9738e6c2451dba1b0080bb07c941-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2JIMNMqhcsM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2JIMNMqhcsM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
65?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89dcab24ba510094ce1672e382960bf15def310a
Gerrit-Change-Number: 1465
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2JIMNMqhcsM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1465?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Require script-security 2 when using unix: tun<b=
r><br>Since this executes an executable from an arbitrary path, it should f=
ollow<br>the same rules as other scripts/executable.<br><br>Reported-By: Pe=
tr Simecek, Pavel Kohout and Stanislav Fort from Aisle Research<br>Change-I=
d: I89dcab24ba510094ce1672e382960bf15def310a<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1465<br>Message=
-Id: &lt;20260113072750.16015-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg35223.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/tun_afu=
nix.c<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><=
br><span>index c410480..a67a472 100644</span><br><span>--- a/src/openvpn/tu=
n_afunix.c</span><br><span>+++ b/src/openvpn/tun_afunix.c</span><br><span>@=
@ -61,7 +61,10 @@</span><br><span> </span><br><span>     argv_printf(&amp;a=
rgv, &quot;%s&quot;, program);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    tt-&gt;afunix.childprocess =3D openvpn_execv=
e_check(&amp;argv, env, S_NOWAITPID, msgprefix);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* exit when executing fails to easier spo=
t errors here and treat this</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * command like an external script */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S=
_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;a=
funix.childprocess =3D openvpn_execve_check(&amp;argv, env, flags, msgprefi=
x);</span><br><span>     if (!openvpn_waitpid_check(tt-&gt;afunix.childproc=
ess, msgprefix, M_WARN))</span><br><span>     {</span><br><span>         tt=
-&gt;afunix.childprocess =3D 0;</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1465?usp=3Demail">=
change 1465</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1465?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--2JIMNMqhcsM=--

