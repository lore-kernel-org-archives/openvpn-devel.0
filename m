From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 29 Dec 2024 22:40:09 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <0c421d9c23b5e07327c3c2b90e8c80a6d3e4e12e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GPmQfcZRiU0="; charset=UTF-8
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

--GPmQfcZRiU0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/434?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................


Patch Set 10: Code-Review-2

(18 comments)

Patchset:

PS10:
Getting there, and except for the `bind_dev` these are minor nitpicks in th=
e source (but worth fixing if we do another round anyway).

In the review, I seem to have overlooked something, though - applying this =
on top of current master breaks `--fragment` servers - on the first connect=
ing client, *boom*

```
2024-12-29 23:34:56 us=3D142019 Initialization Sequence Completed
2024-12-29 23:35:05 us=3D857683 Connection Attempt MULTI: multi_create_inst=
ance called
2024-12-29 23:35:05 us=3D857852 2001:608:0:814::f000:21 Re-using SSL/TLS co=
ntext
2024-12-29 23:35:05 us=3D857903 2001:608:0:814::f000:21 WARNING: if you use=
 --mssfix and --fragment, you should use the "mtu" flag for both or none of=
 of them.
2024-12-29 23:35:05 us=3D858101 2001:608:0:814::f000:21 Control Channel MTU=
 parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 paylo=
ad:1600 tailroom:126 ET:0 ]

Program received signal SIGSEGV, Segmentation fault.
0x000055555558121e in get_link_socket_info (c=3D0x5555556c6450)
    at /home/gert/t_server.git/src/openvpn/forward.h:324
324             return &c->c2.link_sockets[0]->info;
(gdb) where
#0  0x000055555558121e in get_link_socket_info (c=3D0x5555556c6450)
    at /home/gert/t_server.git/src/openvpn/forward.h:324
#1  do_init_fragment (c=3D0x5555556c6450) at init.c:3801
#2  init_instance (c=3Dc@...1851...=3D0x5555556c6450, env=3D<optimized out>,
    flags=3Dflags@...1851...=3D10) at init.c:4736
#3  0x0000555555581e91 in inherit_context_child (
    dest=3Ddest@...1851...=3D0x5555556c6450, src=3Dsrc@...1851...=3D0x7ffff=
fffc848,
    ls=3Dls@...1851...=3D0x55555569fb00) at init.c:4977
#4  0x00005555555999e0 in multi_create_instance (m=3Dm@...1851...=3D0x7ffff=
fffc780,
    real=3Dreal@...1851...=3D0x7fffffffc3c0, ls=3Dls@...1851...=3D0x5555556=
9fb00) at multi.c:777
#5  0x00005555555928b2 in multi_get_create_instance_udp (m=3D0x7fffffffc780,
    floated=3Dfloated@...1851...=3D0x7fffffffc6cf, ls=3Dls@...1851...=3D0x5=
5555569fb00)
    at mudp.c:260
#6  0x000055555559a4dd in multi_process_incoming_link (
    m=3Dm@...1851...=3D0x7fffffffc780, instance=3Dinstance@...1851...=3D0x0,
    mpp_flags=3Dmpp_flags@...1851...=3D5, ls=3Dls@...1851...=3D0x55555569fb=
00) at multi.c:3356
#7  0x00005555555935f2 in multi_process_io_udp (m=3D0x7fffffffc780,
    sock=3D0x55555569fb00) at mudp.c:387
#8  tunnel_server_udp (top=3Dtop@...1851...=3D0x7fffffffda10) at mudp.c:523
#9  0x000055555559b2c4 in tunnel_server (top=3Dtop@...1851...=3D0x7fffffffd=
a10)
    at multi.c:4168
(gdb) print &c->c2.link_sockets[0]->info
Cannot access memory at address 0x0
(gdb) print &c->c2.link_sockets[0]
$1 =3D (struct link_socket **) 0x0
```

so it definitely looks like "socket not initialized", though I have no idea=
 why.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/721e4eca_fe894283 :
