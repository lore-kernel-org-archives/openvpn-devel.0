From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Nov 2024 15:54:14 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <01f6c965a58d5c9882c4564202b0d5446eb89605-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="so8iIiWbwco="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--so8iIiWbwco=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/434?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................


Patch Set 7: Code-Review-2

(17 comments)

Patchset:

PS7:
Okay, this is a big one.

There is minor things - whitespace changes that should not be done, or wrap=
ping changes that are not called for.  There are some parts that I just do =
not understand which would benefit from comments in the code *or* comments =
here in gerrit ("will be resolved by the next patch in the series").

There's ugliness (link_socket_init_phase1(), the patch looks excessive for =
what it intends to do).

There are at least 3 places that look like rebase accidents, and need to be=
 very carefully checked for "is this change intentional".


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/af521d3c_72b59ce8 :
PS7, Line 1133:             /* all sockets are of the same type, so just ch=
eck the first one */
this confuses me.  We will have UDP and TCP sockets later on, so they are n=
ot expected to be "all of the same type".  Will this be addressed later in =
the patch series?


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/e3b56022_c021a1c0 :
PS7, Line 533:             {
this is a behavioural change, not checking `advance_next_remote` anymore.  =
Is this intentional or a rebase artefact?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/d9600958_55933535 :
PS7, Line 1959:         ASSERT(c->c2.link_sockets);
this is not doing the same thing as before... so we do not know if `link_so=
ckets[0]` is actually well defined here.  No?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/f4f59153_2fd3ff1d :
PS7, Line 2015:             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_=
name, c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
line length exceeded, and the old version wasn't that bad (the unwrapping a=
bove was reasonable, with just a few characters hanging in the next line, b=
ut this one should stay as it is).

Also, quite unrelated to the patch itself... just sayin.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/2d3860a3_9d493c40 :
PS7, Line 3819: do_init_socket_1(struct context *c)
I think we should stick to `phase1` as function name, otherwise it reads as=
 if this is "init socket 1", and "init socket 2" for "socket #1 and #2".  N=
o?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/f10b10f2_22a5be55 :
PS7, Line 4011:     if (c->c2.link_sockets && c->c2.link_socket_owned)
what happened to the `is_dco_win()` part here?  This looks like a rebase ac=
cident


http://gerrit.openvpn.net/c/openvpn/+/434/comment/72fd22c0_b99b4657 :
PS7, Line 4040:         CLEAR(c->c1.link_socket_addrs[0].actual);
this looks inconsistent - freeaddrinfo() is called in the loop, while the C=
LEAR() is only called for [0].  Intentional?  If yes, a comment should say =
so.

