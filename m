MIME-Version: 1.0
References: <20220824105311.71288-1-arne@...1227...>
 <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
 <d948db75-b3ae-e922-7247-25556d04ba73@...1227...>
 <CAFHpkQE-yhweLEjB4F1rAJOBjW6cNUCrOHrEQKr7GPbSNS5VqQ@...278...>
 <e2e49e37-6cf9-0267-4092-1dda10d6c91b@...1227...>
In-Reply-To: <e2e49e37-6cf9-0267-4092-1dda10d6c91b@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 24 Aug 2022 18:02:26 +0500
Message-ID: <CAFHpkQE6r-PJy2w3zMB8qmYSztVM7Yc8zHts8Z7cSgShaLXZtg@...278...>
Content-Type: multipart/alternative; boundary="000000000000991fbe05e6fc4b71"
Subject: Re: [Openvpn-devel] [PATCH] Add OpenSSL 3.0 to mingw build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000991fbe05e6fc4b71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am fine with adding lib64 to 1.1.1

On Wed, Aug 24, 2022, 6:01 PM Arne Schwabe <arne@...1227...> wrote:

> Am 24.08.22 um 14:36 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD:
> > It reverts 3.0 behaviour to 1.1.1
> > However --libdir is available for 1.1.1 as well
>
> I understand. What I am missing is *why* reverting to 1.1.1 is a good
> idea. I think we should rather use the new default. I can see arguments
> that we add --libdir=3Dlib64 to openSSL 1.1.1 to adjust it to OpenSSL 3.0
> but not the other way round.
>
> Arne
>
>

--000000000000991fbe05e6fc4b71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I am fine with adding lib64 to 1.1.1</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 24, 2022=
, 6:01 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...2639...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 24.08.22 um 14=
:36 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD:<br>
&gt; It reverts 3.0 behaviour to 1.1.1<br>
&gt; However --libdir is available for 1.1.1 as well<br>
<br>
I understand. What I am missing is *why* reverting to 1.1.1 is a good <br>
idea. I think we should rather use the new default. I can see arguments <br>
that we add --libdir=3Dlib64 to openSSL 1.1.1 to adjust it to OpenSSL 3.0 <=
br>
but not the other way round.<br>
<br>
Arne<br>
<br>
</blockquote></div>

--000000000000991fbe05e6fc4b71--