PS9, Line 4054:         {
The `if()` should be outside and the `for()` inside - the condition does no=
t depend on `i`.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/1a384971_29102103 :
PS9, Line 4062:         {
same thing.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/89309b77_8f3abbb8 :
PS9, Line 4786:                                 get_link_socket_info(c));
Should this be a per-socket thing?  IPv4 vs. IPv6 will change overhead so t=
he `frame` calculation will be wrong for all sockets !=3D 0.

Maybe a comment to that extent ("for multiple listening sockets, this will =
not be correct for these cases, but everything but TLS should no longer be =
used anyway")?


http://gerrit.openvpn.net/c/openvpn/+/434/comment/a405a93a_e360204a :
PS9, Line 4991:                      &dest->gc);
if line length permits, can this be unwrapped?


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/040f4e94_88362f91 :
PS9, Line 271:                                      &c->c2.link_sockets[i]-=
>ev_arg);
the diff looks as if there are tabs at the beginning of this line?


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/0490e7ea_822b07fb :
PS9, Line 388:                                         sock);
please unwrap


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/7963d5d0_1f026e7c :
PS9, Line 3336: {
I think this could be wrapped before `const unsigned int mpp_flags`


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/434/comment/c450a732_4bec3d43 :
PS9, Line 1037:
another blank line


http://gerrit.openvpn.net/c/openvpn/+/434/comment/a223f45e_43302346 :
PS9, Line 1875:     sock->bind_dev =3D o->bind_dev;
where did that go to?  another rebase accident?  *red flag*


http://gerrit.openvpn.net/c/openvpn/+/434/comment/03786af0_25ca4cba :
PS9, Line 1019:     socket_descriptor_t sd;
we shouldn't delete blank lines unrelated to actual changes (minor nit)


http://gerrit.openvpn.net/c/openvpn/+/434/comment/9c9ce7e2_01384c14 :
PS9, Line 1854:                         int mode)
please unwrap


http://gerrit.openvpn.net/c/openvpn/+/434/comment/b9a7826e_aead3ffe :
PS9, Line 1863:     sock->remote_port =3D o->ce.remote_port;
not sure this change (remove the local variables `remote_host` and `remote_=
port`) is a good thing as part of this patchset.  It's cleanup/refactoring,=
 and unrelated, but makes this diff larger than it should be.

So I'd prefer to not do this set of changes.


http://gerrit.openvpn.net/c/openvpn/+/434/comment/bff14e2e_61aafce1 :
PS9, Line 1919:         sock->proxy_dest_port =3D o->ce.remote_port;
this


http://gerrit.openvpn.net/c/openvpn/+/434/comment/ac638e3f_3c683fd8 :
PS9, Line 1924:
spurious blank line


http://gerrit.openvpn.net/c/openvpn/+/434/comment/8bdd62db_a3c5abdd :
PS9, Line 1931:         sock->proxy_dest_port =3D o->ce.remote_port;
this


http://gerrit.openvpn.net/c/openvpn/+/434/comment/c27c8614_67874b24 :
PS9, Line 1936:         sock->remote_port =3D o->ce.remote_port;
and this


http://gerrit.openvpn.net/c/openvpn/+/434/comment/731d7cd9_eba0b68a :
PS9, Line 2301:         /* Always restore the saved signal --register/throw=
_signal will handle priority */
you lost a ` ` here after `--` (this is not a command line option `--regist=
er`)



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
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Sun, 29 Dec 2024 22:40:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--GPmQfcZRiU0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">V=
iew Change</a></p><p>18 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/434?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Getting there, and except for the `bind_de=
v` these are minor nitpicks in the source (but worth fixing if we do anothe=
r round anyway).</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">In the review, I seem to have overlooked something, though - applying t=
his on top of current master breaks `--fragment` servers - on the first con=
necting client, *boom*</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">```<br>2024-12-29 23:34:56 us=3D142019 Initialization Sequence Co=
mpleted<br>2024-12-29 23:35:05 us=3D857683 Connection Attempt MULTI: multi_=
create_instance called<br>2024-12-29 23:35:05 us=3D857852 2001:608:0:814::f=
000:21 Re-using SSL/TLS context<br>2024-12-29 23:35:05 us=3D857903 2001:608=
:0:814::f000:21 WARNING: if you use --mssfix and --fragment, you should use=
 the &quot;mtu&quot; flag for both or none of of them.<br>2024-12-29 23:35:=
