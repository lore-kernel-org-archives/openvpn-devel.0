From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 12 Mar 2024 08:36:36 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <88b1f09ddf5020ba5af6961fe55e189cf2a21016-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uati0un2iuQ="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uati0un2iuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/523?usp=3Demail )

Change subject: Http-proxy: fix bug preventing proxy credentials caching
......................................................................


Patch Set 5:

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/87905ca4_736be2e0 :
PS5, Line 21: http_proxy_options and also a getter method to retrieve
> The man page for --auth-nocache still says it has no effect on --http-pro=
xy. [=E2=80=A6]
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/3b08b487_e3fc606d :
PS5, Line 3126:             if (ce->http_proxy_options)
> This needs to be moved one level up. E.g. [=E2=80=A6]
Done


File src/openvpn/proxy.h:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/0c4157a3_109dd1dc :
PS5, Line 61:     bool nocache;
> Please update "show_http_proxy_options" in options.c to show value of noc=
ache.
Done


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/f7da0dee_13ae81ae :
PS5, Line 669:         if (p->up.nocache)
> wouldn't it be better to move this clearing into get_user_pass_http?
Done



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 12 Mar 2024 08:36:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--uati0un2iuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/523/comment/87905ca4_736be2e0">Patch Set #5, Line 21:</a> <code style=
=3D"font-family:monospace,monospace">http_proxy_options and also a getter m=
ethod to retrieve</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">The man page for --auth-nocache sti=
ll says it has no effect on --http-proxy. [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/523/comment/3b08b487_e3fc606d">Patch Set #5, Line 3126:=
</a> <code style=3D"font-family:monospace,monospace">            if (ce-&gt=
;http_proxy_options)</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This needs to be moved one level=
 up. E.g. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/proxy.h:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523/comment/0c=
4157a3_109dd1dc">Patch Set #5, Line 61:</a> <code style=3D"font-family:mono=
space,monospace">    bool nocache;</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please update &quo=
t;show_http_proxy_options&quot; in options.c to show value of nocache.</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/proxy.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/523/comment/f7da0dee_13ae81ae">Patch Set=
 #5, Line 669:</a> <code style=3D"font-family:monospace,monospace">        =
if (p-&gt;up.nocache)</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">wouldn&#39;t it be better to mo=
ve this clearing into get_user_pass_http?</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Dema=
il">change 523</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Mar 2024 08:36:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--uati0un2iuQ=--

