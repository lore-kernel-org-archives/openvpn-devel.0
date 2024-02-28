From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 28 Feb 2024 13:36:12 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296..., a@...2181...
Message-ID: <ad99fb584c3955d724e411edc20982143c03027d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hYuYWqpX5lM="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hYuYWqpX5lM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/521?usp=3Demail )

Change subject: t_client.sh: Allow to skip tests
......................................................................


Patch Set 2:

(4 comments)

File src/openvpn/error.h:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/79ea4054_64ee021d :
PS2, Line 39: #endif
> I don't like this, for two reasons - we protect unistd. [=E2=80=A6]
Acknowledged


File tests/t_client.sh.in:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/d9c095ee_2955765a :
PS2, Line 301: SKIP_
> Having an example would certainly help people setting this up for their f=
irst time.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/521/comment/df742960_4d92cd9b :
PS2, Line 325:         eval $test_check_skip || {
> while this certainly works, the `|| {` style is quite different from the =
very traditional `if/then/f [=E2=80=A6]
Acknowledged


File tests/unit_tests/openvpn/mock_msg.c:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/91fc1e95_73420afd :
PS2, Line 94: endif
> Not sure I understand why we have cmocka specific . [=E2=80=A6]
Yes, in this PR it is now used in t_client context, which is not a unit tes=
t context



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 28 Feb 2024 13:36:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--hYuYWqpX5lM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/error.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/521/comment/79ea4054_64ee021d">Patch Set #2, Line 39:</a> <=
code style=3D"font-family:monospace,monospace">#endif</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>I don&#39;t like this, for two reasons - we protect unistd. [=E2=80=A6]</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File t=
ests/t_client.sh.in:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/521/comment/d9c095ee_2955765a=
">Patch Set #2, Line 301:</a> <code style=3D"font-family:monospace,monospac=
e">SKIP_</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Having an example would certainly help peopl=
e setting this up for their first time.</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/521/comment/df742960_4d92cd9b">Patch=
 Set #2, Line 325:</a> <code style=3D"font-family:monospace,monospace">    =
    eval $test_check_skip || {</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">while this certainly w=
orks, the `|| {` style is quite different from the very traditional `if/the=
n/f [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/unit_tests/openvpn/mock_msg.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/521/comment/91fc1e95_73420afd">Patch Set #2, Line 94:</a> <code style=
=3D"font-family:monospace,monospace">endif</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure=
 I understand why we have cmocka specific . [=E2=80=A6]</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, in this PR it =
is now used in t_client context, which is not a unit test context</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/521?usp=3Demail">change 521</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Feb 2024 13:36:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--hYuYWqpX5lM=--

