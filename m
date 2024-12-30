From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 19:16:31 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <39153d9f8483bad6836055955f89ac1b4576cadf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pnqtXqcNfa8="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pnqtXqcNfa8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/763?usp=3Demail )

Change subject: multiproto: move generic event handling code in dedicated f=
iles
......................................................................


Patch Set 10: Code-Review-2

(15 comments)

Patchset:

PS10:
I can't review this when half the patch is really `renaming of *ls to *sock=
`.  Please split these off to a separate patch that does the renaming, and =
a patch that does actual code/file structure changes.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/9d7d20e0_b9d8d37a :
PS10, Line 4926:                       struct link_socket *sock)
I agree that we might want to make this uniform across the whole code - tha=
t is, change all occurences to `struct link_socket *XXX` to either `*ls` or=
 `*sock`.

But this should not be part of a "L" patchset, which is hard enough to revi=
ew as it is - so please make this into its own patch.


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/36397026_667042d4 :
PS10, Line 165: multi_tcp_context(struct multi_context *m, struct multi_ins=
tance *mi)
we lost the `inline` bit here by making it a global function.  Maybe move i=
t to mtcp.h then, and make it a `static inline` again?


File src/openvpn/mudp.h:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/9b5c56a3_dce8eb89 :
PS10, Line 66:                                                      struct =
link_socket *sock);
see other comment, please move pure `ls/sock` renaming to a different patch


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/436366d0_85a29dd3 :
PS10, Line 189:                               struct link_socket *sock)
and here... without the renaming, there wouldn't be a change to `mudp.c` at=
 all (much easier to understand)


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/708a3ae7_1bc1f45f :
PS10, Line 178:     struct multi_protocol *multi_io;     /**< State specifi=
c to OpenVPN using TCP
If it's still `specific to TCP` (as the comment says), why rename it to `mu=
lti_protocol`?  This is confusing.


http://gerrit.openvpn.net/c/openvpn/+/763/comment/d2d8645d_1d44dadd :
PS10, Line 280:                                              struct link_so=
cket *sock);
this


http://gerrit.openvpn.net/c/openvpn/+/763/comment/f86883ac_ccce439c :
PS10, Line 295:                          struct link_socket *sock);
and that


http://gerrit.openvpn.net/c/openvpn/+/763/comment/f67a320c_f48331b4 :
PS10, Line 363:                                  struct link_socket *sock);
and yet another one


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/76a11a87_3b464974 :
PS10, Line 754:                       struct link_socket *sock)
another rename


http://gerrit.openvpn.net/c/openvpn/+/763/comment/0d46a452_d8aea7ce :
PS10, Line 777:     inherit_context_child(&mi->context, &m->top, sock);
and this


http://gerrit.openvpn.net/c/openvpn/+/763/comment/a496614d_446989b1 :
PS10, Line 3129:                     struct link_socket *sock)
here


http://gerrit.openvpn.net/c/openvpn/+/763/comment/cfe09b5a_44dfaba8 :
PS10, Line 3185:     mi->context.c2.link_sockets[0] =3D sock;
and there


http://gerrit.openvpn.net/c/openvpn/+/763/comment/6cee5d39_c8c303fa :
PS10, Line 3335:                             const unsigned int mpp_flags, =
struct link_socket *sock)
and here...


http://gerrit.openvpn.net/c/openvpn/+/763/comment/7fd9250d_8fe8e422 :
PS10, Line 3356:         multi_set_pending(m, multi_get_create_instance_udp=
(m, &floated, sock));
this gets a bit boring



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Gerrit-Change-Number: 763
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 30 Dec 2024 19:16:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--pnqtXqcNfa8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">V=
iew Change</a></p><p>15 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/763?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I can&#39;t review this when half the patc=
h is really `renaming of *ls to *sock`.  Please split these off to a separa=
te patch that does the renaming, and a patch that does actual code/file str=
ucture changes.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/init.c:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/9d7d20e0_b9d8d=
37a">Patch Set #10, Line 4926:</a> <code style=3D"font-family:monospace,mon=
ospace">                      struct link_socket *sock)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I agree that we might wa=
nt to make this uniform across the whole code - that is, change all occuren=
ces to `struct link_socket *XXX` to either `*ls` or `*sock`.</p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">But this should not be part=
 of a &quot;L&quot; patchset, which is hard enough to review as it is - so =
please make this into its own patch.</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/mtcp.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/c=
omment/36397026_667042d4">Patch Set #10, Line 165:</a> <code style=3D"font-=
family:monospace,monospace">multi_tcp_context(struct multi_context *m, stru=
ct multi_instance *mi)</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">we lost the `inline` bit here by making it a global functi=
on.  Maybe move it to mtcp.h then, and make it a `static inline` again?</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mud=
p.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/763/comment/9b5c56a3_dce8eb89">Patch Set #10,=
 Line 66:</a> <code style=3D"font-family:monospace,monospace">             =
                                        struct link_socket *sock);</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">see other comm=
ent, please move pure `ls/sock` renaming to a different patch</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/763/comment/436366d0_85a29dd3">Patch Set #10, Line 189:=
</a> <code style=3D"font-family:monospace,monospace">                      =
        struct link_socket *sock)</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">and here... without the renaming, there wouldn&=
#39;t be a change to `mudp.c` at all (much easier to understand)</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.h:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/763/comment/708a3ae7_1bc1f45f">Patch Set #10, Line =
178:</a> <code style=3D"font-family:monospace,monospace">    struct multi_p=
rotocol *multi_io;     /**&lt; State specific to OpenVPN using TCP</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">If it&#39;s st=
ill `specific to TCP` (as the comment says), why rename it to `multi_protoc=
ol`?  This is confusing.</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/763/comment/d2d8645d_1d44dadd">Patch Set #10, Line 280:</a> <cod=
e style=3D"font-family:monospace,monospace">                               =
              struct link_socket *sock);</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">this</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/763/comment/f86883ac_ccce439c">Patch Set #10, Lin=
e 295:</a> <code style=3D"font-family:monospace,monospace">                =
         struct link_socket *sock);</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">and that</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/763/comment/f67a320c_f48331b4">Patch Set #10, Line=
 363:</a> <code style=3D"font-family:monospace,monospace">                 =
                struct link_socket *sock);</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">and yet another one</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/763/comment/76a11a87_3b464974">Patch Set #10, Line 754:</a>=
 <code style=3D"font-family:monospace,monospace">                      stru=
ct link_socket *sock)</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">another rename</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/763/comment/0d46a452_d8aea7ce">Patch Set #10, Line 777:</a=
> <code style=3D"font-family:monospace,monospace">    inherit_context_child=
(&amp;mi-&gt;context, &amp;m-&gt;top, sock);</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">and this</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/763/comment/a496614d_446989b1">Patch Set =
#10, Line 3129:</a> <code style=3D"font-family:monospace,monospace">       =
             struct link_socket *sock)</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">here</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/763/comment/cfe09b5a_44dfaba8">Patch Set #10, Line =
3185:</a> <code style=3D"font-family:monospace,monospace">    mi-&gt;contex=
t.c2.link_sockets[0] =3D sock;</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">and there</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/763/comment/6cee5d39_c8c303fa">Patch Set #10, Line 333=
5:</a> <code style=3D"font-family:monospace,monospace">                    =
        const unsigned int mpp_flags, struct link_socket *sock)</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">and here...</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763/comment/7fd9250=
d_8fe8e422">Patch Set #10, Line 3356:</a> <code style=3D"font-family:monosp=
ace,monospace">        multi_set_pending(m, multi_get_create_instance_udp(m=
, &amp;floated, sock));</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">this gets a bit boring</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">ch=
ange 763</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e5a84969988e4f027a18658d4a=
b268c13fbf929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Dec 2024 19:16:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--pnqtXqcNfa8=--

