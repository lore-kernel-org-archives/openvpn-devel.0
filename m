From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 21 Feb 2024 10:47:39 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, a@...2181...
Message-ID: <b0832391cc375a49746dfd31a8fcda7437c869e1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Gd9wKSaw7g="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/Gd9wKSaw7g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/521?usp=3Demail )

Change subject: t_client.sh: Allow to skip tests
......................................................................


Patch Set 2:

(2 comments)

File tests/t_client.sh.in:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/c1be2335_8f5e8256 :
PS2, Line 301: SKIP_
> I am probably clueless about this, but where is $SKIP filled?
Like all the other test settings this is defined in the t_client.rc. I can =
add an example to t_client.rc-sample


File tests/unit_tests/openvpn/mock_msg.c:

http://gerrit.openvpn.net/c/openvpn/+/521/comment/0cb16f2d_9efcdae7 :
PS2, Line 94: endif
> I wonder if mock_msg.c is the right place for assert_failed(). [=E2=80=A6]
assert_failed is defined in error.c like all the other functions mocked her=
e, so it seems like a natural place.

The alternatives I saw for my patch were:
- duplicate mock_msg.c outside of unit_tests/openvpn. But except for assert=
_failed this works perfectly fine.
- try to use original error.c. But that pulls in a lot of platform code. We=
 could look into split out all the complex msg stuff from error.c into its =
own msg.c. Then we could use error.c in the tests and mock less stuff here.
- move assert_failed to its own mock_assert.c. The current solution seems s=
lightly simpler. But that would obviously be a possible alternative if we d=
on't like the NO_CMOCKA define.



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
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 21 Feb 2024 10:47:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--/Gd9wKSaw7g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/t_client.sh.in:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/521/comment/c1be2335_8f5e8256">Patch Set #2, Line 301:</a>=
 <code style=3D"font-family:monospace,monospace">SKIP_</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">I am probably clueless about this, but where is $SKIP filled?</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Like all th=
e other test settings this is defined in the t_client.rc. I can add an exam=
ple to t_client.rc-sample</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File tests/unit_tests/openvpn/mock_msg.c:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/521/comment/0cb16f2d_9efcdae7">Patch Set #2, Line 94:</a> <code style=3D"f=
ont-family:monospace,monospace">endif</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I wonder if moc=
k_msg.c is the right place for assert_failed(). [=E2=80=A6]</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">assert_failed i=
s defined in error.c like all the other functions mocked here, so it seems =
like a natural place.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">The alternatives I saw for my patch were:</p><ul><li>duplicate moc=
k_msg.c outside of unit_tests/openvpn. But except for assert_failed this wo=
rks perfectly fine.</li><li>try to use original error.c. But that pulls in =
a lot of platform code. We could look into split out all the complex msg st=
uff from error.c into its own msg.c. Then we could use error.c in the tests=
 and mock less stuff here.</li><li>move assert_failed to its own mock_asser=
t.c. The current solution seems slightly simpler. But that would obviously =
be a possible alternative if we don&#39;t like the NO_CMOCKA define.</li></=
ul></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/521?usp=3Demail">change 521</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/52=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ea6752c8d102eabcc579e3918=
28c05d5322899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Feb 2024 10:47:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/Gd9wKSaw7g=--

