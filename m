From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:50:31 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <10761432f72fe25425cb7c9583929d3332ca30c9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zzOSbbzbSdE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zzOSbbzbSdE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 6:

(6 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/e41c0651_4dde7880 :
PS5, Line 114:   0.0.0.0 or :: can be used to specifically open a socket.
> Sentence does end in the middle?
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/5a0ba867_50a05ad8 :
PS5, Line 117: or name
> Should probably say "default TCP/UDP port number" or something like that =
and mention that this can b [=E2=80=A6]
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/bea38f19_4d89f447 :
PS5, Line 2400:      * Sanity check on daemon mode
> Not sure what daemon is supposed to mean in this context?
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/a4fc0da7_d28cb303 :
PS5, Line 3198:     if (ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_serve=
r && !ce->local_list && !ce->local_port_defined && !ce->bind_defined)
> Should use need_bind to simplify the condition.
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/08d0b545_36ce02f5 :
PS5, Line 3327: options_postprocess_mutate_le(struct options *o, struct loc=
al_entry *le)
> should maybe take o->ce as input and not o, just to make clear that it do=
esn't need the rest?
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/f094b608_24a1894e :
PS5, Line 358: options
> either this should use "l" or the definition of "l" should be removed com=
pletely.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Thu, 17 Oct 2024 14:50:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--zzOSbbzbSdE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options.=
rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/436/comment/e41c0651_4dde7880">Patch Set #5, =
Line 114:</a> <code style=3D"font-family:monospace,monospace">  0.0.0.0 or =
:: can be used to specifically open a socket.</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sentenc=
e does end in the middle?</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/436/comment/5a0ba867_50a05ad8">Patch Set #5, Line 117:</a>=
 <code style=3D"font-family:monospace,monospace">or name</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Should probably say &quot;default TCP/UDP port number&quot; or somethin=
g like that and mention that this can b [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/436/comment/bea38f19_4d89f447">Patch Set #5, Line 2400:</=
a> <code style=3D"font-family:monospace,monospace">     * Sanity check on d=
aemon mode</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Not sure what daemon is supposed to mean i=
n this context?</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/436/comment/a4fc0da7_d28cb303">Patch Set #5, Line 3198:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (ce-&gt;proto =3D=3D PROTO_U=
DP &amp;&amp; ce-&gt;socks_proxy_server &amp;&amp; !ce-&gt;local_list &amp;=
&amp; !ce-&gt;local_port_defined &amp;&amp; !ce-&gt;bind_defined)</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Should use need_bind to simplify the condition.</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/comment/08d0b545_36=
ce02f5">Patch Set #5, Line 3327:</a> <code style=3D"font-family:monospace,m=
onospace">options_postprocess_mutate_le(struct options *o, struct local_ent=
ry *le)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">should maybe take o-&gt;ce as input and not o=
, just to make clear that it doesn&#39;t need the rest?</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/436/comment/f094b608_24a1894e">Patch Set #5, Line 358:=
</a> <code style=3D"font-family:monospace,monospace">options</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">either this should use &quot;l&quot; or the definition of &quot;l&q=
uot; should be removed completely.</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">cha=
nge 436</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Oct 2024 14:50:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--zzOSbbzbSdE=--

