MIME-Version: 1.0
References: <20210317220642.38741-1-openvpn@...2080...>
 <202103180744.12I7iaE2073329@...2054...>
In-Reply-To: <202103180744.12I7iaE2073329@...2054...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 18 Mar 2021 16:14:20 +0500
Message-ID: <CAFHpkQF9Ga24wHjGOPAf+v+fZ7qCpmGOW-Ms9fTBiFuYHcrgTg@...278...>
Content-Type: multipart/alternative; boundary="00000000000021d58605bdcdb4ce"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: build: Remove compat-lz4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, samuli.seppanen@...277...
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000021d58605bdcdb4ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this probably will break windows cross compile (it uses lz4 bundle).

Samuli, can you please keep any eye on it  (new test installer maybe) ?

=D1=87=D1=82, 18 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 12:45, Gert Doerin=
g <gert@...1296...>:

> Acked-by: Gert Doering <gert@...1296...>
>
> I have tested compilation "with default options" on FreeBSD with lz4
> (works), Gentoo without lz4 (errors out), Gentoo with lz4 (works), and
> with --disable-lz4 on Gentoo without lz4 (works).
>
> I assume some of the buildbots will need a bit of tending now (because
> "no lz4 installed, since we bundle it anyway").  They will tell me...
>
> Your patch has been applied to the master branch.
>
> commit 24596b258aa3a9c0bd79e7e7bd4753c48a435408
> Author: David Sommerseth
> Date:   Wed Mar 17 23:06:42 2021 +0100
>
>      build: Remove compat-lz4
>
>      Signed-off-by: David Sommerseth <davids@...515...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20210317220642.38741-1-openvpn@...2080...
> >
>      URL:
> https://www.mail-archive.com/search?l=3Dmid&q=3D20210317220642.38741-1-op=
envpn@...2080...
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000021d58605bdcdb4ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>this probably will break windows cross compile (it us=
es lz4 bundle).</div><div><br></div><div>Samuli, can you please keep any ey=
e on it=C2=A0 (new test installer maybe) ?<br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 18 =D0=BC=
=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 12:45, Gert Doering &lt;<a href=3D"mailto=
:gert@...1296...">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Acked-by: Gert Doering &lt;<a href=3D"mailto:ger=
t@...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
I have tested compilation &quot;with default options&quot; on FreeBSD with =
lz4<br>
(works), Gentoo without lz4 (errors out), Gentoo with lz4 (works), and<br>
with --disable-lz4 on Gentoo without lz4 (works).<br>
<br>
I assume some of the buildbots will need a bit of tending now (because<br>
&quot;no lz4 installed, since we bundle it anyway&quot;).=C2=A0 They will t=
ell me...<br>
<br>
Your patch has been applied to the master branch.<br>
<br>
commit 24596b258aa3a9c0bd79e7e7bd4753c48a435408<br>
Author: David Sommerseth<br>
Date:=C2=A0 =C2=A0Wed Mar 17 23:06:42 2021 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0build: Remove compat-lz4<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:d=
avids@...515..." target=3D"_blank">davids@...515...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Gert Doering &lt;<a href=3D"mailto:gert@...1711...=
96..." target=3D"_blank">gert@...1296...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20210317220642.38741-=
1-openvpn@...2080..." target=3D"_blank">20210317220642.38741-1-openvpn@...1665...=
080...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/search?l=
=3Dmid&amp;q=3D20210317220642.38741-1-openvpn@...2080..." rel=3D"noreferrer=
" target=3D"_blank">https://www.mail-archive.com/search?l=3Dmid&amp;q=3D202=
10317220642.38741-1-openvpn@...2080...</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--00000000000021d58605bdcdb4ce--

