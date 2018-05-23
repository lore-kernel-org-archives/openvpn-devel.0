MIME-Version: 1.0
In-Reply-To: <03bff833-41dc-8c3d-442c-3f360888196e@...2080...>
References: <CAFHpkQF9yo3qjs0kYbkSZqKa4xjsy7u5e0VqZ76H21S6puH5Mw@...278...>
 <03bff833-41dc-8c3d-442c-3f360888196e@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 23 May 2018 14:10:42 +0500
Message-ID: <CAFHpkQFK3wu6M1S_bWvVajqdZy29aYcgz=RJvtFXcZE71-+zdQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000cc4517056cdbe80c"
Subject: Re: [Openvpn-devel] linking interactive service and openvpn.exe
 into single binary ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cc4517056cdbe80c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-05-23 14:06 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 23/05/18 10:08, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Hello,
> >
> > we observe weird registry corruption, when "exe_path" points to wrong
> location.
> > I came to an idea, why not to link both service and openvpn.exe into
> single
> > openvpn.exe thus removing the need to specify exe_path at all ?
> >
> > thoughts ?
>
> Why not just use dirname() of the openvpn.exe binary path and expect the
> service to stay in the same directory?
>

we agreed with Selva Nair to use dirname() as the last resort when registry
is missing.
(I haven't send patch yet)

however, what I talk about is a different case. "exe_path" exists, but it
points to wrong location.


>
> Linking openvpn.exe and the interactive service is not going to be a
> trivial
> task at all and will mandate two different main() functions which are
> triggered depending on either basename(argv[0]) or some options ... this =
is
> going to be messy.
>
> Plus this approach can more open up new attack vectors as well, as a sing=
le
> binary can do much more work.  Like a buffer overflow in the packet
> processing
> (UDP/TCP or TUN/TAP code paths) triggering execution of interactive servi=
ce
> functions - this can easily be abused for privilege separation as the
> interactive service runs with elevated privileges while the plain openvpn
> side
> runs unprivileged now.
>
> So no, we should not "link" the interactive service with openvpn.exe.  Ev=
en
> though I am no big fan of qmail and the ucspi-tcp package, there are a few
> key
> things to learn from that approach.  Each individual piece in the qmail
> chain
> does a very limited set of tasks and focuses only on that.  So if there's=
 a
> exploit happening in one of the pieces in the chain, the damage is quite
> controlled and limited to the privileges of that individual piece.  It can
> truly be a big hassle and pain to set up such an environment, but it has
> some
> merits regardless.  I do not say we should split up OpenVPN like qmail,
> but we
> should try to keep the footprint privileged code running as small and
> controlled as possible.  Which is why we have interactive service and why
> we're working on a NETLINK integration on Linux.  And OpenVPN 3 on Linux
> takes
> a very different approach to this as well, and there is work in the pipe =
to
> reduce the privileged footprint even further.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>

--000000000000cc4517056cdbe80c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-05-23 14:06 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 23/05/18 1=
0:08, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; we observe weird registry corruption, when &quot;exe_path&quot; points=
 to wrong location.<br>
&gt; I came to an idea, why not to link both service and openvpn.exe into s=
ingle<br>
&gt; openvpn.exe thus removing the need to specify exe_path at all ?<br>
&gt; <br>
&gt; thoughts ?<br>
<br>
</span>Why not just use dirname() of the openvpn.exe binary path and expect=
 the<br>
service to stay in the same directory?<br></blockquote><div><br></div><div>=
we agreed with Selva Nair to use dirname() as the last resort when registry=
 is missing.<br></div><div>(I haven&#39;t send patch yet)<br><br></div><div=
>however, what I talk about is a different case. &quot;exe_path&quot; exist=
s, but it points to wrong location.<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
Linking openvpn.exe and the interactive service is not going to be a trivia=
l<br>
task at all and will mandate two different main() functions which are<br>
triggered depending on either basename(argv[0]) or some options ... this is=
<br>
going to be messy.<br>
<br>
Plus this approach can more open up new attack vectors as well, as a single=
<br>
binary can do much more work.=C2=A0 Like a buffer overflow in the packet pr=
ocessing<br>
(UDP/TCP or TUN/TAP code paths) triggering execution of interactive service=
<br>
functions - this can easily be abused for privilege separation as the<br>
interactive service runs with elevated privileges while the plain openvpn s=
ide<br>
runs unprivileged now.<br>
<br>
So no, we should not &quot;link&quot; the interactive service with openvpn.=
exe.=C2=A0 Even<br>
though I am no big fan of qmail and the ucspi-tcp package, there are a few =
key<br>
things to learn from that approach.=C2=A0 Each individual piece in the qmai=
l chain<br>
does a very limited set of tasks and focuses only on that.=C2=A0 So if ther=
e&#39;s a<br>
exploit happening in one of the pieces in the chain, the damage is quite<br>
controlled and limited to the privileges of that individual piece.=C2=A0 It=
 can<br>
truly be a big hassle and pain to set up such an environment, but it has so=
me<br>
merits regardless.=C2=A0 I do not say we should split up OpenVPN like qmail=
, but we<br>
should try to keep the footprint privileged code running as small and<br>
controlled as possible.=C2=A0 Which is why we have interactive service and =
why<br>
we&#39;re working on a NETLINK integration on Linux.=C2=A0 And OpenVPN 3 on=
 Linux takes<br>
a very different approach to this as well, and there is work in the pipe to=
<br>
reduce the privileged footprint even further.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--000000000000cc4517056cdbe80c--

