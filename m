From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 16 Feb 2024 16:01:38 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <77fd9c96c5b0d6ce30c0ad5b2766ae2d1a8459b4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wNnuhGHywwg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Http-proxy: Fix bug
 preventing proxy credentials caching.
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

--wNnuhGHywwg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/523?usp=3Demail )

Change subject: Http-proxy: Fix bug preventing proxy credentials caching.
......................................................................


Patch Set 1: Code-Review-2

(5 comments)

Patchset:

PS1:
Definitely has issues


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/a2ced5bd_47c89245 :
PS1, Line 1861:     SHOW_BOOL(ce.http_proxy_options->nocache);
This belongs into show_connection_entry like the other o->ce options


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/99f3b845_b241aa5b :
PS1, Line 275:     if (!static_proxy_user_pass.defined || (is_first_time &&=
 !p->options.nocache) )
This condition feels wrong to me. As I understand the code this should neve=
r be true when p->options.nocache is true. Or do I understand the code wron=
g?


http://gerrit.openvpn.net/c/openvpn/+/523/comment/67ae3287_17906ea3 :
PS1, Line 278:                       p->options.auth_file,
I think you messed up a rebase on top of a634cc5eccd55f1d14197da7376bb819bd=
f72cb6 here. Your code ignores auth_file_up again.


http://gerrit.openvpn.net/c/openvpn/+/523/comment/3303fbc3_b1eee104 :
PS1, Line 546:         get_user_pass_http(p);
So previously this forced a reset of the credentials. This you removed. Are=
 you sure this is correct? If yes, why?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Gerrit-Change-Number: 523
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Fri, 16 Feb 2024 16:01:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--wNnuhGHywwg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/523?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Definitely has issues</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/523/comment/a2ced5bd_47c89245">Patch Set #1, Line 1861:</a> <c=
ode style=3D"font-family:monospace,monospace">    SHOW_BOOL(ce.http_proxy_o=
ptions-&gt;nocache);</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This belongs into show_connection_entry like the other o-&gt=
;ce options</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/proxy.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/523/comment/99f3b845_b241aa5b=
">Patch Set #1, Line 275:</a> <code style=3D"font-family:monospace,monospac=
e">    if (!static_proxy_user_pass.defined || (is_first_time &amp;&amp; !p-=
&gt;options.nocache) )</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">This condition feels wrong to me. As I understand the code=
 this should never be true when p-&gt;options.nocache is true. Or do I unde=
rstand the code wrong?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/523/comment/67ae3287_17906ea3">Patch Set #1, Line 278:</a> <code s=
tyle=3D"font-family:monospace,monospace">                      p-&gt;option=
s.auth_file,</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">I think you messed up a rebase on top of a634cc5eccd55f1d14197da7376=
bb819bdf72cb6 here. Your code ignores auth_file_up again.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/523/comment/3303fbc3_b1eee104">=
Patch Set #1, Line 546:</a> <code style=3D"font-family:monospace,monospace"=
>        get_user_pass_http(p);</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">So previously this forced a reset of the credenti=
als. This you removed. Are you sure this is correct? If yes, why?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/523?usp=3Demail">change 523</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 16 Feb 2024 16:01:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wNnuhGHywwg=--

