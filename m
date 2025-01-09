From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 13:50:19 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2d183f4e1711b101f869147b7032078a412fcd74-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uYQtlYRakC8="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: multiproto: move
 generic event handling code in dedicated files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uYQtlYRakC8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/763?usp=3Demail )

Change subject: multiproto: move generic event handling code in dedicated f=
iles
......................................................................


Patch Set 11:

(14 comments)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/3cd77970_c262e6d2 :
PS10, Line 4926:                       struct link_socket *sock)
> I agree that we might want to make this uniform across the whole code - t=
hat is, change all occurenc [=E2=80=A6]
Done


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/8fab14f7_8836c8e6 :
PS10, Line 165: multi_tcp_context(struct multi_context *m, struct multi_ins=
tance *mi)
> we lost the `inline` bit here by making it a global function.  Maybe move=
 it to mtcp. [=E2=80=A6]
made this static inline again and moved to multi_io.h where it gets used, a=
lso renamed this 'multi_get_context' since it's what it does.


File src/openvpn/mudp.h:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/1ee1261f_36899e3a :
PS10, Line 66:                                                      struct =
link_socket *sock);
> see other comment, please move pure `ls/sock` renaming to a different pat=
ch
Done


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/8f0f41f9_ca89d73c :
PS10, Line 189:                               struct link_socket *sock)
> and here... without the renaming, there wouldn't be a change to `mudp. [=
=E2=80=A6]
Done


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/18a4cbd0_54aa4b1c :
PS10, Line 178:     struct multi_protocol *multi_io;     /**< State specifi=
c to OpenVPN using TCP
> If it's still `specific to TCP` (as the comment says), why rename it to `=
multi_protocol`?  This is c [=E2=80=A6]
It gets used also by UDP, the comment was a leftover.


http://gerrit.openvpn.net/c/openvpn/+/763/comment/048d18f2_978d730d :
PS10, Line 280:                                              struct link_so=
cket *sock);
> this
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/bd02fcba_e322ec4d :
PS10, Line 295:                          struct link_socket *sock);
> and that
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/9169a686_317e9b71 :
PS10, Line 363:                                  struct link_socket *sock);
> and yet another one
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/d56445cb_e795fd77 :
PS10, Line 754:                       struct link_socket *sock)
> another rename
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/a0585c59_7f074ee2 :
PS10, Line 777:     inherit_context_child(&mi->context, &m->top, sock);
> and this
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/aa433935_03f4722e :
PS10, Line 3129:                     struct link_socket *sock)
> here
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/d202b209_59ae6a8b :
PS10, Line 3185:     mi->context.c2.link_sockets[0] =3D sock;
> and there
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/78a7791f_6b0bda67 :
PS10, Line 3335:                             const unsigned int mpp_flags, =
struct link_socket *sock)
> and here...
Done


http://gerrit.openvpn.net/c/openvpn/+/763/comment/4849bfa6_a38eaef1 :
PS10, Line 3356:         multi_set_pending(m, multi_get_create_instance_udp=
(m, &floated, sock));
> this gets a bit boring
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Gerrit-Change-Number: 763
Gerrit-PatchSet: 11
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 09 Jan 2025 13:50:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--uYQtlYRakC8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">View C=
hange</a></p><p>14 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/763/comment/3cd77970_c262e6d2">Patch Set #10, Line 4926:</a=
> <code style=3D"font-family:monospace,monospace">                      str=
uct link_socket *sock)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">I agree that we might want to =
make this uniform across the whole code - that is, change all occurenc [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/mtcp.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/8fab14f7_8836c8e6=
">Patch Set #10, Line 165:</a> <code style=3D"font-family:monospace,monospa=
ce">multi_tcp_context(struct multi_context *m, struct multi_instance *mi)</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">we lost the `inline` bit here by making it a global fu=
nction.  Maybe move it to mtcp. [=E2=80=A6]</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">made this static inline again a=
nd moved to multi_io.h where it gets used, also renamed this &#39;multi_get=
_context&#39; since it&#39;s what it does.</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/mudp.h:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/763/comment/1ee1261f_36899e3a">Patch Set #10, Line 66:</a> <code style=3D"=
font-family:monospace,monospace">                                          =
           struct link_socket *sock);</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">see other comme=
nt, please move pure `ls/sock` renaming to a different patch</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/763/comment/8f0f41f9_ca89d73c">Patch Set #10, Line =
189:</a> <code style=3D"font-family:monospace,monospace">                  =
            struct link_socket *sock)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">and here... wit=
hout the renaming, there wouldn&#39;t be a change to `mudp. [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/763/comment/18a4cbd0_54aa4b1c">Patch Se=
t #10, Line 178:</a> <code style=3D"font-family:monospace,monospace">    st=
ruct multi_protocol *multi_io;     /**&lt; State specific to OpenVPN using =
TCP</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">If it&#39;s still `specific to TCP` (as the comme=
nt says), why rename it to `multi_protocol`?  This is c [=E2=80=A6]</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">It gets=
 used also by UDP, the comment was a leftover.</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/763/comment/048d18f2_978d730d">Patch Set #=
10, Line 280:</a> <code style=3D"font-family:monospace,monospace">         =
                                    struct link_socket *sock);</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">this</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/763/comment/bd02fcba_e322ec4d">Patch Set #10, Line 295:</a> <code sty=
le=3D"font-family:monospace,monospace">                         struct link=
_socket *sock);</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">and that</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/763/comment/9169a686_317e9b71">Patch =
Set #10, Line 363:</a> <code style=3D"font-family:monospace,monospace">    =
                             struct link_socket *sock);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">and yet another one</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/d=
56445cb_e795fd77">Patch Set #10, Line 754:</a> <code style=3D"font-family:m=
onospace,monospace">                      struct link_socket *sock)</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">another rename</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/763/comment/a0585c59_7f074ee2">Patch Set #10, Line 777=
:</a> <code style=3D"font-family:monospace,monospace">    inherit_context_c=
hild(&amp;mi-&gt;context, &amp;m-&gt;top, sock);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">and =
this</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/=
comment/aa433935_03f4722e">Patch Set #10, Line 3129:</a> <code style=3D"fon=
t-family:monospace,monospace">                    struct link_socket *sock)=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">here</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/763/comment/d202b209_59ae6a8b">Patch Set #10, Line 3185:=
</a> <code style=3D"font-family:monospace,monospace">    mi-&gt;context.c2.=
link_sockets[0] =3D sock;</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">and there</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/78a7791f_6b0bd=
a67">Patch Set #10, Line 3335:</a> <code style=3D"font-family:monospace,mon=
ospace">                            const unsigned int mpp_flags, struct li=
nk_socket *sock)</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">and here...</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/4849bfa6_a38eaef1">=
Patch Set #10, Line 3356:</a> <code style=3D"font-family:monospace,monospac=
e">        multi_set_pending(m, multi_get_create_instance_udp(m, &amp;float=
ed, sock));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">this gets a bit boring</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/763?usp=3Demail">change 763</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e5a84969988e4f027a18658d4a=
b268c13fbf929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jan 2025 13:50:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--uYQtlYRakC8=--

