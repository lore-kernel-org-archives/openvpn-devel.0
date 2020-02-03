MIME-Version: 1.0
References: <20200201135026.18074-1-chipitsine@...277...>
 <CAGyAFMX4hOKL1up6q9N6MLCzQYwVpVgnhd8CcgL7RucLPbWwgw@...278...>
 <CAFHpkQFszr8+iAmVy8P1D7b9WHuKATRnBtzU-x0vrrXdLAgNAA@...278...>
 <CAFHpkQEObnPX7duk8n2wmmCW9F_fj1RrPxKQX1HYarkLsedfNw@...278...>
 <CAFHpkQHd87Cjg2TbCSCygN4aonGNSas_02LjyC0+WjWYBkb_VQ@...278...>
 <E1iyYO4-0000Ho-MB@...2508...>
In-Reply-To: <E1iyYO4-0000Ho-MB@...2508...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 3 Feb 2020 14:59:54 +0500
Message-ID: <CAFHpkQHXELdZ8gi8jrzH64NA57ozBFS+Ey9eDU6eAN-qBZwHJw@...278...>
Content-Type: multipart/alternative; boundary="000000000000de0ce5059da8fca1"
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: add arm64, s390x builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000de0ce5059da8fca1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 14:51, Steffa=
n Karger <steffan.karger@...2507...>:

> On 03-02-2020 09:04, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > also, ARM64 builds are flaky. maybe we should add them as allow_failure=
s.
>
> What is flaky about the ARM64 builds? Is it our build? Is it the travis
> infra?
>

in travis-ci terms "our" failure means "build failed", travis-ci infra
means "build errored"

they run arm64 on linaro cloud, it fails (sometimes) on infra level (I
guess cloud is overloaded or like that). I did not seen yet tests failure


>
> -Steffan
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000de0ce5059da8fca1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=
=80. 2020 =D0=B3. =D0=B2 14:51, Steffan Karger &lt;<a href=3D"mailto:steffa=
n.karger@...2507...">steffan.karger@...2507...</a>&gt;:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 03-02-2020 09:04, =D0=98=D0=BB=
=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; also, ARM64 builds are flaky. maybe we should add them as allow_failur=
es.<br>
<br>
What is flaky about the ARM64 builds? Is it our build? Is it the travis<br>
infra?<br></blockquote><div><br></div><div>in travis-ci terms &quot;our&quo=
t; failure means &quot;build failed&quot;, travis-ci infra means &quot;buil=
d errored&quot;</div><div><br></div><div>they run arm64 on linaro cloud, it=
 fails (sometimes) on infra level (I guess cloud is overloaded or like that=
). I did not seen yet tests failure<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
-Steffan<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000de0ce5059da8fca1--

