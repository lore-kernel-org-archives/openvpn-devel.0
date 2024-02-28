From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 28 Feb 2024 13:03:11 +0000
In-Reply-To: <gerrit.1702310034000.I67d461afbcc9c06b1fc5ab4477141d7b8bd9ba8e@...2715...>
References: <gerrit.1702310034000.I67d461afbcc9c06b1fc5ab4477141d7b8bd9ba8e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fd592c0a7afefc4be4ba5bd11ac4455774c2981e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fMn/FHr+/PA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: fork default
 automake test-driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fMn/FHr+/PA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/478?usp=3Demail )

Change subject: tests: fork default automake test-driver
......................................................................


Patch Set 8:

(1 comment)

Patchset:

PS8:
Some additional context for this patch and #479:

Originally the switch to parallel test framework was triggered by
https://gerrit.openvpn.net/c/openvpn/+/474 which required setting
up additional environment. This is also possible in the serial-test
framework, but was much more obvious with parallel.

The parallel test framework is the newer one which offers a lot more
options for customization. It is recommended by automake authors.
So I tested whether it works with our tests or whether there is any
reason it wouldn't work. It works fine.

In parallel there was a discussion where cron2 complained about the
test execution being too verbose, especially for the UTs. This is
addressed by the parallel test framework which is much less verbose
by default, but can't be addressed in serial-test framework.

The problem is that the parallel test framework default behavior is
not desirable in t_client context since that runs for a long time
and we would like to see live progress. This is solvable in the
parallel test framework since it is very configurable, but it
requires us forking the default test driver since the default
test driver itself is not configurable. You need to override it.
That is implemented by
https://gerrit.openvpn.net/c/openvpn/+/478 (copy test driver)
https://gerrit.openvpn.net/c/openvpn/+/479 (patch it)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I67d461afbcc9c06b1fc5ab4477141d7b8bd9ba8e
Gerrit-Change-Number: 478
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Comment-Date: Wed, 28 Feb 2024 13:03:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--fMn/FHr+/PA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/478?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
78?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Some additional context for this patch and #479:</=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Originally the=
 switch to parallel test framework was triggered by<br>https://gerrit.openv=
pn.net/c/openvpn/+/474 which required setting<br>up additional environment.=
 This is also possible in the serial-test<br>framework, but was much more o=
bvious with parallel.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">The parallel test framework is the newer one which offers a lot mo=
re<br>options for customization. It is recommended by automake authors.<br>=
So I tested whether it works with our tests or whether there is any<br>reas=
on it wouldn&#39;t work. It works fine.</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">In parallel there was a discussion where cron2 c=
omplained about the<br>test execution being too verbose, especially for the=
 UTs. This is<br>addressed by the parallel test framework which is much les=
s verbose<br>by default, but can&#39;t be addressed in serial-test framewor=
k.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The proble=
m is that the parallel test framework default behavior is<br>not desirable =
in t_client context since that runs for a long time<br>and we would like to=
 see live progress. This is solvable in the<br>parallel test framework sinc=
e it is very configurable, but it<br>requires us forking the default test d=
river since the default<br>test driver itself is not configurable. You need=
 to override it.<br>That is implemented by<br>https://gerrit.openvpn.net/c/=
openvpn/+/478 (copy test driver)<br>https://gerrit.openvpn.net/c/openvpn/+/=
479 (patch it)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/478?usp=3Demail">change 478</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/478?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I67d461afbcc9c06b1fc5ab44771=
41d7b8bd9ba8e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 478 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Feb 2024 13:03:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fMn/FHr+/PA=--

