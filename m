From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 11 Oct 2024 16:45:43 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net, a@...2181...
Message-ID: <669bcfb9681c9059b9fb0c400776be0e40da4abf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RSBwAuJ51tg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: allow tcp/udp server
 to listen on multiple ports at the same time
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

--RSBwAuJ51tg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/434?usp=3Demail )

Change subject: allow tcp/udp server to listen on multiple ports at the sam=
e time
......................................................................


Patch Set 5: Code-Review-2

(19 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/d86891df_56a16db7 :
PS5, Line 7: allow tcp/udp server to listen on multiple ports at the same t=
ime
For a change this fundamental this commit message is not enough.
At least it should answer whether this actually changes any default behavio=
r? Is there a way to use this functionality with only this patch?


Patchset:

PS5:
Could definitely use
- a cleanup of old code styles
- some more commit message
- some more doxygen documentation
- a discussion about alternatives to 25 parameters to a function


File src/openvpn/forward.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/43fc1b4c_0009fdae :
PS5, Line 239: void process_incoming_tun(struct context *c, struct link_soc=
ket *out_ls);
I think we have implicitly agreed to call those out_sock?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/e3e073d2_b0854f7c :
PS5, Line 311:                        struct link_socket *ls);
let's stick with sock to be consistent?


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/3c2f7cf8_7db546e8 :
PS5, Line 67:     for (i =3D 0; i < c->c1.link_sockets_num; i++)
move declaration here.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/83bc5910_ce7ee80d :
PS5, Line 1500:                           out_ls);
this looks weird, why the additional line break?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/d8921253_6d30716c :
PS5, Line 2091:     int i;
no


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/8bed9745_e6009f9c :
PS5, Line 2712:         int i;
no


http://gerrit.openvpn.net/c/openvpn/+/434/comment/1745f5ec_89e42cd1 :
PS5, Line 2726:         int i;
no


http://gerrit.openvpn.net/c/openvpn/+/434/comment/8933303c_7cb6783c :
PS5, Line 3809:     int i;
no


http://gerrit.openvpn.net/c/openvpn/+/434/comment/6a0a8d89_cbd88193 :
PS5, Line 3830:     int i;
no


http://gerrit.openvpn.net/c/openvpn/+/434/comment/18ba15df_e611be9f :
PS5, Line 3898:     int i;
no


http://gerrit.openvpn.net/c/openvpn/+/434/comment/586e53d7_2687f6bd :
PS5, Line 4059:         int i;
no


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/03032190_4dfe1132 :
PS5, Line 265:     int status, i;
no


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/420473bb_c732efd1 :
PS5, Line 384:         int i;
no


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/d01c4e19_c10b5176 :
PS5, Line 133:     bool did_open_context;
doxygen for new members please


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/ffde4105_327f32dd :
PS5, Line 348: link_socket_init_phase1(struct link_socket *sock,
hmm, no?

There must be some better way than an function that has 25 parameters, sure=
ly?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/adb96022_106a698b :
PS5, Line 1288: bool sockets_read_residual(const struct context *c);
please add minimal documentation


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/a2a2981b_f791c838 :
PS5, Line 2239:     #if defined (_WIN32)
??



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 11 Oct 2024 16:45:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--RSBwAuJ51tg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">Vi=
ew Change</a></p><p>19 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/434/comment/d86891df_56a16db7">Patch Set #5, Line 7:</a> <code=
 style=3D"font-family:monospace,monospace">allow tcp/udp server to listen o=
n multiple ports at the same time</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">For a change this fundamental this commit messa=
ge is not enough.<br>At least it should answer whether this actually change=
s any default behavior? Is there a way to use this functionality with only =
this patch?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patch=
set:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/434?tab=3Dcomments">Patch Set #5:</a> </p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Could definitely us=
e</p><ul><li>a cleanup of old code styles</li><li>some more commit message<=
/li><li>some more doxygen documentation</li><li>a discussion about alternat=
ives to 25 parameters to a function</li></ul></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/forward.h:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/434/comment/43fc1b4c_0009fdae">Patch Set #5, Line 239:</a> <code style=
=3D"font-family:monospace,monospace">void process_incoming_tun(struct conte=
xt *c, struct link_socket *out_ls);</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I think we have implicitly agreed to call tho=
se out_sock?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/e3e073d2_b0854f7c">Patch Set #5, Line 311:</a> <code style=3D"fo=
nt-family:monospace,monospace">                       struct link_socket *l=
s);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">le=
t&#39;s stick with sock to be consistent?</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/434/comment/3c2f7cf8_7db546e8">Patch Set #5, Line 67:</a> <code style=3D=
"font-family:monospace,monospace">    for (i =3D 0; i &lt; c-&gt;c1.link_so=
ckets_num; i++)</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">move declaration here.</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/434/comment/83bc5910_ce7ee80d">Patch Set #5, Line 1500:<=
/a> <code style=3D"font-family:monospace,monospace">                       =
   out_ls);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">this looks weird, why the additional line break?</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/d8921253_6d30716c">Pa=
tch Set #5, Line 2091:</a> <code style=3D"font-family:monospace,monospace">=
    int i;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">no</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/init.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/8bed9745_e6009f9c">Pa=
tch Set #5, Line 2712:</a> <code style=3D"font-family:monospace,monospace">=
        int i;</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">no</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/1745f5ec_89e42cd1">Patch Set #5, Line 2726:</a> <code style=3D"f=
ont-family:monospace,monospace">        int i;</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">no</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/434/comment/8933303c_7cb6783c">Patch Set #5, =
Line 3809:</a> <code style=3D"font-family:monospace,monospace">    int i;</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">no</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/6a0a8d=
89_cbd88193">Patch Set #5, Line 3830:</a> <code style=3D"font-family:monosp=
ace,monospace">    int i;</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">no</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/434/comment/18ba15df_e611be9f">Patch Set #5, Line 3898:</a> <code =
style=3D"font-family:monospace,monospace">    int i;</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">no</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/434/comment/586e53d7_2687f6bd">Patch Se=
t #5, Line 4059:</a> <code style=3D"font-family:monospace,monospace">      =
  int i;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">no</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/mtcp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/434/comment/03032190_4dfe1132">Patch=
 Set #5, Line 265:</a> <code style=3D"font-family:monospace,monospace">    =
int status, i;</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">no</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/420473bb_c732efd1"=
>Patch Set #5, Line 384:</a> <code style=3D"font-family:monospace,monospace=
">        int i;</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">no</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/d01c4e19_c10b51=
76">Patch Set #5, Line 133:</a> <code style=3D"font-family:monospace,monosp=
ace">    bool did_open_context;</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">doxygen for new members please</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/434/comment/ffde4105_327f32dd">Patch Set #5, Line 348:</a>=
 <code style=3D"font-family:monospace,monospace">link_socket_init_phase1(st=
ruct link_socket *sock,</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">hmm, no?</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">There must be some better way than an function that has 25 pa=
rameters, surely?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/434/comment/adb96022_106a698b">Patch Set #5, Line 1288:</a> <code style=
=3D"font-family:monospace,monospace">bool sockets_read_residual(const struc=
t context *c);</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">please add minimal documentation</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/434/comment/a2a2981b_f791c838">Patch Set #5, Line 2239:</a> <code style=
=3D"font-family:monospace,monospace">    #if defined (_WIN32)</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">??</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34?usp=3Demail">change 434</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Oct 2024 16:45:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RSBwAuJ51tg=--

