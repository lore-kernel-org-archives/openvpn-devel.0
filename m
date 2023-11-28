From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 14:03:30 +0000
In-Reply-To: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <add22a7543e778c3a60c2adec9a264cb7b530c3c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xwaeov7APuM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Document tls-exit
 option mainly as test option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Xwaeov7APuM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/447?usp=3Demail )

Change subject: Document tls-exit option mainly as test option
......................................................................


Patch Set 2:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/447/comment/fd71717e_4dfcdc38 :
PS1, Line 9: This option is questionable and I cannot see any reason to act=
ually use it.
> t_cltsrv.sh uses it, so I think when claiming it is questionable you shou=
ld remove that usage first.
Done


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/447/comment/3268e8cb_33c9d95b :
PS1, Line 15:     the will otherwise be removed in the future.
> "the option will"
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Gerrit-Change-Number: 447
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 28 Nov 2023 14:03:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Xwaeov7APuM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/447/comment/fd71717e_4dfcdc38">Patch Set #1, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">This option is questionable and I cann=
ot see any reason to actually use it.</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">t_cltsrv.sh use=
s it, so I think when claiming it is questionable you should remove that us=
age first.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile Changes.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/447/comment/3268e8cb_33c9d95b">=
Patch Set #1, Line 15:</a> <code style=3D"font-family:monospace,monospace">=
    the will otherwise be removed in the future.</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quo=
t;the option will&quot;</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail">change 447</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/447?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd=
4ebc8bfb0cc3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 447 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Nov 2023 14:03:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Xwaeov7APuM=--

