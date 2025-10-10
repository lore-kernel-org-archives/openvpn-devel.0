From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 21:28:37 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6ab7d5b6e2d72c906b37bc2f2850202f5f83404c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FvHF30VNxow="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_user_pass:
 Check fatal errors for empty username/password
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

--FvHF30VNxow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/474?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: test_user_pass: Check fatal errors for empty username/passw=
ord
......................................................................


Patch Set 13: Code-Review-2

(1 comment)

Patchset:

PS13:
While it passes BB and GHA checks(!), it fails for my local builds - both o=
n Linux and FreeBSD.

Output is just

```
...
PASS: ssl_testdriver
FAIL: user_pass_testdriver
PASS: push_update_msg_testdriver
...
```

if I run the binary from hand (not sure if this is supposed to work, it wor=
ks for all the other tests) it says

```
gert@...2718... ~/t_server.git/tests/unit_tests/openvpn $ ./user_pass_testd=
river
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 10 test(s).
[ RUN      ] test_get_user_pass_defined
...
[ RUN      ] test_get_user_pass_authfile_file_assertions
[  ERROR   ] --- srcdir
[   LINE   ] --- test_common.h:63: error: Failure!
[  FAILED  ] test_get_user_pass_authfile_file_assertions
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 10 test(s) run.
[  PASSED  ] 8 test(s).
[  FAILED  ] 2 test(s), listed below:
[  FAILED  ] test_get_user_pass_authfile_file
[  FAILED  ] test_get_user_pass_authfile_file_assertions

 2 FAILED TEST(S)
[ RUN      ] test_get_user_pass_authfile_file_assertions
[  ERROR   ] --- srcdir
[   LINE   ] --- test_common.h:63: error: Failure!
[  FAILED  ] test_get_user_pass_authfile_file_assertions
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 10 test(s) run.
[  PASSED  ] 8 test(s).
[  FAILED  ] 2 test(s), listed below:
[  FAILED  ] test_get_user_pass_authfile_file
[  FAILED  ] test_get_user_pass_authfile_file_assertions

 2 FAILED TEST(S)
```

I first thought it's something with "in tree builds", but it also fails "ou=
t of tree" builds (only tested on FreeBSD).  Maybe cmocka version?  1.1.8 o=
n FreeBSD, 1.1.5-r1 on gentoo.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Gerrit-Change-Number: 474
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 10 Oct 2025 21:28:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--FvHF30VNxow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p>The change is no longer submittable: Code-Review is unsatisfied now=
.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/474?tab=3Dcomments&amp;usp=3Demail">Patch Set #13:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">While it pa=
sses BB and GHA checks(!), it fails for my local builds - both on Linux and=
 FreeBSD.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Output is just</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">```<br>...<br>PASS: ssl_testdriver<br>FAIL=
: user_pass_testdriver<br>PASS: push_update_msg_testdriver<br>...<br>```</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">if I run the binary from hand (not sure if this is supposed to work, it w=
orks for all the other tests) it says</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">```<br>gert@...2718... ~/t_server=
.git/tests/unit_tests/openvpn $ ./user_pass_testdriver <br>[=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D] Running 10 test(s).<br>[ RUN      ] test_get_user_pass_def=
ined<br>...<br>[ RUN      ] test_get_user_pass_authfile_file_assertions<br>=
[  ERROR   ] --- srcdir<br>[   LINE   ] --- test_common.h:63: error: Failur=
e!<br>[  FAILED  ] test_get_user_pass_authfile_file_assertions<br>[=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D] 10 test(s) run.<br>[  PASSED  ] 8 test(s).<br>[  =
FAILED  ] 2 test(s), listed below:<br>[  FAILED  ] test_get_user_pass_authf=
ile_file<br>[  FAILED  ] test_get_user_pass_authfile_file_assertions</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"> 2 FAILED TEST(S)<br>[ RUN      ] test_get_user_pass_authfile_fi=
le_assertions<br>[  ERROR   ] --- srcdir<br>[   LINE   ] --- test_common.h:=
63: error: Failure!<br>[  FAILED  ] test_get_user_pass_authfile_file_assert=
ions<br>[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 10 test(s) run.<br>[  PASSED  ] 8 =
test(s).<br>[  FAILED  ] 2 test(s), listed below:<br>[  FAILED  ] test_get_=
user_pass_authfile_file<br>[  FAILED  ] test_get_user_pass_authfile_file_as=
sertions</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"> 2 FAILED TEST(S)<br>```</pre><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">I first thought =
it&#39;s something with &quot;in tree builds&quot;, but it also fails &quot=
;out of tree&quot; builds (only tested on FreeBSD).  Maybe cmocka version? =
 1.1.8 on FreeBSD, 1.1.5-r1 on gentoo.</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">chan=
ge 474</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Oct 2025 21:28:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--FvHF30VNxow=--

