From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 21:03:19 +0000
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <119af713a1dfea0cf9befcb6badd6fa0371c9938-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ppZo1Druqlg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow
 route_ipv6_match_host to be used outside of route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ppZo1Druqlg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1191?usp=3Demail )

Change subject: Allow route_ipv6_match_host to be used outside of route.c
......................................................................


Patch Set 3: Code-Review+1

(4 comments)

Patchset:

PS3:
patch looks good to me, but I have a few nitpicks in line with Heiko's opin=
ion.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/1191/comment/c97633f9_e67e2e01 :
PS1, Line 719: route_ipv6_match_host(const struct in6_addr *network, unsign=
ed int bits, const struct in6_addr *host)
> The name is somewhat outdated with the new signature of the function. [=
=E2=80=A6]
I agree - that also makes it obvious that there is no route involved anymore


http://gerrit.openvpn.net/c/openvpn/+/1191/comment/128cf6ac_eb198fb9 :
PS1, Line 726:     int i =3D 0;
> No i is used outside the loop in line 740/742
Heiko said there is no need to "initialize" i. So just drop "=3D 0" as it's=
 initialized by the for loop.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/1191/comment/336ca137_8e3a6ff8 :
PS3, Line 716:     /* (not the most beautiful implementation in the world, =
but portable and
maybe drop opening and closing parenthesis?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Gerrit-Change-Number: 1191
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 16 Sep 2025 21:03:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--ppZo1Druqlg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1191?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">patch looks good to me, but I have a few ni=
tpicks in line with Heiko&#39;s opinion.</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1191/comment/c97633f9_e67e2e01">Patch Set #1, Line 719:</a> <code style=3D"=
font-family:monospace,monospace">route_ipv6_match_host(const struct in6_add=
r *network, unsigned int bits, const struct in6_addr *host)</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">The name is somewhat outdated with the new signature of the function=
. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I agree - that also makes it obvious that there is no route i=
nvolved anymore</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1191/comment/128cf6ac_eb198fb9">Patch Set #1, Line 726:</a> <code style=
=3D"font-family:monospace,monospace">    int i =3D 0;</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>No i is used outside the loop in line 740/742</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Heiko said there is no need =
to &quot;initialize&quot; i. So just drop &quot;=3D 0&quot; as it&#39;s ini=
tialized by the for loop.</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191/comment/33=
6ca137_8e3a6ff8">Patch Set #3, Line 716:</a> <code style=3D"font-family:mon=
ospace,monospace">    /* (not the most beautiful implementation in the worl=
d, but portable and</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">maybe drop opening and closing parenthesis?</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/11=
91?usp=3Demail">change 1191</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Sep 2025 21:03:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ppZo1Druqlg=--

