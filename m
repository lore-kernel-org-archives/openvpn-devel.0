MIME-Version: 1.0
In-Reply-To: <20160102184746.GV24952@...1296...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...> <20151226091900.GU24952@...1296...>
	<567E60A9.6020006@...1856...>
	<CAFHpkQEiJevqD7+jQ0+MdFh2Q0XmbFR3=8vTeAYz6meH1pFGAA@...278...>
	<20160102184746.GV24952@...1296...>
Date: Sat, 2 Jan 2016 21:53:11 +0300
Message-ID: <CAFHpkQHkLNvC8f7oPP98pen1sAb=TOsJtPkyGi0ZWuXe2vZrTw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3cb3443b18105285e6623
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
	expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11c3cb3443b18105285e6623
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as for my observation, people share password with coworkers, they will
share cert in the same way :)

well, password-only is legitimate setup, so I would add test case for it.
maybe bit later.
where can I have a look at existing test cases you are talking about?

=D1=81=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 2 =D1=8F=D0=BD=D0=B2=D0=B0=D1=
=80=D1=8F 2016 =D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D0=B5=D0=BB=D1=8C Gert Doering =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:

> Hi,
>
> On Sat, Jan 02, 2016 at 09:14:21PM +0300, ???????? ?????????????? wrote:
> > also, does it make sence to perform unit testing on build like
> >
> > setup server with user/password auth on localhost, connect to is using
> > client, see whether it is ok....
>
> We do, but we don't run test setups without certificates (my auth/pass
> users *also* have to have a certificate - helps against lost passwords,
> because you also need to steal key+cert)
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296... <javascript:;>
> fax: +49-89-35655025
> gert@...1297... <javascript:;>
>

--001a11c3cb3443b18105285e6623
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as for my observation, people share password with coworkers, they will shar=
e cert in the same way :)<div><br></div><div>well, password-only is legitim=
ate setup, so I would add test case for it. maybe bit later.</div><div>wher=
e can I have a look at existing test cases you are talking about?<br><br>=
=D1=81=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 2 =D1=8F=D0=BD=D0=B2=D0=B0=D1=
=80=D1=8F 2016 =D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D0=B5=D0=BB=D1=8C Gert Doering  =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Sat, Jan 02, 2016 at 09:14:21PM +0300, ???????? ?????????????? wrote:<br>
&gt; also, does it make sence to perform unit testing on build like<br>
&gt;<br>
&gt; setup server with user/password auth on localhost, connect to is using=
<br>
&gt; client, see whether it is ok....<br>
<br>
We do, but we don&#39;t run test setups without certificates (my auth/pass<=
br>
users *also* have to have a certificate - helps against lost passwords,<br>
because you also need to steal key+cert)<br>
<br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"javas=
cript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;gert@...1296...&#39;)">g=
ert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"javascript:;" onclick=3D"_e(event, =
&#39;cvml&#39;, &#39;gert@...1297...&#39;)">gert@...1297...</a><br>
</blockquote></div>

--001a11c3cb3443b18105285e6623--

