MIME-Version: 1.0
In-Reply-To: <A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 12:25:23 -0500
Message-ID: <CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
Content-Type: multipart/alternative; boundary=001a1144424e4c9fd80526f31483
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Debbie Tent <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144424e4c9fd80526f31483
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 15, 2015 at 11:29 AM, <debbie10t@...277...> wrote:


> Any clarity on what to expect of the --block-outside-dns option
> and what windows version it is/will be support would help.
>

1. git_master:
 -  May be built with target = vista and will run correctly only on vista
and above
    (this is the default target in openvpn-build if git-master source is
used)
 -  Will support --block-outside-dns when run on vista and above --
undefined behaviour if attempted to run on winxp

2. release/2.3 (and upcoming 2.3.9)
- May be built for target = winxp
  (this is the default target in openvpn-build if release/2.3 source is
used)
- Support for --block-outside-dns determined automatically at run-time:
     when run on vista and above the option will be supported
     when run on winxp the option will be ignored or cause
     a fatal error depending on how it is specified:
        if pushed from a server: just a warning in the logs
        specified in the config: fatal error unless protected by
        ignore-unknown-option or setenv-opt or forward-compatible...

 3. Both should build correctly for 64-bit and 32-bit platforms

Selva

--001a1144424e4c9fd80526f31483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Dec 15, 2015 at 11:29 AM,  <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&gt;</spa=
n> wrote:<br><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Any clarity on what to expect of the --block-outside-dns option<br>
and what windows version it is/will be support would help.<br></blockquote>=
<div><br>1. git_master:<br>=C2=A0-=C2=A0 May be built with target =3D vista=
 and will run correctly only on vista and above<br></div><div>=C2=A0=C2=A0=
=C2=A0 (this is the default target in openvpn-build if git-master source is=
 used)<br></div><div>=C2=A0-=C2=A0 Will support --block-outside-dns when ru=
n on vista and above -- undefined behaviour if attempted to run on winxp<br=
><br>2. release/2.3 (and upcoming 2.3.9)<br>- May be built for target =3D w=
inxp<br></div><div>=C2=A0 (this is the default target in openvpn-build if r=
elease/2.3 source is used)<br></div><div>- Support for --block-outside-dns =
determined automatically at run-time:<br></div><div>=C2=A0=C2=A0=C2=A0=C2=
=A0 when run on vista and above the option will be supported<br></div><div>=
=C2=A0=C2=A0=C2=A0=C2=A0 when run on winxp the option will be ignored or ca=
use <br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0 a fatal error depending on how =
it is specified:<br></div><div>=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if pus=
hed from a server: just a warning in the logs<br></div><div>=C2=A0 =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 specified in the config: fatal error unless protec=
ted by <br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore-unknown-option=
 or setenv-opt or forward-compatible...<br></div><div><br></div><div>=C2=A0=
3. Both should build correctly for 64-bit and 32-bit platforms<br><br></div=
><div>Selva<br></div></div></div></div>

--001a1144424e4c9fd80526f31483--

