From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 12:41:22 +0000
In-Reply-To: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
References: <gerrit.1702310034000.I11e0091482d9acee89ca018374cb8d96d22f8514@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <fe1bde76439f4e455ab3053b32998e762cd0b5c6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rEIq3r9KOTQ="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rEIq3r9KOTQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/479?usp=3Demail )

Change subject: forked-test-driver: Show test output always
......................................................................


Patch Set 5: Code-Review-1

(1 comment)

Patchset:

PS5:
The patch does not do what it promises to do. I cherry-picked this patch an=
d the other forked-test-driver patch on my branch and in github actions sti=
ll only reports that a unit test has failed without any indication of why:

PASS: argv_testdriver
FAIL: buffer_testdriver
PASS: crypto_testdriver

https://github.com/schwabe/openvpn/actions/runs/7385546211/job/20090514521



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I11e0091482d9acee89ca018374cb8d96d22f8514
Gerrit-Change-Number: 479
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 02 Jan 2024 12:41:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--rEIq3r9KOTQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/479?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/479?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">The patch does not do what it promises to do. =
I cherry-picked this patch and the other forked-test-driver patch on my bra=
nch and in github actions still only reports that a unit test has failed wi=
thout any indication of why:</p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">PASS: argv_testdriver<br>FAIL: buffer_testdriver<br>PASS: c=
rypto_testdriver</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">https://github.com/schwabe/openvpn/actions/runs/7385546211/job/20090514=
521</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/479?usp=3Demail">change 479</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/479?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11e0091482d9acee89ca018374c=
b8d96d22f8514 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 02 Jan 2024 12:41:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--rEIq3r9KOTQ=--

