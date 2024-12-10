From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 13:10:35 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <e9e9041e727b2c7fd8234cf766320634af55cd79-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kVm3pvlzIKw="; charset=UTF-8
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

--kVm3pvlzIKw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/434?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................


Patch Set 7:

(16 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/5c3d2260_ff08a995 :
PS7, Line 1133:             /* all sockets are of the same type, so just ch=
eck the first one */
> this confuses me. [=E2=80=A6]
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/c8bba806_c5354795 :
PS7, Line 533:             {
> this is a behavioural change, not checking `advance_next_remote` anymore.=
 [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/0274c355_3b2e8c19 :
PS7, Line 1959:         ASSERT(c->c2.link_sockets);
> this is not doing the same thing as before... [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/9e623ad9_318662fe :
PS7, Line 2015:             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_=
name, c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
> line length exceeded, and the old version wasn't that bad (the unwrapping=
 above was reasonable, with [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/83e1f2b3_82aeffb6 :
PS7, Line 3819: do_init_socket_1(struct context *c)
> I think we should stick to `phase1` as function name, otherwise it reads =
as if this is "init socket  [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/983be341_eb72cb9c :
PS7, Line 4011:     if (c->c2.link_sockets && c->c2.link_socket_owned)
> what happened to the `is_dco_win()` part here?  This looks like a rebase =
accident
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/0dd0c10f_cbddc037 :
PS7, Line 4040:         CLEAR(c->c1.link_socket_addrs[0].actual);
> this looks inconsistent - freeaddrinfo() is called in the loop, while the=
 CLEAR() is only called for [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/8c4402d6_a5c9227d :
PS7, Line 4719:         do_init_socket_1(c);
> mmmh, see comment above, maybe name this `do_init_link_sockets_phase1()`?=
 [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/90c989e7_e8b47bfa :
PS7, Line 4762:         do_init_socket_2(c);
> `_phase2()`
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/da819cb1_03b64f6a :
PS7, Line 4968:                        &dest->gc);
> is this wrapping necessary?  Comparing to the lines below it does not see=
m like it
Acknowledged


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/d1d68fc6_23406680 :
PS7, Line 384:         for (int i =3D 0; i < m->top.c1.link_sockets_num; i+=
+)
> this comment opened a little pandora's box... [=E2=80=A6]
In the next patches we will have a common server loop for both TCP and UDP =
however the I/O processing will remain separate, for this specific case we =
decided to pass directly the link_socket to avoid to walk through all of th=
em, in the final patch we will handle directly the link_socket returned by =
the event_set.


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/6534f7ed_de52f295 :
PS7, Line 1858:     c->c2.link_sockets[sock_index]->local_host =3D c->optio=
ns.ce.local;
> Can this be changed to `*sock =3D &c->c2. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b247da87_2274fb46 :
PS7, Line 2222: #if defined (_WIN32)
> unrelated whitespace change, please do not (also, this extra space is not=
 how it's done elsewhere)
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/58256377_1c734eb8 :
PS7, Line 2259:         sig_info->signal_received =3D SIGUSR1;
> I think this is a rebase artefact, the multisocket patch colliding with S=
elva's signal handler rewor [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/72e83319_3a6cdcc6 :
PS7, Line 2271:                           sig_info);
> please do not wrap.  The line is not long and not changed by this patch.
Done


http://gerrit.openvpn.net/c/openvpn/+/434/comment/93ac21b3_d36b9855 :
PS7, Line 2297:     if (sig_save)
> again, please thoroughly double check. [=E2=80=A6]
Done



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Tue, 10 Dec 2024 13:10:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--kVm3pvlzIKw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">View C=
hange</a></p><p>16 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/434/comment/5c3d2260_ff08a995">Patch Set #7, Line 1133:<=
/a> <code style=3D"font-family:monospace,monospace">            /* all sock=
ets are of the same type, so just check the first one */</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">this confuses me. [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/c8bba806_c5354795">Patch Set #7, Line 533:</a> <code style=3D"fo=
nt-family:monospace,monospace">            {</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this is =
a behavioural change, not checking `advance_next_remote` anymore. [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/=
comment/0274c355_3b2e8c19">Patch Set #7, Line 1959:</a> <code style=3D"font=
-family:monospace,monospace">        ASSERT(c-&gt;c2.link_sockets);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">this is not doing the same thing as before... [=E2=80=A6]</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment=
/9e623ad9_318662fe">Patch Set #7, Line 2015:</a> <code style=3D"font-family=
:monospace,monospace">            do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tun=
tap-&gt;actual_name, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ct=
x);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">line length exceeded, and the old version wasn&#3=
9;t that bad (the unwrapping above was reasonable, with [=E2=80=A6]</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/83e1=
f2b3_82aeffb6">Patch Set #7, Line 3819:</a> <code style=3D"font-family:mono=
space,monospace">do_init_socket_1(struct context *c)</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I think we should stick to `phase1` as function name, otherwise it reads as=
 if this is &quot;init socket  [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/434/comment/983be341_eb72cb9c">Patch Set =
#7, Line 4011:</a> <code style=3D"font-family:monospace,monospace">    if (=
c-&gt;c2.link_sockets &amp;&amp; c-&gt;c2.link_socket_owned)</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">what happened to the `is_dco_win()` part here?  This looks like a r=
ebase accident</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/434/comment/0dd0c10f_cbddc037">Patch Set #7, Line 4040:</a> <code sty=
le=3D"font-family:monospace,monospace">        CLEAR(c-&gt;c1.link_socket_a=
ddrs[0].actual);</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">this looks inconsistent - freeaddrin=
fo() is called in the loop, while the CLEAR() is only called for [=E2=80=A6=
]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/com=
ment/8c4402d6_a5c9227d">Patch Set #7, Line 4719:</a> <code style=3D"font-fa=
mily:monospace,monospace">        do_init_socket_1(c);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">mmmh, see comment above, maybe name this `do_init_link_sockets_phase1()`?=
 [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/434/comment/90c989e7_e8b47bfa">Patch Set #7, Line 4762:</a> <code style=
=3D"font-family:monospace,monospace">        do_init_socket_2(c);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">`_phase2()`</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/434/comment/da819cb1_03b64f6a">Patch Set #7, Line 4968:</a>=
 <code style=3D"font-family:monospace,monospace">                       &am=
p;dest-&gt;gc);</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">is this wrapping necessary?  Comparin=
g to the lines below it does not seem like it</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/434/comment/d1d68fc6_23406680">Patch Set #7, Line 384:</a>=
 <code style=3D"font-family:monospace,monospace">        for (int i =3D 0; =
i &lt; m-&gt;top.c1.link_sockets_num; i++)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this com=
ment opened a little pandora&#39;s box... [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">In the next patches w=
e will have a common server loop for both TCP and UDP however the I/O proce=
ssing will remain separate, for this specific case we decided to pass direc=
tly the link_socket to avoid to walk through all of them, in the final patc=
h we will handle directly the link_socket returned by the event_set.</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/434/comment/6534f7ed_de52f295">Patch Set #7, L=
ine 1858:</a> <code style=3D"font-family:monospace,monospace">    c-&gt;c2.=
link_sockets[sock_index]-&gt;local_host =3D c-&gt;options.ce.local;</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Can this be changed to `*sock =3D &amp;c-&gt;c2. [=E2=80=A6]=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comm=
ent/b247da87_2274fb46">Patch Set #7, Line 2222:</a> <code style=3D"font-fam=
ily:monospace,monospace">#if defined (_WIN32)</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">unrelat=
ed whitespace change, please do not (also, this extra space is not how it&#=
39;s done elsewhere)</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/434/comment/58256377_1c734eb8">Patch Set #7, Line 2259:</a> <co=
de style=3D"font-family:monospace,monospace">        sig_info-&gt;signal_re=
ceived =3D SIGUSR1;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">I think this is a rebase artefact=
, the multisocket patch colliding with Selva&#39;s signal handler rewor [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/434/comment/72e83319_3a6cdcc6">Patch Set #7, Line 2271:</a> <code style=
=3D"font-family:monospace,monospace">                          sig_info);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">please do not wrap.  The line is not long and not chan=
ged by this patch.</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/434/comment/93ac21b3_d36b9855">Patch Set #7, Line 2297:</a> <code=
 style=3D"font-family:monospace,monospace">    if (sig_save)</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">again, please thoroughly double check. [=E2=80=A6]</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/434?usp=3Demail">change 434</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Dec 2024 13:10:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--kVm3pvlzIKw=--

