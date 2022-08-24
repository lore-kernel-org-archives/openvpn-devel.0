MIME-Version: 1.0
References: <20220824105311.71288-1-arne@...1227...>
 <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
 <d948db75-b3ae-e922-7247-25556d04ba73@...1227...>
In-Reply-To: <d948db75-b3ae-e922-7247-25556d04ba73@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 24 Aug 2022 17:36:15 +0500
Message-ID: <CAFHpkQE-yhweLEjB4F1rAJOBjW6cNUCrOHrEQKr7GPbSNS5VqQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000fe501d05e6fbed97"
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

--000000000000fe501d05e6fbed97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It reverts 3.0 behaviour to 1.1.1
However --libdir is available for 1.1.1 as well

On Wed, Aug 24, 2022, 5:27 PM Arne Schwabe <arne@...1227...> wrote:

> Am 24.08.22 um 13:26 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD:
> > if this is not too late, can we add --libdir=3Dmingw/opt/lib to keep
> > current behaviour ?
> >
> >
> > +      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
> > +      # mingw/opt/lib, so we include both dirs in the following steps
> > +      # (pkcs11-helper and OpenVPN) so the libraries will be found
> >
>
> We could but I am not sure why we should force it to be in the other
> directory and deviate from the default of how the libraries are build.
>
> Arne
>

--000000000000fe501d05e6fbed97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It reverts 3.0 behaviour to 1.1.1=C2=A0<div dir=3D"auto">=
However --libdir is available for 1.1.1 as well</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 24, 2022=
, 5:27 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...2639...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 24.08.22 um 13=
:26 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD:<br>
&gt; if this is not too late, can we add --libdir=3Dmingw/opt/lib to keep <=
br>
&gt; current behaviour ?<br>
&gt; <br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # OpenSSL 3.0.5 installs itself into mingw/opt/l=
ib64 instead of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # mingw/opt/lib, so we include both dirs in the =
following steps<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # (pkcs11-helper and OpenVPN) so the libraries w=
ill be found<br>
&gt; <br>
<br>
We could but I am not sure why we should force it to be in the other <br>
directory and deviate from the default of how the libraries are build.<br>
<br>
Arne<br>
</blockquote></div>

--000000000000fe501d05e6fbed97--

