MIME-Version: 1.0
References: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q.ref@...278...>
 <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
 <aJQ9IkQIdH6sFNvt@...1296...>
 <CAOh3LPPhraQGp+N2RPPkJ01D64JGpU8ZeT6-Rqkh8fo8M=83zQ@...278...>
 <aJTGPksgtlTnN4XL@...1296...>
In-Reply-To: <aJTGPksgtlTnN4XL@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Thu, 7 Aug 2025 12:10:04 -0400
Message-ID: <CAOh3LPNJmBLKd-TRuwzWZ1pxRgiy5Bb88XCtZgsF9N3_5dXShw@...278...>
Content-Type: multipart/alternative; boundary="000000000000599108063bc8b1bb"
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000599108063bc8b1bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh right, you were correct, I installed the missing libtool package and the
autoreconf command now worked as well as the configure and make commands,
thanks! I could try testing this bulk mode change out on the newer code
base as well. I was trying to think of ways to simulate a client
reconnection scenario to see if everything like the options and data and
buffers being reset would recover and resume properly as well. :)

root@...2048...:tmp/openvpn-fork-bulk# ./src/openvpn/openvpn --help
OpenVPN 2.7_alpha3 aarch64-unknown-linux-gnu [SSL (OpenSSL)] [EPOLL]
[MH/PKTINFO] [AEAD] [DCO]

General Options:
--config file   : Read configuration options from file.
--help          : Show options.
--version       : Show copyright and version information.
...
--mtu-test      : Empirically measure and report MTU.
--bulk-mode     : Use bulk TUN/TCP reads/writes.
....



On Thu, Aug 7, 2025 at 11:29=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Thu, Aug 07, 2025 at 10:29:43AM -0400, Jon Chiappetta wrote:
> > Oh nice, thanks, I didn't know about that command as I have never ran it
> > myself before. I'll try to work through these errors and figure out how
> to
> > solve them:
> >
> > root@...2048...:tmp/openvpn-fork-bulk# autoreconf -vif
> > autoreconf: export WARNINGS=3D
> > autoreconf: Entering directory '.'
> > autoreconf: configure.ac: not using Gettext
> > autoreconf: running: aclocal --force -I m4
> > autoreconf: configure.ac: tracing
> > autoreconf: configure.ac: not using Libtool
>
> I think that means "you need to install the "libtool" package".
>
> (Frank - is there a way to make autoconf handle this in a smarter way?  In
> theory, libtool is optional, but our configure stuff fails later on if
> it's not found - ran across this in my fedora-42 experiments as well)
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000599108063bc8b1bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh right, you were correct, I installed the missing libtoo=
l package and the autoreconf command now worked as well as the configure an=
d make commands, thanks! I could try testing this bulk mode change out on t=
he newer code base as well. I was trying to think of ways to simulate a cli=
ent reconnection scenario to see if everything like the options and data an=
d buffers being reset would recover and resume properly as well. :)=C2=A0<d=
iv><br></div><div>root@...2048...:tmp/openvpn-fork-bulk# ./src/openvpn/open=
vpn --help<br>OpenVPN 2.7_alpha3 aarch64-unknown-linux-gnu [SSL (OpenSSL)] =
[EPOLL] [MH/PKTINFO] [AEAD] [DCO]<br><div><br></div><div>General Options:<b=
r>--config file =C2=A0 : Read configuration options from file.<br>--help =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Show options.<br>--version =C2=A0 =C2=
=A0 =C2=A0 : Show copyright and version information.<br></div><div>...</div=
><div>--mtu-test =C2=A0 =C2=A0 =C2=A0: Empirically measure and report MTU.<=
br>--bulk-mode =C2=A0 =C2=A0 : Use bulk TUN/TCP reads/writes.<br></div><div=
>....</div><div><br></div><div><br></div></div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Aug 7, 2025 at 11:29=E2=80=AFAM Gert Doering &lt;<a href=3D"mailto:gert@...220...=
..1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Thu, Aug 07, 2025 at 10:29:43AM -0400, Jon Chiappetta wrote:<br>
&gt; Oh nice, thanks, I didn&#39;t know about that command as I have never =
ran it<br>
&gt; myself before. I&#39;ll try to work through these errors and figure ou=
t how to<br>
&gt; solve them:<br>
&gt; <br>
&gt; root@...2048...:tmp/openvpn-fork-bulk# autoreconf -vif<br>
&gt; autoreconf: export WARNINGS=3D<br>
&gt; autoreconf: Entering directory &#39;.&#39;<br>
&gt; autoreconf: <a href=3D"http://configure.ac" rel=3D"noreferrer" target=
=3D"_blank">configure.ac</a>: not using Gettext<br>
&gt; autoreconf: running: aclocal --force -I m4<br>
&gt; autoreconf: <a href=3D"http://configure.ac" rel=3D"noreferrer" target=
=3D"_blank">configure.ac</a>: tracing<br>
&gt; autoreconf: <a href=3D"http://configure.ac" rel=3D"noreferrer" target=
=3D"_blank">configure.ac</a>: not using Libtool<br>
<br>
I think that means &quot;you need to install the &quot;libtool&quot; packag=
e&quot;.<br>
<br>
(Frank - is there a way to make autoconf handle this in a smarter way?=C2=
=A0 In<br>
theory, libtool is optional, but our configure stuff fails later on if<br>
it&#39;s not found - ran across this in my fedora-42 experiments as well)<b=
r>
<br>
gert<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--000000000000599108063bc8b1bb--