(I could see this as being intentional "because this is client side only, a=
nd client only has 1 socket, ever", but it looks weird)


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b96d510f_3ce9a525 :
PS7, Line 4719:         do_init_socket_1(c);
mmmh, see comment above, maybe name this `do_init_link_sockets_phase1()`?

`do_init_socket_1()` could be anything...


http://gerrit.openvpn.net/c/openvpn/+/434/comment/e0ffc177_bec7efd2 :
PS7, Line 4762:         do_init_socket_2(c);
`_phase2()`


http://gerrit.openvpn.net/c/openvpn/+/434/comment/1785554f_4c253f1b :
PS7, Line 4968:                        &dest->gc);
is this wrapping necessary?  Comparing to the lines below it does not seem =
like it


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/ed1d30f4_2e4e41d3 :
PS7, Line 384:         for (int i =3D 0; i < m->top.c1.link_sockets_num; i+=
+)
this, again, is confusing me.  So is this a client instance ("1 socket exis=
ts") or the server instance ("all sockets exists, but sockets can be UDP an=
d TCP")?  Having the `_udp()` handler walk through the list of sockets whic=
h could be "more than 1, and such, UDP or TCP" does not look right, at leas=
t not without some explanation ("this will all move to a common `multi_proc=
ess_io_anything()` in the next patch") ;-)


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/efd059f1_5a25f7ad :
PS7, Line 1858:     c->c2.link_sockets[sock_index]->local_host =3D c->optio=
ns.ce.local;
Can this be changed to `*sock =3D &c->c2.link_sockets[sock_index]` and then=
 the rest of the function can be left unchanged?  this is how all the other=
 parts of the patch do it...  (not `[0]` in this case, of course).


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b3f1e813_3ace2227 :
PS7, Line 2222: #if defined (_WIN32)
unrelated whitespace change, please do not (also, this extra space is not h=
ow it's done elsewhere)


http://gerrit.openvpn.net/c/openvpn/+/434/comment/2e93e0ee_51a6abd7 :
PS7, Line 2259:         sig_info->signal_received =3D SIGUSR1;
I think this is a rebase artefact, the multisocket patch colliding with Sel=
va's signal handler reworking.  Please double-check, but this does not look=
 right.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/fa7b3095_61edff01 :
PS7, Line 2271:                           sig_info);
please do not wrap.  The line is not long and not changed by this patch.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/02a03a9a_2d541041 :
PS7, Line 2297:     if (sig_save)
again, please thoroughly double check.  I think this is old code, and the t=
hrow_signal() stuff is how it should be.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 7
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 27 Nov 2024 15:54:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--so8iIiWbwco=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">Vi=
ew Change</a></p><p>17 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/434?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Okay, this is a big one.</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">There is minor things - whitespa=
ce changes that should not be done, or wrapping changes that are not called=
 for.  There are some parts that I just do not understand which would benef=
it from comments in the code *or* comments here in gerrit (&quot;will be re=
solved by the next patch in the series&quot;).</p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">There&#39;s ugliness (link_socket_init_ph=
ase1(), the patch looks excessive for what it intends to do).</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">There are at least 3 pla=
ces that look like rebase accidents, and need to be very carefully checked =
for &quot;is this change intentional&quot;.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/434/comment/af521d3c_72b59ce8">Patch Set #7, Line 1133:</a> <code styl=
e=3D"font-family:monospace,monospace">            /* all sockets are of the=
 same type, so just check the first one */</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">this confuses me.  We will have UDP an=
d TCP sockets later on, so they are not expected to be &quot;all of the sam=
e type&quot;.  Will this be addressed later in the patch series?</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/434/comment/e3b56022_c021a1c0">Patch Set #7, Line 53=
3:</a> <code style=3D"font-family:monospace,monospace">            {</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this is a be=
havioural change, not checking `advance_next_remote` anymore.  Is this inte=
ntional or a rebase artefact?</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/434/comment/d9600958_55933535">Patch Set #7, Line 1959:</a>=
 <code style=3D"font-family:monospace,monospace">        ASSERT(c-&gt;c2.li=
nk_sockets);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">this is not doing the same thing as before... so we do not know if `=
link_sockets[0]` is actually well defined here.  No?</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/434/comment/f4f59153_2fd3ff1d">Patch=
 Set #7, Line 2015:</a> <code style=3D"font-family:monospace,monospace">   =
         do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name, c-&g=
t;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">line length exceeded, and t=
he old version wasn&#39;t that bad (the unwrapping above was reasonable, wi=
th just a few characters hanging in the next line, but this one should stay=
 as it is).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
lso, quite unrelated to the patch itself... just sayin.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/2d3860a3_9d493c40">=
Patch Set #7, Line 3819:</a> <code style=3D"font-family:monospace,monospace=
">do_init_socket_1(struct context *c)</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I think we should stick to `phase1` as func=
tion name, otherwise it reads as if this is &quot;init socket 1&quot;, and =
&quot;init socket 2&quot; for &quot;socket #1 and #2&quot;.  No?</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/f10b10f2_22a=
5be55">Patch Set #7, Line 4011:</a> <code style=3D"font-family:monospace,mo=
nospace">    if (c-&gt;c2.link_sockets &amp;&amp; c-&gt;c2.link_socket_owne=
d)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">wha=
t happened to the `is_dco_win()` part here?  This looks like a rebase accid=
ent</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/commen=
t/72fd22c0_b99b4657">Patch Set #7, Line 4040:</a> <code style=3D"font-famil=
y:monospace,monospace">        CLEAR(c-&gt;c1.link_socket_addrs[0].actual);=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this =
looks inconsistent - freeaddrinfo() is called in the loop, while the CLEAR(=
) is only called for [0].  Intentional?  If yes, a comment should say so.</=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(I could see t=
his as being intentional &quot;because this is client side only, and client=
 only has 1 socket, ever&quot;, but it looks weird)</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/434/comment/b96d510f_3ce9a525">Patch =
Set #7, Line 4719:</a> <code style=3D"font-family:monospace,monospace">    =
    do_init_socket_1(c);</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">mmmh, see comment above, maybe name this `do_init_link_s=
ockets_phase1()`?</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">`do_init_socket_1()` could be anything...</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/434/comment/e0ffc177_bec7efd2">Patch Set #=
7, Line 4762:</a> <code style=3D"font-family:monospace,monospace">        d=
o_init_socket_2(c);</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">`_phase2()`</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/434/comment/1785554f_4c253f1b">Patch Set #7, Line 4968:</a> <co=
de style=3D"font-family:monospace,monospace">                       &amp;de=
st-&gt;gc);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">is this wrapping necessary?  Comparing to the lines below it does not=
 seem like it</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/ed1d30f4_2e4e41d=
3">Patch Set #7, Line 384:</a> <code style=3D"font-family:monospace,monospa=
ce">        for (int i =3D 0; i &lt; m-&gt;top.c1.link_sockets_num; i++)</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this, ag=
ain, is confusing me.  So is this a client instance (&quot;1 socket exists&=
quot;) or the server instance (&quot;all sockets exists, but sockets can be=
 UDP and TCP&quot;)?  Having the `_udp()` handler walk through the list of =
sockets which could be &quot;more than 1, and such, UDP or TCP&quot; does n=
ot look right, at least not without some explanation (&quot;this will all m=
ove to a common `multi_process_io_anything()` in the next patch&quot;) ;-)<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/434/comment/efd059f1_5a25f7ad">Patch Set=
 #7, Line 1858:</a> <code style=3D"font-family:monospace,monospace">    c-&=
gt;c2.link_sockets[sock_index]-&gt;local_host =3D c-&gt;options.ce.local;</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Can thi=
s be changed to `*sock =3D &amp;c-&gt;c2.link_sockets[sock_index]` and then=
 the rest of the function can be left unchanged?  this is how all the other=
 parts of the patch do it...  (not `[0]` in this case, of course).</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/b3f1e813_3=
ace2227">Patch Set #7, Line 2222:</a> <code style=3D"font-family:monospace,=
monospace">#if defined (_WIN32)</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">unrelated whitespace change, please do not (also,=
 this extra space is not how it&#39;s done elsewhere)</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/2e93e0ee_51a6abd7">Pa=
tch Set #7, Line 2259:</a> <code style=3D"font-family:monospace,monospace">=
        sig_info-&gt;signal_received =3D SIGUSR1;</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I think this is a rebase artefa=
ct, the multisocket patch colliding with Selva&#39;s signal handler reworki=
ng.  Please double-check, but this does not look right.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/fa7b3095_61edff01">=
Patch Set #7, Line 2271:</a> <code style=3D"font-family:monospace,monospace=
">                          sig_info);</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">please do not wrap.  The line is not long =
and not changed by this patch.</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/434/comment/02a03a9a_2d541041">Patch Set #7, Line 2297:</a=
> <code style=3D"font-family:monospace,monospace">    if (sig_save)</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">again, please=
 thoroughly double check.  I think this is old code, and the throw_signal()=
 stuff is how it should be.</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">change 434</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/434?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Nov 2024 15:54:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--so8iIiWbwco=--

