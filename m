MIME-Version: 1.0
References: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
In-Reply-To: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
From: Petr Portnov <mrjarviscraft@...277...>
Date: Mon, 9 Sep 2024 22:43:00 +0300
Message-ID: <CAOrkh=VofSeqgYkj1VZaJjX38YVNCOeFSeExOV+keZ_FF1DNLw@...278...>
Content-Type: multipart/alternative; boundary="000000000000afbe300621b4f7cd"
Subject: Re: [Openvpn-devel] [PATCH] build: reduce hardcode in `asio_path`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000afbe300621b4f7cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there! Any updates on this proposal?

=D0=BF=D0=BD, 2 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 22:34=
, Petr Portnov <mrjarviscraft@...277...>:

> Hi there! While working on packaging `openvpn3-linux` for NixOS I've
> discovered a problem with `asio_path` child path being too strict (since
> not all distros have `asio` as the parent of `include` directory). Thus I
> am suggesting a simple patch which allows better control over this path
> allowing easier integration with distros.
>

--000000000000afbe300621b4f7cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi there! Any updates on this proposal?<br><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 2 =D1=
=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 22:34, Petr Portnov &lt;=
<a href=3D"mailto:mrjarviscraft@...277..." target=3D"_blank">mrjarviscraft@=
...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr">Hi there! While working on packaging `openvpn3-linux` f=
or NixOS I&#39;ve discovered a problem with `asio_path` child path being to=
o strict (since not all distros have `asio` as the parent of `include` dire=
ctory). Thus I am suggesting a simple patch which allows better control ove=
r this path allowing easier integration with distros.<br></div>
</blockquote></div></div>

--000000000000afbe300621b4f7cd--

