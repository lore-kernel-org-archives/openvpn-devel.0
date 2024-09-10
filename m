MIME-Version: 1.0
References: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
 <CAOrkh=VofSeqgYkj1VZaJjX38YVNCOeFSeExOV+keZ_FF1DNLw@...278...>
 <ab17d585.AU8AAE4OREEAAAAAAAAAAajn0CoAAYCsnhYAAAAAABXTlQBm3_yN@...2677...>
In-Reply-To: <ab17d585.AU8AAE4OREEAAAAAAAAAAajn0CoAAYCsnhYAAAAAABXTlQBm3_yN@...2677...>
From: Petr Portnov <mrjarviscraft@...277...>
Date: Tue, 10 Sep 2024 12:12:37 +0300
Message-ID: <CAOrkh=Wft-tZsRDEG_dm+CA-RG0ytsrpoxKEQHutzOa7kveroQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000ef8d980621c04667"
Subject: Re: [Openvpn-devel] [PATCH] build: reduce hardcode in `asio_path`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ef8d980621c04667
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply!
No problems, just making sure that the message was not lost in the archive
:)

Glad to hear that the patch will be integrated!

=D0=B2=D1=82, 10 =D1=81=D0=B5=D0=BD=D1=82. 2024 =D0=B3., 11:00 David Sommer=
seth <dazo+openvpn@...2108...>:

> On 09/09/2024 21:43, Petr Portnov wrote:
> > Hi there! Any updates on this proposal?
> >
> > =D0=BF=D0=BD, 2 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 2=
2:34, Petr Portnov <mrjarviscraft@...277...
> > <mailto:mrjarviscraft@...277...>>:
> >
> >     Hi there! While working on packaging `openvpn3-linux` for NixOS I've
> >     discovered a problem with `asio_path` child path being too strict
> >     (since not all distros have `asio` as the parent of `include`
> >     directory). Thus I am suggesting a simple patch which allows better
> >     control over this path allowing easier integration with distros.
>
> Hi!
>
> Sorry for the long reply time.  Just been a bit too hectic lately.
>
> I've seen your patch, and it makes total sense.  It's in my pipe to get
> merged as soon as I have cleaned up a bunch of other changes as well.
>
> Again, sorry for the slow response.
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

--000000000000ef8d980621c04667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">Thanks for your reply!<br>
No problems, just making sure that the message was not lost in the archive =
:)</p>
<p dir=3D"ltr">Glad to hear that the patch will be integrated! </p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=
=D1=82, 10 =D1=81=D0=B5=D0=BD=D1=82. 2024 =D0=B3., 11:00 David Sommerseth &=
lt;<a href=3D"mailto:dazo%2Bopenvpn@...2108..." target=3D"_blank" rel=3D"no=
referrer">dazo+openvpn@...2108...</a>&gt;:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On 09/09/2024 21:43, Petr Portnov wrote:<br>
&gt; Hi there! Any updates on this proposal?<br>
&gt; <br>
&gt; =D0=BF=D0=BD, 2 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 =
22:34, Petr Portnov &lt;<a href=3D"mailto:mrjarviscraft@...277..." rel=3D"n=
oreferrer noreferrer" target=3D"_blank">mrjarviscraft@...277...</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:mrjarviscraft@...277..." rel=3D"noreferre=
r noreferrer" target=3D"_blank">mrjarviscraft@...277...</a>&gt;&gt;:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi there! While working on packaging `openvpn3-linu=
x` for NixOS I&#39;ve<br>
&gt;=C2=A0 =C2=A0 =C2=A0discovered a problem with `asio_path` child path be=
ing too strict<br>
&gt;=C2=A0 =C2=A0 =C2=A0(since not all distros have `asio` as the parent of=
 `include`<br>
&gt;=C2=A0 =C2=A0 =C2=A0directory). Thus I am suggesting a simple patch whi=
ch allows better<br>
&gt;=C2=A0 =C2=A0 =C2=A0control over this path allowing easier integration =
with distros.<br>
<br>
Hi!<br>
<br>
Sorry for the long reply time.=C2=A0 Just been a bit too hectic lately.<br>
<br>
I&#39;ve seen your patch, and it makes total sense.=C2=A0 It&#39;s in my pi=
pe to get <br>
merged as soon as I have cleaned up a bunch of other changes as well.<br>
<br>
Again, sorry for the slow response.<br>
<br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
</blockquote></div></div>

--000000000000ef8d980621c04667--