05 us=3D858101 2001:608:0:814::f000:21 Control Channel MTU parms [ mss_fix:=
0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 payload:1600 tailroom:=
126 ET:0 ]</p><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Program received signal SIGSEGV, Segmentation fault.<br>0x000055=
555558121e in get_link_socket_info (c=3D0x5555556c6450)<br>    at /home/ger=
t/t_server.git/src/openvpn/forward.h:324<br>324             return &amp;c-&=
gt;c2.link_sockets[0]-&gt;info;<br>(gdb) where<br>#0  0x000055555558121e in=
 get_link_socket_info (c=3D0x5555556c6450)<br>    at /home/gert/t_server.gi=
t/src/openvpn/forward.h:324<br>#1  do_init_fragment (c=3D0x5555556c6450) at=
 init.c:3801<br>#2  init_instance (c=3Dc@...1851...=3D0x5555556c6450, env=
=3D&lt;optimized out&gt;, <br>    flags=3Dflags@...1851...=3D10) at init.c:=
4736<br>#3  0x0000555555581e91 in inherit_context_child (<br>    dest=3Ddes=
t@...1851...=3D0x5555556c6450, src=3Dsrc@...1851...=3D0x7fffffffc848, <br> =
   ls=3Dls@...1851...=3D0x55555569fb00) at init.c:4977<br>#4  0x00005555555=
999e0 in multi_create_instance (m=3Dm@...1851...=3D0x7fffffffc780, <br>    =
real=3Dreal@...1851...=3D0x7fffffffc3c0, ls=3Dls@...1851...=3D0x55555569fb0=
0) at multi.c:777<br>#5  0x00005555555928b2 in multi_get_create_instance_ud=
p (m=3D0x7fffffffc780, <br>    floated=3Dfloated@...1851...=3D0x7fffffffc6c=
f, ls=3Dls@...1851...=3D0x55555569fb00)<br>    at mudp.c:260<br>#6  0x00005=
5555559a4dd in multi_process_incoming_link (<br>    m=3Dm@...1851...=3D0x7f=
ffffffc780, instance=3Dinstance@...1851...=3D0x0, <br>    mpp_flags=3Dmpp_f=
lags@...1851...=3D5, ls=3Dls@...1851...=3D0x55555569fb00) at multi.c:3356<b=
r>#7  0x00005555555935f2 in multi_process_io_udp (m=3D0x7fffffffc780, <br> =
   sock=3D0x55555569fb00) at mudp.c:387<br>#8  tunnel_server_udp (top=3Dtop=
