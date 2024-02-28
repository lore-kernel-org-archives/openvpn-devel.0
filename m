From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 28 Feb 2024 10:01:20 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <c8ecad6889039f9dd0662af0c04639e55c39c5b8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qau04ztutDM="; charset=UTF-8
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

--qau04ztutDM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/521?usp=3Demail )

Change subject: t_client.sh: Allow to skip tests
......................................................................


Patch Set 2: Code-Review-1

(5 comments)

Patchset:

PS2:
I think this is a useful patch but there seems to be a bit of friction to o=
vercome :-)


File src/openvpn/error.h:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/509f59c6_11cebc44 :
PS2, Line 39: #endif
I don't like this, for two reasons - we protect unistd.h via `HAVE_UNISTD_H=
`, not via "not windows", and also this is really a separate project, movin=
g out includes from `"syshead.h"` to the parent C file because some compile=
rs complain.


File tests/t_client.sh.in:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/4d712547_a890cc8a :
PS2, Line 301: SKIP_
> Like all the other test settings this is defined in the t_client.rc. [=E2=
=80=A6]
Having an example would certainly help people setting this up for their fir=
st time.


http://gerrit.openvpn.net/c/openvpn/+/521/comment/71a3de91_936dd75e :
PS2, Line 325:         eval $test_check_skip || {
while this certainly works, the `|| {` style is quite different from the ve=
ry traditional `if/then/fi` style of the rest of the script.  So I'm a bit =
undecided what to think about it.

```
    if eval $test_check_skip ; then :
    else
        output ...
        ...
    fi
```
is not as compact, but might be easier to grok?


File tests/unit_tests/openvpn/mock_msg.c:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/4daebdcf_1d3501b2 :
PS2, Line 94: endif
> assert_failed is defined in error. [=E2=80=A6]
Not sure I understand why we have cmocka specific .c files with #ifdef NO_C=
MOCKA?  Is this ever used outside the unit test context?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Gerrit-Change-Number: 521
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 28 Feb 2024 10:01:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--qau04ztutDM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/521?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I think this is a useful patch but there seem=
s to be a bit of friction to overcome :-)</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/error.h:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/521/comment/509f59c6_11cebc44">Patch Set #2, Line 39:</a> <code style=3D"f=
ont-family:monospace,monospace">#endif</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I don&#39;t like this, for two reasons - w=
e protect unistd.h via `HAVE_UNISTD_H`, not via &quot;not windows&quot;, an=
d also this is really a separate project, moving out includes from `&quot;s=
yshead.h&quot;` to the parent C file because some compilers complain.</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/t_client.sh=
.in:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/521/comment/4d712547_a890cc8a">Patch Set #2, =
Line 301:</a> <code style=3D"font-family:monospace,monospace">SKIP_</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Like all the other test settings this is defined in the t_cl=
ient.rc. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Having an example would certainly help people setting =
this up for their first time.</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/521/comment/71a3de91_936dd75e">Patch Set #2, Line 325:</a> =
<code style=3D"font-family:monospace,monospace">        eval $test_check_sk=
ip || {</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">while this certainly works, the `|| {` style is quite different from the =
very traditional `if/then/fi` style of the rest of the script.  So I&#39;m =
a bit undecided what to think about it.</p><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">```<br>    if eval $test_check_skip=
 ; then : <br>    else<br>        output ...<br>        ...<br>    fi<br>``=
`<br>is not as compact, but might be easier to grok?</pre></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/mock_ms=
g.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/521/comment/4daebdcf_1d3501b2">Patch Set #2, =
Line 94:</a> <code style=3D"font-family:monospace,monospace">endif</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">assert_failed is defined in error. [=E2=80=A6]</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure I und=
erstand why we have cmocka specific .c files with #ifdef NO_CMOCKA?  Is thi=
s ever used outside the unit test context?</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">=
change 521</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ea6752c8d102eabcc579e3918=
28c05d5322899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Feb 2024 10:01:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qau04ztutDM=--

