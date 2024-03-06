From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 6 Mar 2024 09:57:55 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <65ff90cb50f82475061e2848cbe9bc99b3b7bc8f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RgeK1yCnL8w="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh: Allow
 to skip tests
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

--RgeK1yCnL8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/521?usp=3Demail )

Change subject: t_client.sh: Allow to skip tests
......................................................................


Patch Set 4: Code-Review-1

(4 comments)

Patchset:

PS4:
Took me longer than expected after v4, but I do have some more wishes... (t=
hanks for bearing with me)


File tests/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/aabb9cc6_e1155271 :
PS4, Line 45: 	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
OK, so now I do better understand the -DNO_CMOCKA code in unit_tests/openvp=
n/mock_msg.c - but I'm none the happier.  Unit test code is unit test code,=
 and shouldn't be used by something else (=3D so when trying to understand =
code in unit_tests/ I don't really want to consider "oh, wait, this is also=
 used by some other piece of code").

But I can't really can come up with a nice alternative that will not boil d=
own to "just add another copy of `msg()` mocking into ntlm_support.c" (beca=
use `crypto_load_provider()` needs it).


File tests/t_client.rc-sample:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/7c7d3b68_b8417006 :
PS4, Line 67: # SKIP_x            =3D "commands to execute before openvpn, =
skip test on failure"
TBH, I do not like `SKIP_x` because it just tells me "well, yes, skip this =
test".

I'd suggest to rename it to something like `SKIP_CONDITIONAL_x` or `PRE_TES=
T_x` or so which better transports the message "ah, this is a command to ru=
n, and depending on the outcome, things will be skipped".


http://gerrit.openvpn.net/c/openvpn/+/521/comment/34ed3c96_6462fbf2 :
PS4, Line 70: # CLEANUP_x         =3D "commands to execute after the test"
this is a very welcome addition to the last options that I forgot to proper=
ly document.  Thanks ;-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Gerrit-Change-Number: 521
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 06 Mar 2024 09:57:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--RgeK1yCnL8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/521?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Took me longer than expected after v4, but I =
do have some more wishes... (thanks for bearing with me)</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File tests/Makefile.am:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/521/comment/aabb9cc6_e1155271">Patch Set #4, Line 45:</a> <co=
de style=3D"font-family:monospace,monospace">	unit_tests/openvpn/mock_msg.c=
 unit_tests/openvpn/mock_msg.h \</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">OK, so now I do better understand the -DNO_CMOCK=
A code in unit_tests/openvpn/mock_msg.c - but I&#39;m none the happier.  Un=
it test code is unit test code, and shouldn&#39;t be used by something else=
 (=3D so when trying to understand code in unit_tests/ I don&#39;t really w=
ant to consider &quot;oh, wait, this is also used by some other piece of co=
de&quot;).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Bu=
t I can&#39;t really can come up with a nice alternative that will not boil=
 down to &quot;just add another copy of `msg()` mocking into ntlm_support.c=
&quot; (because `crypto_load_provider()` needs it).</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File tests/t_client.rc-sample:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/521/comment/7c7d3b68_b8417006">Patch Set #4, Line 67:</a> <=
code style=3D"font-family:monospace,monospace"># SKIP_x            =3D &quo=
t;commands to execute before openvpn, skip test on failure&quot;</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">TBH, I do not li=
ke `SKIP_x` because it just tells me &quot;well, yes, skip this test&quot;.=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;d sugg=
est to rename it to something like `SKIP_CONDITIONAL_x` or `PRE_TEST_x` or =
so which better transports the message &quot;ah, this is a command to run, =
and depending on the outcome, things will be skipped&quot;.</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/521/comment/34ed3c96_6462fbf2=
">Patch Set #4, Line 70:</a> <code style=3D"font-family:monospace,monospace=
"># CLEANUP_x         =3D &quot;commands to execute after the test&quot;</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this is =
a very welcome addition to the last options that I forgot to properly docum=
ent.  Thanks ;-)</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">change 521</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/521?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ea6752c8d102eabcc579e3918=
28c05d5322899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 06 Mar 2024 09:57:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RgeK1yCnL8w=--

