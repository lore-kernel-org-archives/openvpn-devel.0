From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 6 Jun 2024 04:50:57 +0000
In-Reply-To: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227..., ssbssa@...360...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a1d4c78f9cc24697c0fb93e56521ef358388faf1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hpdN4+FSjpM="; charset=UTF-8
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

--hpdN4+FSjpM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ssbssa.

selvanair has posted comments on this change by ssbssa. ( http://gerrit.ope=
nvpn.net/c/openvpn/+/621?usp=3Demail )

Change subject: Implement Windows CA template match for Crypto-API selector
......................................................................


Patch Set 2: Code-Review+2

(2 comments)

Patchset:

PS2:
Thanks for the changes. Looks good to me now.
I have no setup to test this but I did confirm that "TMPL:" is recognized a=
s a valid selector, and the code does iterate through certificates with pri=
vate keys present.

Acked-by: Selva Nair <selva.nair@...277...>


File src/openvpn/cryptoapi.c:

http://gerrit.openvpn.net/c/openvpn/+/621/comment/66b4877b_503018f8?usp=3De=
mail :
PS1, Line 220:     if (!info && fallback && groupid)
> Done
nitpick: the comment is now a bit inaccurate -- "and fallback requested" is=
 no longer required. May be edited at merge time.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Gerrit-Change-Number: 621
Gerrit-PatchSet: 2
Gerrit-Owner: ssbssa <ssbssa@...360...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ssbssa <ssbssa@...360...>
Gerrit-Comment-Date: Thu, 06 Jun 2024 04:50:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ssbssa <ssbssa@...360...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--hpdN4+FSjpM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ssbssa. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/621?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thanks for t=
he changes. Looks good to me now. <br>I have no setup to test this but I di=
d confirm that &quot;TMPL:&quot; is recognized as a valid selector, and the=
 code does iterate through certificates with private keys present.</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acke=
d-by: Selva Nair &lt;selva.nair@...277...&gt;</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/cryptoapi.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/621/comment/66b4877b_503018f8?usp=3Demail">Patch Set #1, Line =
220:</a> <code style=3D"font-family:monospace,monospace">    if (!info &amp=
;&amp; fallback &amp;&amp; groupid)</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Done</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">nitpick: the comment is now a bit inaccurate -- &quot;and fallback req=
uested&quot; is no longer required. May be edited at merge time.</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/621?usp=3Demail">change 621</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
621?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
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
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ssbssa &lt;ssbssa@...360...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Jun 2024 04:50:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: ssbssa &lt;ssbssa@...2803...=
..&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--hpdN4+FSjpM=--

