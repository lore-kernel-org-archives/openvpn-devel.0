From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:49:41 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <709208564909f23446223a9c860eacdbd22e270f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J8Jha8Phch0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Adapt socket
 handling to support listening on multiple sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J8Jha8Phch0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/434?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................


Patch Set 6:

(18 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/1d41d2b6_a8f7ac05 :
PS5, Line 7: allow tcp/udp server to listen on multiple ports at the same t=
ime
> For a change this fundamental this commit message is not enough. [=E2=80=
=A6]
Done


File src/openvpn/forward.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/777e4574_22f8383d :
PS5, Line 239: void process_incoming_tun(struct context *c, struct link_soc=
ket *out_ls);
> I think we have implicitly agreed to call those out_sock?
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/45aee7e6_1b3916da :
PS5, Line 311:                        struct link_socket *ls);
> let's stick with sock to be consistent?
Done


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/25eddf8f_88da1d83 :
PS5, Line 67:     for (i =3D 0; i < c->c1.link_sockets_num; i++)
> move declaration here.
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/52741d0c_ed1cfbf5 :
PS5, Line 1500:                           out_ls);
> this looks weird, why the additional line break?
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/c9729dd8_c23a63b3 :
PS5, Line 2091:     int i;
> no
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/5db88ca1_62001647 :
PS5, Line 2712:         int i;
> no
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/c4b1d0a7_caefad40 :
PS5, Line 2726:         int i;
> no
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/d8bf560b_269e4c53 :
PS5, Line 3809:     int i;
> no
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/3fbce72a_bc8f27b6 :
PS5, Line 3830:     int i;
> no
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/96692862_fb70f0c5 :
PS5, Line 3898:     int i;
> no
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b06654d3_bd9889ea :
PS5, Line 4059:         int i;
> no
Done


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/324654a5_bfaf62d1 :
PS5, Line 265:     int status, i;
> no
Done


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/9eba0158_a12ada55 :
PS5, Line 384:         int i;
> no
Done


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/b0f20aa4_59ddfbd1 :
PS5, Line 133:     bool did_open_context;
> This must have been a rebase mistake, because: [=E2=80=A6]
It was a rebase mistake indeed, so I removed this.


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/a49234a5_d2525f23 :
PS5, Line 348: link_socket_init_phase1(struct link_socket *sock,
> hmm, no? [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/4d71982d_76aa122f :
PS5, Line 1288: bool sockets_read_residual(const struct context *c);
> please add minimal documentation
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/b48f0b7e_bcabdfe7 :
PS5, Line 2239:     #if defined (_WIN32)
> ??
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Thu, 17 Oct 2024 14:49:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--J8Jha8Phch0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">View C=
hange</a></p><p>18 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/434/comment/1d41d2b6_a8f7ac05">Patch Set #5, Line 7:</a> <code style=
=3D"font-family:monospace,monospace">allow tcp/udp server to listen on mult=
iple ports at the same time</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">For a change this fundame=
ntal this commit message is not enough. [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/434/comment/777e4574_22f8383d">Patch Set #5, Line 239:</a=
> <code style=3D"font-family:monospace,monospace">void process_incoming_tun=
(struct context *c, struct link_socket *out_ls);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I th=
ink we have implicitly agreed to call those out_sock?</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/45aee7e6_1b3916da"=
>Patch Set #5, Line 311:</a> <code style=3D"font-family:monospace,monospace=
">                       struct link_socket *ls);</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">let=
&#39;s stick with sock to be consistent?</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/434/comment/25eddf8f_88da1d83">Patch Set #5, Line 67:</a> <code st=
yle=3D"font-family:monospace,monospace">    for (i =3D 0; i &lt; c-&gt;c1.l=
ink_sockets_num; i++)</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">move declaration here.</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/52741=
d0c_ed1cfbf5">Patch Set #5, Line 1500:</a> <code style=3D"font-family:monos=
pace,monospace">                          out_ls);</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">th=
is looks weird, why the additional line break?</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/434/comment/c9729dd8_c23a63b3">Patch =
Set #5, Line 2091:</a> <code style=3D"font-family:monospace,monospace">    =
int i;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">no</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/c=
omment/5db88ca1_62001647">Patch Set #5, Line 2712:</a> <code style=3D"font-=
family:monospace,monospace">        int i;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">no</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/c4=
b1d0a7_caefad40">Patch Set #5, Line 2726:</a> <code style=3D"font-family:mo=
nospace,monospace">        int i;</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">no</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/d8bf560b_269e=
4c53">Patch Set #5, Line 3809:</a> <code style=3D"font-family:monospace,mon=
ospace">    int i;</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">no</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/434/comment/3fbce72a_bc8f27b6">Patch Set=
 #5, Line 3830:</a> <code style=3D"font-family:monospace,monospace">    int=
 i;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">no</blockquote></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/434/comment/96692862_fb70f0c5">Patch Set #5, Line 3898:=
</a> <code style=3D"font-family:monospace,monospace">    int i;</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">no</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/434/comment/b06654d3_bd9889ea">Patch Set #5, Line 4059:</a> <code styl=
e=3D"font-family:monospace,monospace">        int i;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
no</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/mtcp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/324654a5_bfaf62d1">Pa=
tch Set #5, Line 265:</a> <code style=3D"font-family:monospace,monospace"> =
   int status, i;</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">no</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/434/comment/9eba0158_a12ada55">Patch Set #5, Line 384:</a> <code styl=
e=3D"font-family:monospace,monospace">        int i;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
no</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/b0f20aa4_59ddfbd1">=
Patch Set #5, Line 133:</a> <code style=3D"font-family:monospace,monospace"=
>    bool did_open_context;</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">This must have been a reb=
ase mistake, because: [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">It was a rebase mistake indeed, so I remo=
ved this.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/socket.h:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/a49234a5_d2525f23"=
>Patch Set #5, Line 348:</a> <code style=3D"font-family:monospace,monospace=
">link_socket_init_phase1(struct link_socket *sock,</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">h=
mm, no? [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/434/comment/4d71982d_76aa122f">Patch Set #5, Line 1288:</a> <cod=
e style=3D"font-family:monospace,monospace">bool sockets_read_residual(cons=
t struct context *c);</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">please add minimal documentatio=
n</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/b48f0b7e_bcabdfe7">=
Patch Set #5, Line 2239:</a> <code style=3D"font-family:monospace,monospace=
">    #if defined (_WIN32)</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">??</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434=
?usp=3Demail">change 434</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Oct 2024 14:49:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--J8Jha8Phch0=--

