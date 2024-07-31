From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 31 Jul 2024 11:42:16 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <1ac81f04300e3a318189fb00555dcd19d2dda406-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+p3uhcV9Kc="; charset=UTF-8
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
Cc: syzzer <steffan@...1856...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2+p3uhcV9Kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/506?usp=3Demail )

Change subject: Implement support for AEAD tag at the end
......................................................................


Patch Set 6: Code-Review+1

(2 comments)

Patchset:

PS6:
Apart from one comment-related nit-pick, I couldn't find anything wrong. I =
am planning to test this soonish with dco-win + data_v3.


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/747528fe_47ac025e :
PS6, Line 268: /* This adds a few more methods than strictly necessary but =
this allows
"that strictly necessary" or "that are not strictly necessary" ?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Comment-Date: Wed, 31 Jul 2024 11:42:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--2+p3uhcV9Kc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, syzzer. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/506?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Apart from one comment-related nit-pick, I co=
uldn&#39;t find anything wrong. I am planning to test this soonish with dco=
-win + data_v3.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile tests/unit_tests/openvpn/test_ssl.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506/comme=
nt/747528fe_47ac025e">Patch Set #6, Line 268:</a> <code style=3D"font-famil=
y:monospace,monospace">/* This adds a few more methods than strictly necess=
ary but this allows</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">&quot;that strictly necessary&quot; or &quot;that are not str=
ictly necessary&quot; ?</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 31 Jul 2024 11:42:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--2+p3uhcV9Kc=--

