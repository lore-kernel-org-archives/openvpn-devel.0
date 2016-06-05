MIME-Version: 1.0
In-Reply-To: <CAA1Abx+iih31Sby-9bvM5h9n9LA3HaOcOwF+C_Px9zxN_kZtPg@...278...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
	<CAA1Abx+iih31Sby-9bvM5h9n9LA3HaOcOwF+C_Px9zxN_kZtPg@...278...>
Date: Sun, 5 Jun 2016 13:35:16 +0500
Message-ID: <CAFHpkQH1omVo=h5AH3GXEG--EAo8EFSQSvvBjPzy9hHZ9ckYmw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=047d7b5d31c8d53e41053483d519
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d31c8d53e41053483d519
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=8C=D0=B5, 5 =D0=
=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=
=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C Steffan Karger =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB:

> Hi,
>
> On Sun, Jun 5, 2016 at 12:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
> <javascript:;>> wrote:
> > I was impressed by unit testing efforts, so I suggest to implement
> something
> > like that
> >
> > https://travis-ci.org/chipitsine/openvpn/builds/135318558
> >
> > ( https://github.com/OpenVPN/openvpn/pull/52 )
> >
> > we can use Linux, Mac OSX, gcc, clang, various configure options.
> >
> > (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3
> does
> > not compile openvpn with openssl)
>
> Cool.  This looks like a very decent start.
>
> Afaik, OSX no longer ships with up-to-date versions of openssl.  We'd
> need to build openssl before building openvpn, just like you currently
> do with mbedtls.



openssl is shipped with Tunnelblick. so, we probably need to compile the
same version.
(first I was about to deprecate openssl on mac os in configure, but I have
changed my mind)

@jkbullard b



>
> -Steffan
>

--047d7b5d31c8d53e41053483d519
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=B2=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=8C=D0=B5,=
 5 =D0=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C Steffan Karger  =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BB:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Sun, Jun 5, 2016 at 12:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"javascript:;" onclick=3D"_e(even=
t, &#39;cvml&#39;, &#39;chipitsine@...277...&#39;)">chipitsine@...277...</a=
>&gt; wrote:<br>
&gt; I was impressed by unit testing efforts, so I suggest to implement som=
ething<br>
&gt; like that<br>
&gt;<br>
&gt; <a href=3D"https://travis-ci.org/chipitsine/openvpn/builds/135318558" =
target=3D"_blank">https://travis-ci.org/chipitsine/openvpn/builds/135318558=
</a><br>
&gt;<br>
&gt; ( <a href=3D"https://github.com/OpenVPN/openvpn/pull/52" target=3D"_bl=
ank">https://github.com/OpenVPN/openvpn/pull/52</a> )<br>
&gt;<br>
&gt; we can use Linux, Mac OSX, gcc, clang, various configure options.<br>
&gt;<br>
&gt; (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3 =
does<br>
&gt; not compile openvpn with openssl)<br>
<br>
Cool.=C2=A0 This looks like a very decent start.<br>
<br>
Afaik, OSX no longer ships with up-to-date versions of openssl.=C2=A0 We&#3=
9;d<br>
need to build openssl before building openvpn, just like you currently<br>
do with mbedtls.</blockquote><div><br></div><div><br></div><div>openssl is =
shipped with Tunnelblick. so, we probably need to compile the same version.=
</div><div>(first I was about to deprecate openssl on mac os in configure, =
but I have changed my mind)</div><div><br></div><div>@jkbullard b</div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-Steffan<br>
</blockquote>

--047d7b5d31c8d53e41053483d519--

