From: "ssbssa (Code Review)" <gerrit@...515...>
Date: Mon, 3 Jun 2024 14:35:28 +0000
In-Reply-To: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
Reply-To: ssbssa@...360..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1c43eb315e089099b7b5341b27633b1fb177ada4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SMApW+gvy6A="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement Windows CA
 template match for Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SMApW+gvy6A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, selvanair.

ssbssa has posted comments on this change. ( http://gerrit.openvpn.net/c/op=
envpn/+/621?usp=3Demail )

Change subject: Implement Windows CA template match for Crypto-API selector
......................................................................


Patch Set 2:

(6 comments)

Patchset:

PS2:
The new patch should resolve all comments.


File doc/man-sections/windows-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/621/comment/dea7be4c_cb1afe99 :
PS1, Line 62:      cryptoapicert "TMPL:1.3.6.1.4..."
> Add an example where the template name is used instead of OID?
Done


File src/openvpn/cryptoapi.c:

http://gerrit.openvpn.net/c/openvpn/+/621/comment/63f95189_515a1777 :
PS1, Line 217:     }
> I think I said this in response to the original in 2021 as well: why sepa=
rate into two calls like th [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/621/comment/404e038e_7d02372b :
PS1, Line 220:     if (!info && fallback && groupid)
> I see the only place this is called is with fallback=3Dtrue, so we do not=
 need that argument and can a [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/621/comment/f5b1a275_d56ff8fa :
PS1, Line 277:      * TMPL:<template name>
> template name or OID ?
Done


http://gerrit.openvpn.net/c/openvpn/+/621/comment/79d659be_2fe54731 :
PS1, Line 314:         find_type =3D CERT_FIND_ANY;
> Shouldn't we use a more restrictive search with, say, CERT_FIND_HAS_PRIVA=
TE_KEY? If there are multip [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Gerrit-Change-Number: 621
Gerrit-PatchSet: 2
Gerrit-Owner: ssbssa <ssbssa@...360...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 03 Jun 2024 14:35:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: selvanair <selva.nair@...277...>
Gerrit-MessageType: comment

--SMApW+gvy6A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, selvanai=
r. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
621?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">The new patch should resolve all comments.</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/w=
indows-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/621/comment/dea7be4c_cb1afe99"=
>Patch Set #1, Line 62:</a> <code style=3D"font-family:monospace,monospace"=
>     cryptoapicert &quot;TMPL:1.3.6.1.4...&quot;</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Add=
 an example where the template name is used instead of OID?</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/cryptoapi.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/621/comment/63f95189_515a1777">Patch Set #1, Li=
ne 217:</a> <code style=3D"font-family:monospace,monospace">    }</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">I think I said this in response to the original in 2021 as wel=
l: why separate into two calls like th [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/621/comment/404e038e_7d02372b">=
Patch Set #1, Line 220:</a> <code style=3D"font-family:monospace,monospace"=
>    if (!info &amp;&amp; fallback &amp;&amp; groupid)</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">I see the only place this is called is with fallback=3Dtrue, so we do not=
 need that argument and can a [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/621/comment/f5b1a275_d56ff8fa">Patch Set #=
1, Line 277:</a> <code style=3D"font-family:monospace,monospace">     * TMP=
L:&lt;template name&gt;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">template name or OID ?</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621/comment/79d=
659be_2fe54731">Patch Set #1, Line 314:</a> <code style=3D"font-family:mono=
space,monospace">        find_type =3D CERT_FIND_ANY;</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Shouldn&#39;t we use a more restrictive search with, say, CERT_FIND_HAS_PR=
IVATE_KEY? If there are multip [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Dem=
ail">change 621</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b48=
9dbe811de5351 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 621 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ssbssa &lt;ssbssa@...360...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 03 Jun 2024 14:35:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SMApW+gvy6A=--

