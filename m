From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 18 Dec 2023 07:53:38 +0000
In-Reply-To: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d7406b53abe3f3cf6e7e442673c2360a195410c6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VV7r3E+raHY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun.c: don't attempt
 to delete DNS and WINS servers if they're not set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VV7r3E+raHY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/482?usp=3Demail )

Change subject: tun.c: don't attempt to delete DNS and WINS servers if they=
're not set
......................................................................


Patch Set 1:

(1 comment)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/482/comment/d7d9f828_cf70f1a1 :
PS1, Line 19: However, due to bug we always attempted to remove DNS/WINS,
> What's the issue with always trying to remove these? Is there an error me=
ssage in the log or somethi [=E2=80=A6]
Why delete something that we haven't added? We have this logic (do not dele=
te if not added) for DNS6 already. Besides, in some cases it might take up =
to 3 seconds.

2023-12-14 07:45:35 Closing DCO interface
2023-12-14 07:45:35 delete_route_ipv6(fd00:abcd:194:1::/64)
2023-12-14 07:45:35 IPv6 route deletion via service succeeded
2023-12-14 07:45:35 INET6 address service: remove fd00:abcd:194:1::1005/128
2023-12-14 07:45:38 WINS servers deleted using service



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Gerrit-Change-Number: 482
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Mon, 18 Dec 2023 07:53:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--VV7r3E+raHY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/482/comment/d7d9f828_cf70f1a1">Patch Set #1, Line 19:</a> <code style=
=3D"font-family:monospace,monospace">However, due to bug we always attempte=
d to remove DNS/WINS,</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">What&#39;s the issue with alway=
s trying to remove these? Is there an error message in the log or somethi [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Why delete something that we haven&#39;t added? We have this log=
ic (do not delete if not added) for DNS6 already. Besides, in some cases it=
 might take up to 3 seconds. </p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">2023-12-14 07:45:35 Closing DCO interface<br>2023-12-14 07=
:45:35 delete_route_ipv6(fd00:abcd:194:1::/64)<br>2023-12-14 07:45:35 IPv6 =
route deletion via service succeeded<br>2023-12-14 07:45:35 INET6 address s=
ervice: remove fd00:abcd:194:1::1005/128<br>2023-12-14 07:45:38 WINS server=
s deleted using service</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">change 482</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/482?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e=
4df555c93542a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 482 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Dec 2023 07:53:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--VV7r3E+raHY=--

