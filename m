MIME-Version: 1.0
In-Reply-To: <CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
References: <1474109679-4982-1-git-send-email-chipitsine@...277...>
	<CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 24 Sep 2016 11:32:55 +0500
Message-ID: <CAFHpkQHNbXW293tp3ua9fr5SwvuLgZh+nJKMR_yioUUVm0QUkg@...278...>
Content-Type: multipart/alternative; boundary=bcaec50b5194b58ae9053d3b105b
Subject: Re: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
	configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bcaec50b5194b58ae9053d3b105b
Content-Type: text/plain; charset=UTF-8

can we merge it ?

2016-09-17 16:17 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 17 September 2016 at 12:54, Ilya Shipitsin <chipitsine@...277...>
> wrote:
> > ---
> >  .travis.yml | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 452c48e..369db97 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -51,10 +51,6 @@ matrix:
> >        os: osx
> >        osx_image: xcode7.3
> >        compiler: clang
> > -  allow_failures:
> > -    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
> > -      os: linux
> > -      compiler: clang
> >    exclude:
> >      - compiler: gcc
> >
> > --
> > 2.5.5
>
> Thanks.  The patch is good, so ACK.
>
> But the commit messages should describe why this change is needed.  In
> this case:
>
> Previously, 'make test' failed for --disable-crypto builds.  Since
> that is not fixed, we should no longer accept --disable-crypto builds
> to fail 'make test' on travis.
>
> Could you please include such descriptions in future patches?
>
> -Steffan
>

--bcaec50b5194b58ae9053d3b105b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">can we merge it ?<br></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">2016-09-17 16:17 GMT+05:00 Steffan Karger <span =
dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">ste=
ffan@...1856...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 17 September 2016 at 12:54, Ilya Shipitsin &lt;<a href=3D"mailto:chipits=
ine@...277...">chipitsine@...277...</a>&gt; wrote:<br>
&gt; ---<br>
&gt;=C2=A0 .travis.yml | 4 ----<br>
&gt;=C2=A0 1 file changed, 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index 452c48e..369db97 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -51,10 +51,6 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 os: osx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 osx_image: xcode7.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
&gt; -=C2=A0 allow_failures:<br>
&gt; -=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quo=
t;--disable-<wbr>crypto&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 os: linux<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
&gt;=C2=A0 =C2=A0 exclude:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - compiler: gcc<br>
&gt;<br>
&gt; --<br>
&gt; 2.5.5<br>
<br>
Thanks.=C2=A0 The patch is good, so ACK.<br>
<br>
But the commit messages should describe why this change is needed.=C2=A0 In=
<br>
this case:<br>
<br>
Previously, &#39;make test&#39; failed for --disable-crypto builds.=C2=A0 S=
ince<br>
that is not fixed, we should no longer accept --disable-crypto builds<br>
to fail &#39;make test&#39; on travis.<br>
<br>
Could you please include such descriptions in future patches?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div>

--bcaec50b5194b58ae9053d3b105b--

