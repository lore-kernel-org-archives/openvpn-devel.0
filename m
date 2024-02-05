From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 5 Feb 2024 11:46:43 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f894d1fb12bed9522c5091738e14aa4cb10a404-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QlOVDa2lWGA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
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

--QlOVDa2lWGA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/506?usp=3Demail )

Change subject: Implement support for AEAD tag at the end
......................................................................


Patch Set 2: Code-Review+1

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/1c8aa1ad_cba5214d :
PS2, Line 8:
Maybe some motivation?


http://gerrit.openvpn.net/c/openvpn/+/506/comment/3a5c437c_30f55a3a :
PS2, Line 9: Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Missing sign-off


Patchset:

PS2:
Makes sense to me, but needs some cleanup


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/b447119b_b157eadb :
PS2, Line 110: /** Suport for the AEAD tag at the end a larger peer id and =
IV */
"a" -> "and"


http://gerrit.openvpn.net/c/openvpn/+/506/comment/a84daf75_4a3a415b :
PS2, Line 111: #define IV_PROTO_DATA_V3        (1<<10)
This define seems unused in the current patch?


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/f618ebc3_e68399f8 :
PS2, Line 269: /* This adds a few more methods that strictly necessary but =
this allows
"that" -> "than"?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 05 Feb 2024 11:46:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--QlOVDa2lWGA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/506/comment/1c8aa1ad_cba5214d">Patch Set #2, Line 8:</a> <code st=
yle=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Maybe some motivation?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/506/comment/3a5c437c_30f55a3a">=
Patch Set #2, Line 9:</a> <code style=3D"font-family:monospace,monospace">C=
hange-Id: I00821d75342daf3f813b829812d648fe298bea81</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Missing sign-off</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/506?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Makes sense to me, but needs some cleanup</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/s=
sl.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/506/comment/b447119b_b157eadb">Patch Set #2,=
 Line 110:</a> <code style=3D"font-family:monospace,monospace">/** Suport f=
or the AEAD tag at the end a larger peer id and IV */</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">&quot;a&quot; -&gt; &quot;a=
nd&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506/c=
omment/a84daf75_4a3a415b">Patch Set #2, Line 111:</a> <code style=3D"font-f=
amily:monospace,monospace">#define IV_PROTO_DATA_V3        (1&lt;&lt;10)</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This def=
ine seems unused in the current patch?</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/506/comment/f618ebc3_e68399f8">Patch Set #2, Line 269:</a> <c=
ode style=3D"font-family:monospace,monospace">/* This adds a few more metho=
ds that strictly necessary but this allows</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">&quot;that&quot; -&gt; &quot;than&quot=
;?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Feb 2024 11:46:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QlOVDa2lWGA=--

