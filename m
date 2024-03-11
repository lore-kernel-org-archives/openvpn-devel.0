From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 11 Mar 2024 14:45:37 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <c603438e3793f0cd38b3bbfeff13c07f910c5941-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZFUL+KWvJzo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Http-proxy: fix bug
 preventing proxy credentials caching
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

--ZFUL+KWvJzo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/523?usp=3Demail )

Change subject: Http-proxy: fix bug preventing proxy credentials caching
......................................................................


Patch Set 5:

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/0095e7d0_7032f979 :
PS5, Line 21: http_proxy_options and also a getter method to retrieve
The man page for --auth-nocache still says it has no effect on --http-proxy=
. This needs to be updated.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/10c5ad5e_1e39dee3 :
PS5, Line 3126:             if (ce->http_proxy_options)
This needs to be moved one level up. E.g. when using "--proto tcp4-client" =
currently --auth-nocache is ignored, since proto is already PROTO_TCP_CLIEN=
T.
There should be no issue with always setting this independently of ce->prot=
o.


File src/openvpn/proxy.h:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/2c3993c2_e1173cce :
PS5, Line 61:     bool nocache;
Please update "show_http_proxy_options" in options.c to show value of nocac=
he.


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/663d790d_11843add :
PS5, Line 669:         if (p->up.nocache)
wouldn't it be better to move this clearing into get_user_pass_http?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Gerrit-Change-Number: 523
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Mon, 11 Mar 2024 14:45:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--ZFUL+KWvJzo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/523/comment/0095e7d0_7032f979">Patch Set #5, Line 21:</a> <code style=
=3D"font-family:monospace,monospace">http_proxy_options and also a getter m=
ethod to retrieve</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">The man page for --auth-nocache still says it has no effect on =
--http-proxy. This needs to be updated.</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/523/comment/10c5ad5e_1e39dee3">Patch Set #5, Line 3126:</a> <code style=3D=
"font-family:monospace,monospace">            if (ce-&gt;http_proxy_options=
)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This=
 needs to be moved one level up. E.g. when using &quot;--proto tcp4-client&=
quot; currently --auth-nocache is ignored, since proto is already PROTO_TCP=
_CLIENT.<br>There should be no issue with always setting this independently=
 of ce-&gt;proto.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/proxy.h:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523/comment/2c3993c2_e1=
173cce">Patch Set #5, Line 61:</a> <code style=3D"font-family:monospace,mon=
ospace">    bool nocache;</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Please update &quot;show_http_proxy_options&quot; in op=
tions.c to show value of nocache.</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/proxy.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523/com=
ment/663d790d_11843add">Patch Set #5, Line 669:</a> <code style=3D"font-fam=
ily:monospace,monospace">        if (p-&gt;up.nocache)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">wouldn&#39;t it be bette=
r to move this clearing into get_user_pass_http?</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3De=
mail">change 523</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Mar 2024 14:45:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZFUL+KWvJzo=--

