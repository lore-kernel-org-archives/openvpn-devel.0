From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 13:21:55 +0000
In-Reply-To: <gerrit.1697629414000.I2d353a0cea0a62f289b8c1060244df66dd7a14cb@...2715...>
References: <gerrit.1697629414000.I2d353a0cea0a62f289b8c1060244df66dd7a14cb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f58b190d25171fbb41d2fd9c11a9794dd3122fc9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eRjjohMKajI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove openssl
 engine method for loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eRjjohMKajI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/373?usp=3Demail )

Change subject: Remove openssl engine method for loading the key
......................................................................


Patch Set 1:

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/373/comment/0149c5eb_55c90e09 :
PS1, Line 10: deprecated since OpenSSL 3.0 and James Bottomlehy has not agr=
eed
> "Bottomley"
Done


http://gerrit.openvpn.net/c/openvpn/+/373/comment/af84499a_816aed3b :
PS1, Line 11: to the proposed license chagne. He is also okay with removing
> "change"
Done


http://gerrit.openvpn.net/c/openvpn/+/373/comment/63ad92ba_355c5268 :
PS1, Line 12: with the feature from the current code base as it is obsolete=
 with
> remove "with"
Done


http://gerrit.openvpn.net/c/openvpn/+/373/comment/1342b05c_74711bb4 :
PS1, Line 14:
> I think the commit message should mention the original commit that introd=
uced the feature.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d353a0cea0a62f289b8c1060244df66dd7a14cb
Gerrit-Change-Number: 373
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 13:21:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--eRjjohMKajI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/373/comment/0149c5eb_55c90e09">Patch Set #1, Line 10:</a> <code style=
=3D"font-family:monospace,monospace">deprecated since OpenSSL 3.0 and James=
 Bottomlehy has not agreed</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;Bottomley&quot;</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373/comment/a=
f84499a_816aed3b">Patch Set #1, Line 11:</a> <code style=3D"font-family:mon=
ospace,monospace">to the proposed license chagne. He is also okay with remo=
ving</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;change&quot;</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/373/comment/63ad92ba_355c5268">Patch S=
et #1, Line 12:</a> <code style=3D"font-family:monospace,monospace">with th=
e feature from the current code base as it is obsolete with</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">remove &quot;with&quot;</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/373/comment/1342b05c_74711bb4">Patch Set #1, Line 14:=
</a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>I think the commit message should mention the original commit that introdu=
ced the feature.</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail">change 373</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/373?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d353a0cea0a62f289b8c106024=
4df66dd7a14cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 373 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 13:21:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eRjjohMKajI=--

