MIME-Version: 1.0
In-Reply-To: <4D68E86D.7000203@...1114...>
References: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>
	<20110226104526.GT9835@...1296...>
	<AANLkTik-vCrO=yQW7FNiUXyrXfKjNe-3Dq4aGUkHsfT5@...278...>
	<20110226112534.GV9835@...1296...>
	<4D68E86D.7000203@...1114...>
Date: Sun, 27 Feb 2011 21:49:25 +0000
Message-ID: <AANLkTintZLuN1c6_2TEUjvmJvxC3ZpS2Ra9ejF=pA+2S@...278...>
From: Olivier Van Acker <cyberroadie@...277...>
Content-Type: multipart/alternative; boundary=000e0cd29c8a65d184049d4a894d
Subject: Re: [Openvpn-devel] sctp in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--000e0cd29c8a65d184049d4a894d
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

>
>
> for broader testing gets interesting.  If Linux gets support quickly, I'm
> able
> to test this out pretty soonish in a limited prod environment.
>
>
I might start with Linux first since, as you rightly point out, more people
can use/test it.
Worth mentioning: you need third party implementation of SCTP on
Windows and Mac OS X so this  might be a significant hurdle for
adoption on these platforms :-(



> Some practical details.  General info about the development process can be
> found here:
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>,
> including
> git repositories.
>
>
Thanks, will read it.



> So what I'm saying, please base your stuff on JJO's branch
> now, but be sure your changes can be merged against the feat_ipv6_payload
> branch too.  As I'm the one going to do the merges, I'm going to be noisy
> if
> it doesn't go smooth ;-)
>
> Yes, I'll try JJO's branch first, see if I can make it work on FreeBSD and
Linux

Cheers,

Olivier








> And just let me state that, if someone got time to do a real overhaul of
> socket.c, that would really be beneficial.  That source file is confusing
> at
> best to read.  However, we do have some source documentation patches is t=
he
> wild somewhere, waiting to go in soonish too - which I'd like to see go
> into
> the 2.3 cycle.  So - there's a little coordination needed to be done here
> with
> such an overhaul too.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk1o6G0ACgkQDC186MBRfrrnPACgg5MNumXBR0McuTEip6/c76lY
> BacAoIANCG/ZGas/yhiGEbw4U7xqDYeI
> =3DPMoQ
> -----END PGP SIGNATURE-----
>



--=20
=93If you know what you're doing, three layers is enough; if you don't, even
seventeen levels won't help=94. ~ Padlipsky

--000e0cd29c8a65d184049d4a894d
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im=
"><br></div>
for broader testing gets interesting. =A0If Linux gets support quickly, I&#=
39;m able<br>
to test this out pretty soonish in a limited prod environment.<br>
<br></blockquote><div><br></div><div>I might start with Linux first since, =
as you rightly point out, more people=A0</div><div>can use/test it.=A0</div=
><div>Worth mentioning: you need third party implementation of SCTP on=A0</=
div>
<div>Windows and=A0Mac OS X=A0so this =A0might be a significant hurdle for=
=A0</div><div>adoption on these=A0platforms :-(</div><div><br></div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;">

Some practical details. =A0General info about the development process can b=
e<br>
found here:<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocument=
ation" target=3D"_blank">https://community.openvpn.net/openvpn/wiki/Develop=
erDocumentation</a>&gt;, including<br>
git repositories.<br>
<br></blockquote><div><br></div><div>Thanks, will read it.</div><div><br></=
div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex;">So what I&#39;m saying, p=
lease base your stuff on JJO&#39;s branch<br>

now, but be sure your changes can be merged against the feat_ipv6_payload<b=
r>
branch too. =A0As I&#39;m the one going to do the merges, I&#39;m going to =
be noisy if<br>
it doesn&#39;t go smooth ;-)<br>
<br></blockquote><div>Yes, I&#39;ll try JJO&#39;s branch first, see if I ca=
n make it work on FreeBSD and Linux</div><div><br></div><div>Cheers,</div><=
div><br></div><div>Olivier</div><div><br></div><div><br></div><div><br>
</div><div><br></div><div><br></div><div><br></div><div>=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex;">
And just let me state that, if someone got time to do a real overhaul of<br>
socket.c, that would really be beneficial. =A0That source file is confusing=
 at<br>
best to read. =A0However, we do have some source documentation patches is t=
he<br>
wild somewhere, waiting to go in soonish too - which I&#39;d like to see go=
 into<br>
the 2.3 cycle. =A0So - there&#39;s a little coordination needed to be done =
here with<br>
such an overhaul too.<br>
<br>
<br>
kind regards,<br>
<br>
David Sommerseth<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.10 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
iEYEARECAAYFAk1o6G0ACgkQDC186MBRfrrnPACgg5MNumXBR0McuTEip6/c76lY<br>
BacAoIANCG/ZGas/yhiGEbw4U7xqDYeI<br>
=3DPMoQ<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>=93If you know what you=
&#39;re doing, three layers is enough; if you don&#39;t, even seventeen lev=
els won&#39;t help=94. ~ Padlipsky<br>

--000e0cd29c8a65d184049d4a894d--

