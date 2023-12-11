From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 15:54:00 +0000
References: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f8d257e447bbf45c3a6ae496d122538f0a3cb0ec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jzmdf0tBogE="; charset=UTF-8
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

--Jzmdf0tBogE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail

to review the following change.


Change subject: forked-test-driver: Show test output always
......................................................................

forked-test-driver: Show test output always

We want to see the progress, especially for slow tests
like t_client.sh.

Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M forked-test-driver
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/479/1

diff --git a/forked-test-driver b/forked-test-driver
index be73b80..1baaa84 100755
--- a/forked-test-driver
+++ b/forked-test-driver
@@ -109,7 +109,7 @@
 # to ameliorate tests themselves also writing to the log file. Our tests
 # don't, but others can (automake bug#35762).
 : >"$log_file"
-"$@" >>"$log_file" 2>&1
+"$@" 2>&1 | tee -a "$log_file"
 estatus=3D$?

 if test $enable_hard_errors =3D no && test $estatus -eq 99; then

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Gerrit-Change-Number: 479
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Jzmdf0tBogE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">forked-test-driver: Show test output always<br><br>We want to=
 see the progress, especially for slow tests<br>like t_client.sh.<br><br>Ch=
ange-Id: I11e0091482d9acee89ca018374cb8d96d22f8514<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M forked-test-driver<br>1 fi=
le changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/79/479/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/forked-=
test-driver b/forked-test-driver</span><br><span>index be73b80..1baaa84 100=
755</span><br><span>--- a/forked-test-driver</span><br><span>+++ b/forked-t=
est-driver</span><br><span>@@ -109,7 +109,7 @@</span><br><span> # to amelio=
rate tests themselves also writing to the log file. Our tests</span><br><sp=
an> # don&#39;t, but others can (automake bug#35762).</span><br><span> : &g=
t;&quot;$log_file&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-&quot;$@&quot; &gt;&gt;&quot;$log_file&quot; 2&gt;&amp;1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+&quot;$@&quot; 2&gt;&amp;1 | tee -a =
&quot;$log_file&quot;</span><br><span> estatus=3D$?</span><br><span> </span=
><br><span> if test $enable_hard_errors =3D no &amp;&amp; test $estatus -eq=
 99; then</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail">change 479</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/479?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11e0091482d9acee89ca018374c=
b8d96d22f8514 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Jzmdf0tBogE=--

