From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Apr 2024 07:41:28 +0000
In-Reply-To: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
References: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <75b80901675f8961270d1b9ef14acbe3a7302525-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zGkg7nTgpz0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: forked-test-driver:
 Show test output always
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

--zGkg7nTgpz0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/47=
9?usp=3Demail )

Change subject: forked-test-driver: Show test output always
......................................................................

forked-test-driver: Show test output always

We want to see the progress, at least for slow tests
like t_client.sh.

Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240125110122.16257-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
133.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M forked-test-driver
1 file changed, 7 insertions(+), 2 deletions(-)




diff --git a/forked-test-driver b/forked-test-driver
index be73b80..6971dfb 100755
--- a/forked-test-driver
+++ b/forked-test-driver
@@ -108,9 +108,14 @@
 # Test script is run here. We create the file first, then append to it,
 # to ameliorate tests themselves also writing to the log file. Our tests
 # don't, but others can (automake bug#35762).
+# OVPN changes:
+#  - add tee to see output of tests
+#  - needs portable pipefail mechanism
+estatusfile=3D"${trs_file}.exit"
 : >"$log_file"
-"$@" >>"$log_file" 2>&1
-estatus=3D$?
+("$@" 2>&1; estatus=3D$?; echo $estatus >"$estatusfile") | tee -a "$log_fi=
le"
+estatus=3D$(cat "$estatusfile")
+rm -f "$estatusfile"

 if test $enable_hard_errors =3D no && test $estatus -eq 99; then
   tweaked_estatus=3D1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Gerrit-Change-Number: 479
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--zGkg7nTgpz0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/479?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">forked-test-driver: Show test output always<br=
><br>We want to see the progress, at least for slow tests<br>like t_client.=
sh.<br><br>Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe=
 &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240125110122.16257-1-=
frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg28133.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M forked-test-driver<br>1 file changed, 7 insertions=
(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/forked-test-driver b/forked-test-driver</span><br><span>ind=
ex be73b80..6971dfb 100755</span><br><span>--- a/forked-test-driver</span><=
br><span>+++ b/forked-test-driver</span><br><span>@@ -108,9 +108,14 @@</spa=
n><br><span> # Test script is run here. We create the file first, then appe=
nd to it,</span><br><span> # to ameliorate tests themselves also writing to=
 the log file. Our tests</span><br><span> # don&#39;t, but others can (auto=
make bug#35762).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# O=
VPN changes:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - ad=
d tee to see output of tests</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#  - needs portable pipefail mechanism</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+estatusfile=3D&quot;${trs_file}.exit&quot;</spa=
n><br><span> : &gt;&quot;$log_file&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-&quot;$@&quot; &gt;&gt;&quot;$log_file&quot; 2&gt;&amp;1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-estatus=3D$?</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+(&quot;$@&quot; 2&gt;&amp;1;=
 estatus=3D$?; echo $estatus &gt;&quot;$estatusfile&quot;) | tee -a &quot;$=
log_file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+estat=
us=3D$(cat &quot;$estatusfile&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+rm -f &quot;$estatusfile&quot;</span><br><span> </span><br=
><span> if test $enable_hard_errors =3D no &amp;&amp; test $estatus -eq 99;=
 then</span><br><span>   tweaked_estatus=3D1</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?u=
sp=3Demail">change 479</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11e0091482d9acee89ca018374c=
b8d96d22f8514 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--zGkg7nTgpz0=--

