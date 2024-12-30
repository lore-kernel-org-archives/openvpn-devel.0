From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 13:37:47 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <80116867582008ec2abe42a0eb71cda167f521e0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cTIdCZ7T1Kw="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cTIdCZ7T1Kw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/434?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................


Patch Set 10:

(17 comments)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/69eb0e47_7a2fefdf :
PS9, Line 4054:         {
> The `if()` should be outside and the `for()` inside - the condition does =
not depend on `i`.
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/dff8a59a_21679821 :
PS9, Line 4062:         {
> same thing.
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/c947a2ab_76ea9aa3 :
PS9, Line 4786:                                 get_link_socket_info(c));
> Should this be a per-socket thing?  IPv4 vs. [=E2=80=A6]
Made this a per-socket thing.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b147968f_4b23f49c :
PS9, Line 4991:                      &dest->gc);
> if line length permits, can this be unwrapped?
Done


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/45b85b7d_90856afd :
PS9, Line 271:                                      &c->c2.link_sockets[i]-=
>ev_arg);
> the diff looks as if there are tabs at the beginning of this line?
Done


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/e1854ff0_37af4d92 :
PS9, Line 388:                                         sock);
> please unwrap
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/a8787998_d8ad16d6 :
PS9, Line 3336: {
> I think this could be wrapped before `const unsigned int mpp_flags`
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/9a778853_9ea799d9 :
PS9, Line 1037:
> another blank line
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/55bd01b2_52c753e9 :
PS9, Line 1875:     sock->bind_dev =3D o->bind_dev;
> where did that go to?  another rebase accident?  *red flag*
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/6094ee4a_ac948ea1 :
PS9, Line 1019:     socket_descriptor_t sd;
> we shouldn't delete blank lines unrelated to actual changes (minor nit)
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/e87a08aa_1f6e0dab :
PS9, Line 1854:                         int mode)
> please unwrap
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/36576466_961a732f :
PS9, Line 1863:     sock->remote_port =3D o->ce.remote_port;
> not sure this change (remove the local variables `remote_host` and `remot=
e_port`) is a good thing as [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/9434c644_f418ccd8 :
PS9, Line 1919:         sock->proxy_dest_port =3D o->ce.remote_port;
> this
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/f14a026f_c6ca2521 :
PS9, Line 1924:
> spurious blank line
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/8c99342c_c4d10f9f :
PS9, Line 1931:         sock->proxy_dest_port =3D o->ce.remote_port;
> this
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/15fb1903_d0b82fdd :
PS9, Line 1936:         sock->remote_port =3D o->ce.remote_port;
> and this
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/066facc3_d851126b :
PS9, Line 2301:         /* Always restore the saved signal --register/throw=
_signal will handle priority */
> you lost a ` ` here after `--` (this is not a command line option `--regi=
ster`)
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 10
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Mon, 30 Dec 2024 13:37:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--cTIdCZ7T1Kw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">View C=
hange</a></p><p>17 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/434/comment/69eb0e47_7a2fefdf">Patch Set #9, Line 4054:</a>=
 <code style=3D"font-family:monospace,monospace">        {</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">The `if()` should be outside and the `for()` inside - the condition d=
oes not depend on `i`.</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/434/comment/dff8a59a_21679821">Patch Set #9, Line 4062:</a> <=
code style=3D"font-family:monospace,monospace">        {</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">same thing.</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/434/comment/c947a2ab_76ea9aa3">Patch Set #9, Line 4786:</a> <code st=
yle=3D"font-family:monospace,monospace">                                get=
_link_socket_info(c));</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Should this be a per-socket th=
ing?  IPv4 vs. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Made this a per-socket thing.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/b147968f_4b23f49c">=
Patch Set #9, Line 4991:</a> <code style=3D"font-family:monospace,monospace=
">                     &amp;dest-&gt;gc);</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">if line len=
gth permits, can this be unwrapped?</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/mtcp.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/45b85b7d_90856afd">Patch Set #9, Line 271:</a> <code style=3D"fo=
nt-family:monospace,monospace">                                     &amp;c-=
&gt;c2.link_sockets[i]-&gt;ev_arg);</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">the diff looks as=
 if there are tabs at the beginning of this line?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/434/comment/e1854ff0_37af4d92">Patch Set #9, Line 388:</a> <c=
ode style=3D"font-family:monospace,monospace">                             =
           sock);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">please unwrap</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/434/comment/a8787998_d8ad16d6">Patch Set #9, Line 3336:</=
a> <code style=3D"font-family:monospace,monospace">{</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I think this could be wrapped before `const unsigned int mpp_flags`</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/so=
cket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/434/comment/9a778853_9ea799d9">Patch Set #=
9, Line 1037:</a> <code style=3D"font-family:monospace,monospace"></code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">another blank line</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/434/comment/55bd01b2_52c753e9">Patch Set #9, Line 1=
875:</a> <code style=3D"font-family:monospace,monospace">    sock-&gt;bind_=
dev =3D o-&gt;bind_dev;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">where did that go to?  anothe=
r rebase accident?  *red flag*</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/434/comment/6094ee4a_ac948ea1">Patch Set #9, Line 101=
9:</a> <code style=3D"font-family:monospace,monospace">    socket_descripto=
r_t sd;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">we shouldn&#39;t delete blank lines unrelated=
 to actual changes (minor nit)</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/434/comment/e87a08aa_1f6e0dab">Patch Set #9, Line 185=
4:</a> <code style=3D"font-family:monospace,monospace">                    =
    int mode)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">please unwrap</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/36576466_961a732f">=
Patch Set #9, Line 1863:</a> <code style=3D"font-family:monospace,monospace=
">    sock-&gt;remote_port =3D o-&gt;ce.remote_port;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
not sure this change (remove the local variables `remote_host` and `remote_=
port`) is a good thing as [=E2=80=A6]</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/434/comment/9434c644_f418ccd8">Patch Set #9, L=
ine 1919:</a> <code style=3D"font-family:monospace,monospace">        sock-=
&gt;proxy_dest_port =3D o-&gt;ce.remote_port;</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment=
/f14a026f_c6ca2521">Patch Set #9, Line 1924:</a> <code style=3D"font-family=
:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">spurious blank line</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/8c99342=
c_c4d10f9f">Patch Set #9, Line 1931:</a> <code style=3D"font-family:monospa=
ce,monospace">        sock-&gt;proxy_dest_port =3D o-&gt;ce.remote_port;</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">this</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/434/comment/15fb1903_d0b82fdd">Patch Set #9, Line 1936:</a>=
 <code style=3D"font-family:monospace,monospace">        sock-&gt;remote_po=
rt =3D o-&gt;ce.remote_port;</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">and this</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/066facc3_d85=
1126b">Patch Set #9, Line 2301:</a> <code style=3D"font-family:monospace,mo=
nospace">        /* Always restore the saved signal --register/throw_signal=
 will handle priority */</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">you lost a ` ` here after `-=
-` (this is not a command line option `--register`)</blockquote></p><p styl=
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
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Dec 2024 13:37:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--cTIdCZ7T1Kw=--

