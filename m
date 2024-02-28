From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 28 Feb 2024 14:37:38 +0000
In-Reply-To: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
References: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3b48d1257f9c543e88a981b6cbec2d3490b49235-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rn5MJcRDngE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rn5MJcRDngE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail

to look at the new patch set (#10).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: forked-test-driver: Show test output always
......................................................................

forked-test-driver: Show test output always

We want to see the progress, at least for slow tests
like t_client.sh.

Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M forked-test-driver
1 file changed, 7 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/479/10

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
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--rn5MJcRDngE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #10</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">forked-test-driver: Show test output always<br><br>We=
 want to see the progress, at least for slow tests<br>like t_client.sh.<br>=
<br>Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M forked-test-driver<b=
r>1 file changed, 7 insertions(+), 2 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/79/479/10</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/forked-test-driver b/forked-test-driver</span><br><span>index be73b80=
..6971dfb 100755</span><br><span>--- a/forked-test-driver</span><br><span>+=
++ b/forked-test-driver</span><br><span>@@ -108,9 +108,14 @@</span><br><spa=
n> # Test script is run here. We create the file first, then append to it,<=
/span><br><span> # to ameliorate tests themselves also writing to the log f=
ile. Our tests</span><br><span> # don&#39;t, but others can (automake bug#3=
5762).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OVPN change=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - add tee to s=
ee output of tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
  - needs portable pipefail mechanism</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+estatusfile=3D&quot;${trs_file}.exit&quot;</span><br><spa=
n> : &gt;&quot;$log_file&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-&quot;$@&quot; &gt;&gt;&quot;$log_file&quot; 2&gt;&amp;1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-estatus=3D$?</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+(&quot;$@&quot; 2&gt;&amp;1; estatus=
=3D$?; echo $estatus &gt;&quot;$estatusfile&quot;) | tee -a &quot;$log_file=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+estatus=3D$(c=
at &quot;$estatusfile&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+rm -f &quot;$estatusfile&quot;</span><br><span> </span><br><span> =
if test $enable_hard_errors =3D no &amp;&amp; test $estatus -eq 99; then</s=
pan><br><span>   tweaked_estatus=3D1</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Dema=
il">change 479</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11e0091482d9acee89ca018374c=
b8d96d22f8514 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--rn5MJcRDngE=--

