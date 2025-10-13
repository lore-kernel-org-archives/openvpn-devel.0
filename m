From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 14:23:56 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <a067452c57cb40166e20052d2748c760959e2c5c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hnrZTsYB9Ts="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 for ifconfig-push routes when DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hnrZTsYB9Ts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1192?usp=3Demail )

Change subject: Install host routes for ifconfig-push routes when DCO is en=
abled
......................................................................


Patch Set 8:

(5 comments)

Patchset:

PS8:
> this got broken during review / respin... [=E2=80=A6]
Yeah not really sure what happend there during my rebase. I am going throug=
h the patch again to see that it really works.


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/1d9fd552_43ebda64?usp=3D=
email :
PS8, Line 686:
> This got broken in patch iterations - initially everything was `MR_ONLINK=
_ADDR` and then the define  [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/394a8910_234e7857?usp=3D=
email :
PS8, Line 700:         if (addr->type & MR_ONLINK_ADDR)
> _DCO_
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/d3123254_400e84c7?usp=3D=
email :
PS8, Line 745:         }
> this looks wrong. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/fba68590_cdaa0d71?usp=3D=
email :
PS8, Line 771:         }
> This is asymmetric to IPv4 - I guess this is from early tests, and the `d=
co_win_del... [=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Mon, 13 Oct 2025 14:23:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--hnrZTsYB9Ts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1192?tab=3Dcomments&amp;usp=3Demail">Patch Set #8:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">thi=
s got broken during review / respin... [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah no=
t really sure what happend there during my rebase. I am going through the p=
atch again to see that it really works.</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
192/comment/1d9fd552_43ebda64?usp=3Demail">Patch Set #8, Line 686:</a> <cod=
e style=3D"font-family:monospace,monospace"></code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This got=
 broken in patch iterations - initially everything was `MR_ONLINK_ADDR` and=
 then the define  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/394a8910_234e785=
7?usp=3Demail">Patch Set #8, Line 700:</a> <code style=3D"font-family:monos=
pace,monospace">        if (addr-&gt;type &amp; MR_ONLINK_ADDR)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">_DCO_</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1192/comment/d3123254_400e84c7?usp=3Demail">Patch =
Set #8, Line 745:</a> <code style=3D"font-family:monospace,monospace">     =
   }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">this looks wrong. [=E2=80=A6]</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comme=
nt/fba68590_cdaa0d71?usp=3Demail">Patch Set #8, Line 771:</a> <code style=
=3D"font-family:monospace,monospace">        }</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This i=
s asymmetric to IPv4 - I guess this is from early tests, and the `dco_win_d=
el... [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3De=
mail">change 1192</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Oct 2025 14:23:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--hnrZTsYB9Ts=--

