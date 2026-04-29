From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 29 Apr 2026 13:01:50 +0000
In-Reply-To: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
References: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5d463b78a8181f4e1dc19a8e8a26ede37d1c3f58-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eMkbc8FfM+M="; charset=UTF-8
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
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eMkbc8FfM+M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1643?usp=3Demail )

Change subject: dns: correctly handle dnssec settings
......................................................................


Patch Set 1:

(3 comments)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/d51f138a_6bc6d024?usp=3D=
email :
PS1, Line 114:     nrpt_dnssec_required =3D 1 << 1,
> Is this really needed? As far as I can remember Windows has no `optional`=
 setting, i.e. [=E2=80=A6]
man-page  says user can set  optional, and I had no idea how to provide tha=
t rather than this. What this does is for the resolver to set DO flag but n=
ot require validation. Treating anything other than "no" as "yes" is not co=
rrect when we allo user to set yes/no/optional.


File src/openvpn/dns.h:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/5873967f_9eb03412?usp=3D=
email :
PS1, Line 32:     DNS_SECURITY_UNSET,
> Not sure if we should get rid of `unset` since might not have a `optional=
` setting. [=E2=80=A6]
As "dns server n dnssec foo" is not a mandatory option, UNSET is useless an=
d error-prone. Just decide on a defualt value and let the variable have tha=
t by default. UNSET is not handled anywhere.


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/95f23091_fe96ccc6?usp=3D=
email :
PS1, Line 2472:             nrpt_flags_t dnssec)
> Think it makes sense to rename `dnssec` -> `flags` or `nrpt_flags`, since=
 it could have additional t [=E2=80=A6]
Acknowledged



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 29 Apr 2026 13:01:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>

--eMkbc8FfM+M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1643/comment/d51f138a_6bc6d024?usp=3Demail">Patch Set #1=
, Line 114:</a> <code style=3D"font-family:monospace,monospace">    nrpt_dn=
ssec_required =3D 1 &lt;&lt; 1,</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is this really needed=
? As far as I can remember Windows has no `optional` setting, i.e. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">man-page  says user can set  optional, and I had no i=
dea how to provide that rather than this. What this does is for the resolve=
r to set DO flag but not require validation. Treating anything other than &=
quot;no&quot; as &quot;yes&quot; is not correct when we allo user to set ye=
s/no/optional.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/dns.h:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643/comment/5873967f_9eb034=
12?usp=3Demail">Patch Set #1, Line 32:</a> <code style=3D"font-family:monos=
pace,monospace">    DNS_SECURITY_UNSET,</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure if w=
e should get rid of `unset` since might not have a `optional` setting. [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">As &quot;dns server n dnssec foo&quot; is not a ma=
ndatory option, UNSET is useless and error-prone. Just decide on a defualt =
value and let the variable have that by default. UNSET is not handled anywh=
ere.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpnserv/interactive.c:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643/comment/95f23091_fe96=
ccc6?usp=3Demail">Patch Set #1, Line 2472:</a> <code style=3D"font-family:m=
onospace,monospace">            nrpt_flags_t dnssec)</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Think it makes sense to rename `dnssec` -&gt; `flags` or `nrpt_flags`, sinc=
e it could have additional t [=E2=80=A6]</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1643?usp=3Demail">change 1643</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1643?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Apr 2026 13:01:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>

</body></html>=

--eMkbc8FfM+M=--

