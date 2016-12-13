MIME-Version: 1.0
In-Reply-To: <58af87c9-8b62-13cb-dfea-5642ab36c97f@...2080...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
	<CAKuzo_i2ED_oND-HJw9jVrxOAJ5cOv2_056YjkuXPX5g9w8G5Q@...278...>
	<75c5efa8-346f-f2ca-57bd-4b3e38364a27@...1856...>
	<58af87c9-8b62-13cb-dfea-5642ab36c97f@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Dec 2016 16:03:15 -0500
Message-ID: <CAKuzo_hESW2B74FMt2E5V530Z1W7zFTo2TJsQHwu7_y-zONGoA@...278...>
Content-Type: multipart/alternative; boundary=001a114349c2c445fa0543908d51
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114349c2c445fa0543908d51
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 13, 2016 at 3:59 PM, David Sommerseth <
openvpn@...2080...> wrote:

> If it breaks a boolean expression over more lines, the operator comes as
>  the lead character on the following line
>
>     i = TEST1
>        | TEST2
>        | TEST3
>
> instead of
>
>     i = TEST1 |
>         TEST2 |
>         TEST3
>

That is already handled by pos_arith=Lead. This pos_bool handles boolean
operators like && and ||

:)

Selva

--001a114349c2c445fa0543908d51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 13, 2016 at 3:59 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...<wbr=
>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_=
-4294770326044905324m_8062382745329227087:9v1" class=3D"m_-4294770326044905=
324m_8062382745329227087a3s m_-4294770326044905324m_8062382745329227087aXjC=
H m_-4294770326044905324m_8062382745329227087m158f9fba668fb28c">If it break=
s a boolean expression over more lines, the operator comes as<br>
=C2=A0the lead character on the following line<br>
<br>
=C2=A0 =C2=A0 i =3D TEST1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| TEST2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| TEST3<br>
<br>
instead of<br>
<br>
=C2=A0 =C2=A0 i =3D TEST1 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST2 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST3<div class=3D"m_-4294770326044905324m_8062=
382745329227087yj6qo m_-4294770326044905324m_8062382745329227087ajU"><div i=
d=3D"m_-4294770326044905324m_8062382745329227087:6qu" class=3D"m_-429477032=
6044905324m_8062382745329227087ajR"></div></div></div></blockquote></div><b=
r>That is already handled by pos_arith=3DLead. This pos_bool handles boolea=
n operators like &amp;&amp; and ||</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">:)</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">Selva</div></div>

--001a114349c2c445fa0543908d51--

