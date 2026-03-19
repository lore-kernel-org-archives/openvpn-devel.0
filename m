From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 19 Mar 2026 12:30:40 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <f6729a92d03dd41f057b943a3b80448fd2e434b0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gc2Qn1Tn42E="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gc2Qn1Tn42E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 6: Code-Review-1

(6 comments)

Patchset:

PS6:
Mostly done with obvious problems. Doing some testing now and noted some th=
ings about the actual behavior. Note that these are not necessarily objecti=
ve problems but more my opinion of how I would expect it to work. So let me=
 know what you think =F0=9F=98=8A


File src/openvpn/networking.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a54ba7ff_66357771?usp=3D=
email :
PS6, Line 42: /* Only the iproute2 backend implements these functions,
This comment is outdated


File src/openvpn/networking_sitnl.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/8c83021c_80e04de6?usp=3D=
email :
PS6, Line 113:  * (/var/run/netns).
`/run/netns`


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/bd778cd2_164b398c?usp=3D=
email :
PS6, Line 207:             return -1;
Note that this return value is meaningless since no code ever checks it. I =
would suggest that a non-existent namespace should be a fatal error?


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/2eb2828a_8a3cf902?usp=3D=
email :
PS6, Line 2185:             int ret =3D net_iface_move_netns(ifr.ifr_name, =
ctx->netns);
One interesting problem I encountered is that the usual way of auto-naming =
tun devices doesn't really work with --netns. Since the device is created i=
n a different namespace it can't know whether there is already a device wit=
h the same name in the target namespace.

Not sure whether we can work around this? If not, maybe we should document =
this? Might be a niche use-case (outside of testing).


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/3b67e7d2_771ff340?usp=3D=
email :
PS6, Line 2188:                 msg(M_WARN | M_ERRNO, "Note: Cannot move de=
v %s to network namespace %s", ifr.ifr_name, ctx->netns);
I would go for M_ERR here. I would consider this a fatal error.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Thu, 19 Mar 2026 12:30:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--gc2Qn1Tn42E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Mostly don=
e with obvious problems. Doing some testing now and noted some things about=
 the actual behavior. Note that these are not necessarily objective problem=
s but more my opinion of how I would expect it to work. So let me know what=
 you think =F0=9F=98=8A</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/networking.h:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment=
/a54ba7ff_66357771?usp=3Demail">Patch Set #6, Line 42:</a> <code style=3D"f=
ont-family:monospace,monospace">/* Only the iproute2 backend implements the=
se functions,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">This comment is outdated</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1521/comment/8c83021c_80e04de6?usp=3Demail">Patch Set #=
6, Line 113:</a> <code style=3D"font-family:monospace,monospace"> * (/var/r=
un/netns).</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">`/run/netns`</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/networking_sitnl.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521/comment/bd778cd2_164b398c?usp=3Demail">Patch Set #6, Line 207:</a=
> <code style=3D"font-family:monospace,monospace">            return -1;</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Note that this return value is meaningless since no code ever chec=
ks it. I would suggest that a non-existent namespace should be a fatal erro=
r?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/tun.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1521/comment/2eb2828a_8a3cf902?usp=3Dema=
il">Patch Set #6, Line 2185:</a> <code style=3D"font-family:monospace,monos=
pace">            int ret =3D net_iface_move_netns(ifr.ifr_name, ctx-&gt;ne=
tns);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">One interesting problem I encountered is that the usual wa=
y of auto-naming tun devices doesn&#39;t really work with --netns. Since th=
e device is created in a different namespace it can&#39;t know whether ther=
e is already a device with the same name in the target namespace.</p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Not s=
ure whether we can work around this? If not, maybe we should document this?=
 Might be a niche use-case (outside of testing).</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1521/comment/3b67e7d2_771ff340?usp=3Dema=
il">Patch Set #6, Line 2188:</a> <code style=3D"font-family:monospace,monos=
pace">                msg(M_WARN | M_ERRNO, &quot;Note: Cannot move dev %s =
to network namespace %s&quot;, ifr.ifr_name, ctx-&gt;netns);</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I w=
ould go for M_ERR here. I would consider this a fatal error.</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1521?usp=3Demail">change 1521</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
21?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Mar 2026 12:30:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--gc2Qn1Tn42E=--

