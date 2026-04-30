From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 12:07:48 +0000
In-Reply-To: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
References: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <e7bc4adf423928a507932ac1c8370fe18a5b4694-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7yL/jE5nq8k="; charset=UTF-8
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

--7yL/jE5nq8k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos, selvanair.

flichtenheld has posted comments on this change by selvanair. ( http://gerr=
it.openvpn.net/c/openvpn/+/1643?usp=3Demail )

Change subject: dns: correctly handle dnssec settings
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/dns.h:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/cfa08e49_08aa2a52?usp=3D=
email :
PS1, Line 32:     DNS_SECURITY_UNSET,
> As "dns server n dnssec foo" is not a mandatory option, UNSET is useless =
and error-prone. [=E2=80=A6]
"UNSET is not handled anywhere." I looked into that and this is not true. W=
e never use `DNS_SECURITY_UNSET` explicitly in the code. But a lot of the D=
NS options code does things like `if (s->dnssec)` so we have actually a lot=
 of implicit checks for it. E.g. when running the dns script we put nothing=
 in the environment when it is UNSET, and only put "yes", "no", "optional" =
if explicitly set.



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
Gerrit-Comment-Date: Thu, 30 Apr 2026 12:07:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--7yL/jE5nq8k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns.h:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1643/comment/cfa08e49_08aa2a52?usp=3Demail">Patch Set #1, Lin=
e 32:</a> <code style=3D"font-family:monospace,monospace">    DNS_SECURITY_=
UNSET,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">As &quot;dns server n dnssec foo&quot; is not =
a mandatory option, UNSET is useless and error-prone. [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">&quot;UNSET is not handled anywhere.&quot; I looked into that and t=
his is not true. We never use `DNS_SECURITY_UNSET` explicitly in the code. =
But a lot of the DNS options code does things like `if (s-&gt;dnssec)` so w=
e have actually a lot of implicit checks for it. E.g. when running the dns =
script we put nothing in the environment when it is UNSET, and only put &qu=
ot;yes&quot;, &quot;no&quot;, &quot;optional&quot; if explicitly set.</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1643?usp=3Demail">change 1643</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1643?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Apr 2026 12:07:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--7yL/jE5nq8k=--

