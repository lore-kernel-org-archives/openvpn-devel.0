From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 29 Apr 2026 16:27:25 +0000
In-Reply-To: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
References: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <4b115852876a621330560ad7ec38ae66f27127ea-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rj+svbo99AU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: correctly
 handle dnssec settings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rj+svbo99AU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos, selvanair.

flichtenheld has posted comments on this change by selvanair. ( http://gerr=
it.openvpn.net/c/openvpn/+/1643?usp=3Demail )

Change subject: dns: correctly handle dnssec settings
......................................................................


Patch Set 1:

(2 comments)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/a0719312_f7f3e02b?usp=3D=
email :
PS1, Line 114:     nrpt_dnssec_required =3D 1 << 1,
> Shall we treat "optional" as "no" on Windows and document that?
NRPT seems to have two separate settings `DnsSecEnabled` and `DnsSecValidat=
ionRequired`. If optional maps well to `DnsSecEnabled=3DTrue`/`DnsSecValida=
tionRequired=3DFalse` we could use it. I assume that is what your patch is =
currently doing? OTOH given that the broken version is already out there ma=
ybe we should go for the minimal patch first? I.e. keep the existing boolea=
n and just enable it for DNS_SECURITY_YES and nothing else. And then we can=
 discuss a followup patch that would support "optional".


http://gerrit.openvpn.net/c/openvpn/+/1643/comment/e5891691_5e2d0dde?usp=3D=
email :
PS1, Line 127:     nrpt_flags_t flags;
> We cant move those defines to openvpn-msg.h as we need them on non-window=
s as well. [=E2=80=A6]
I don't see how you can get all of that.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id514b06223cb55295c92b1fa6727f03d6e06befe
Gerrit-Change-Number: 1643
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Wed, 29 Apr 2026 16:27:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--rj+svbo99AU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1643/comment/a0719312_f7f3e02b?usp=3Demail">Patch Set #1=
, Line 114:</a> <code style=3D"font-family:monospace,monospace">    nrpt_dn=
ssec_required =3D 1 &lt;&lt; 1,</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Shall we treat &quot;=
optional&quot; as &quot;no&quot; on Windows and document that?</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">NRPT seems to have two separate settings `DnsSecEnabled` and `DnsSecVa=
lidationRequired`. If optional maps well to `DnsSecEnabled=3DTrue`/`DnsSecV=
alidationRequired=3DFalse` we could use it. I assume that is what your patc=
h is currently doing? OTOH given that the broken version is already out the=
re maybe we should go for the minimal patch first? I.e. keep the existing b=
oolean and just enable it for DNS_SECURITY_YES and nothing else. And then w=
e can discuss a followup patch that would support &quot;optional&quot;.</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643/comment/e589=
1691_5e2d0dde?usp=3Demail">Patch Set #1, Line 127:</a> <code style=3D"font-=
family:monospace,monospace">    nrpt_flags_t flags;</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">W=
e cant move those defines to openvpn-msg.h as we need them on non-windows a=
s well. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I don&#39;t see how you can get all of=
 that.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1643?usp=3Demail">change 1643</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1643?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id514b06223cb55295c92b1fa672=
7f03d6e06befe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1643 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Apr 2026 16:27:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--rj+svbo99AU=--

