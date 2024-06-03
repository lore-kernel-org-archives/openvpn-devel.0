From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 3 Jun 2024 03:04:01 +0000
In-Reply-To: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227..., ssbssa@...360...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2bd78e8fe192563a135fa0fedcf0ef62a2509ade-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oK+EI5JDJqI="; charset=UTF-8
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
To: ssbssa <ssbssa@...360...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oK+EI5JDJqI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ssbssa.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/621?usp=3Demail )

Change subject: Implement Windows CA template match for Crypto-API selector
......................................................................


Patch Set 1:

(6 comments)

Patchset:

PS1:
I can't comment on the usefulness of this, but the changes look easy to mai=
ntain and clean, so a conditional feature-ACK from me.

At least one function call involves network search in the AD, a test report=
 of what happens when no DC's are reachable would help. If that could cause=
 a slow timeout, or error, we should document it. In typical setups DCs are=
 often unreachable before the tunnel is up.


File doc/man-sections/windows-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/621/comment/98846a64_c997a4b3 :
PS1, Line 62:      cryptoapicert "TMPL:1.3.6.1.4..."
Add an example where the template name is used instead of OID?


File src/openvpn/cryptoapi.c:

http://gerrit.openvpn.net/c/openvpn/+/621/comment/41d62b25_9fc645be :
PS1, Line 217:     }
I think I said this in response to the original in 2021 as well: why separa=
te into two calls like this? The use of the flag is to avoid network calls,=
 but if we are anyway going to allow network access, its more efficient to =
allow it in the first place. I'm assuming the call will return quickly if a=
 local search succeeds even if the flag is not there.


http://gerrit.openvpn.net/c/openvpn/+/621/comment/aa376a5e_4ae3dc25 :
PS1, Line 220:     if (!info && fallback && groupid)
I see the only place this is called is with fallback=3Dtrue, so we do not n=
eed that argument and can always fallback if groupid !=3D 0.


http://gerrit.openvpn.net/c/openvpn/+/621/comment/9ee83cff_cbebf4f4 :
PS1, Line 277:      * TMPL:<template name>
template name or OID ?


http://gerrit.openvpn.net/c/openvpn/+/621/comment/fcc24a46_78a084ec :
PS1, Line 314:         find_type =3D CERT_FIND_ANY;
Shouldn't we use a more restrictive search with, say, CERT_FIND_HAS_PRIVATE=
_KEY? If there are multiple users on the client machine with certificates f=
or each installed in the machine store, matching the template name alone co=
uld pick a certificate for which the user has no access to the private key =
and error out later.

This could also significantly reduce the number of certificates to walk thr=
ough.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Gerrit-Change-Number: 621
Gerrit-PatchSet: 1
Gerrit-Owner: ssbssa <ssbssa@...360...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ssbssa <ssbssa@...360...>
Gerrit-Comment-Date: Mon, 03 Jun 2024 03:04:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--oK+EI5JDJqI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ssbssa. =
</p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
621?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I can&#39;t comment on the usefulness of this, bu=
t the changes look easy to maintain and clean, so a conditional feature-ACK=
 from me.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">At =
least one function call involves network search in the AD, a test report of=
 what happens when no DC&#39;s are reachable would help. If that could caus=
e a slow timeout, or error, we should document it. In typical setups DCs ar=
e often unreachable before the tunnel is up.</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File doc/man-sections/windows-options.rst:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/621/comment/98846a64_c997a4b3">Patch Set #1, Line 62:<=
/a> <code style=3D"font-family:monospace,monospace">     cryptoapicert &quo=
t;TMPL:1.3.6.1.4...&quot;</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Add an example where the template name is used instead =
of OID?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/cryptoapi.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/621/comment/41d62b25_9fc645be=
">Patch Set #1, Line 217:</a> <code style=3D"font-family:monospace,monospac=
e">    }</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">I think I said this in response to the original in 2021 as well: why sep=
arate into two calls like this? The use of the flag is to avoid network cal=
ls, but if we are anyway going to allow network access, its more efficient =
to allow it in the first place. I&#39;m assuming the call will return quick=
ly if a local search succeeds even if the flag is not there.</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/621/comment/aa376a5e_4ae3dc2=
5">Patch Set #1, Line 220:</a> <code style=3D"font-family:monospace,monospa=
ce">    if (!info &amp;&amp; fallback &amp;&amp; groupid)</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I see the only place th=
is is called is with fallback=3Dtrue, so we do not need that argument and c=
an always fallback if groupid !=3D 0.</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/621/comment/9ee83cff_cbebf4f4">Patch Set #1, Line 2=
77:</a> <code style=3D"font-family:monospace,monospace">     * TMPL:&lt;tem=
plate name&gt;</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">template name or OID ?</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/621/comment/fcc24a46_78a084ec">Patch Set #1, Line 314:</a=
> <code style=3D"font-family:monospace,monospace">        find_type =3D CER=
T_FIND_ANY;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Shouldn&#39;t we use a more restrictive search with, say, CERT_FIND_H=
AS_PRIVATE_KEY? If there are multiple users on the client machine with cert=
ificates for each installed in the machine store, matching the template nam=
e alone could pick a certificate for which the user has no access to the pr=
ivate key and error out later.</p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">This could also significantly reduce the number of certif=
icates to walk through.</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">change 621</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/621?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b48=
9dbe811de5351 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 621 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ssbssa &lt;ssbssa@...360...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 03 Jun 2024 03:04:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--oK+EI5JDJqI=--