@...1851...=3D0x7fffffffda10) at mudp.c:523<br>#9  0x000055555559b2c4 in tu=
nnel_server (top=3Dtop@...1851...=3D0x7fffffffda10)<br>    at multi.c:4168<=
br>(gdb) print &amp;c-&gt;c2.link_sockets[0]-&gt;info<br>Cannot access memo=
ry at address 0x0<br>(gdb) print &amp;c-&gt;c2.link_sockets[0]<br>$1 =3D (s=
truct link_socket **) 0x0<br>```</pre><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">so it definitely looks like &quot;socket not initiali=
zed&quot;, though I have no idea why.</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/=
comment/721e4eca_fe894283">Patch Set #9, Line 4054:</a> <code style=3D"font=
-family:monospace,monospace">        {</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The `if()` should be outside and the `for(=
)` inside - the condition does not depend on `i`.</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/434/comment/1a384971_29102103">Patch Se=
t #9, Line 4062:</a> <code style=3D"font-family:monospace,monospace">      =
  {</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">sa=
me thing.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/=
comment/89309b77_8f3abbb8">Patch Set #9, Line 4786:</a> <code style=3D"font=
-family:monospace,monospace">                                get_link_socke=
t_info(c));</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Should this be a per-socket thing?  IPv4 vs. IPv6 will change overhea=
d so the `frame` calculation will be wrong for all sockets !=3D 0.</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe a comment to th=
at extent (&quot;for multiple listening sockets, this will not be correct f=
or these cases, but everything but TLS should no longer be used anyway&quot=
;)?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/commen=
t/a405a93a_e360204a">Patch Set #9, Line 4991:</a> <code style=3D"font-famil=
y:monospace,monospace">                     &amp;dest-&gt;gc);</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">if line length per=
mits, can this be unwrapped?</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mtcp.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/0=
40f4e94_88362f91">Patch Set #9, Line 271:</a> <code style=3D"font-family:mo=
nospace,monospace">                                     &amp;c-&gt;c2.link_=
sockets[i]-&gt;ev_arg);</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">the diff looks as if there are tabs at the beginning of t=
his line?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/0490e7ea_822b07fb">=
Patch Set #9, Line 388:</a> <code style=3D"font-family:monospace,monospace"=
>                                        sock);</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">please unwrap</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/434/comment/7963d5d0_1f026e7c">Patch Set #9, Line 3336:</a> =
<code style=3D"font-family:monospace,monospace">{</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I think this could be wrapped b=
efore `const unsigned int mpp_flags`</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/c450a732_4bec3d43">Patch Set #9, Line 1037:</a> <code style=3D"f=
ont-family:monospace,monospace"></code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">another blank line</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/434/comment/a223f45e_43302346">Patch Set #9=
, Line 1875:</a> <code style=3D"font-family:monospace,monospace">    sock-&=
gt;bind_dev =3D o-&gt;bind_dev;</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">where did that go to?  another rebase accident?  =
*red flag*</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
34/comment/03786af0_25ca4cba">Patch Set #9, Line 1019:</a> <code style=3D"f=
ont-family:monospace,monospace">    socket_descriptor_t sd;</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">we shouldn&#39;t dele=
te blank lines unrelated to actual changes (minor nit)</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/9c9ce7e2_01384c14">Pa=
tch Set #9, Line 1854:</a> <code style=3D"font-family:monospace,monospace">=
                        int mode)</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">please unwrap</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/434/comment/b9a7826e_aead3ffe">Patch Set #9, Li=
ne 1863:</a> <code style=3D"font-family:monospace,monospace">    sock-&gt;r=
emote_port =3D o-&gt;ce.remote_port;</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">not sure this change (remove the local varia=
bles `remote_host` and `remote_port`) is a good thing as part of this patch=
set.  It&#39;s cleanup/refactoring, and unrelated, but makes this diff larg=
er than it should be.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">So I&#39;d prefer to not do this set of changes.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/bff14e2e_61aafce1">=
Patch Set #9, Line 1919:</a> <code style=3D"font-family:monospace,monospace=
">        sock-&gt;proxy_dest_port =3D o-&gt;ce.remote_port;</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">this</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/434/comment/ac638e3f_3c683fd8=
">Patch Set #9, Line 1924:</a> <code style=3D"font-family:monospace,monospa=
ce"></code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">s=
purious blank line</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/434/comment/8bdd62db_a3c5abdd">Patch Set #9, Line 1931:</a> <code styl=
e=3D"font-family:monospace,monospace">        sock-&gt;proxy_dest_port =3D =
o-&gt;ce.remote_port;</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">this</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/434/comment/c27c8614_67874b24">Patch Set #9, Line 1936:</a> <code st=
yle=3D"font-family:monospace,monospace">        sock-&gt;remote_port =3D o-=
&gt;ce.remote_port;</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">and this</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/434/comment/731d7cd9_eba0b68a">Patch Set #9, Line 2301:</a> <code =
style=3D"font-family:monospace,monospace">        /* Always restore the sav=
ed signal --register/throw_signal will handle priority */</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">you lost a ` ` here aft=
er `--` (this is not a command line option `--register`)</p></li></ul></li>=
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 29 Dec 2024 22:40:09=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GPmQfcZRiU0=--

