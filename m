MIME-Version: 1.0
In-Reply-To: <CAFHpkQFMA3ppTm=wCH-MrBox7niCC5+YWNbkvmkK3Y5p7Cu7Og@...278...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<C936B414-2E25-45B2-89B9-61805EE6F78F@...277...>
	<CAFHpkQFMA3ppTm=wCH-MrBox7niCC5+YWNbkvmkK3Y5p7Cu7Og@...278...>
From: Marvin <volleynbike@...277...>
Date: Fri, 25 Nov 2016 10:51:59 -0800
Message-ID: <CAAF3xa81KwiMTYBSK66WoUzrr2SmsUkemx4jnq4A3H6iArFzbQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0b9520f0b9aa0542249d24
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0b9520f0b9aa0542249d24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, as long as we can specify any switches from the new installer itself.
For instance, this is the cli we use for programatically (script)
installing/updating:
"...\openvpn-install-2.xxx /S /SELECT_SHORTCUTS=3D0 /SELECT_OPENVPNGUI=3D0"

I imagine there will be more switches required with the 2.4+ installer.

On Fri, Nov 25, 2016 at 5:19 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
>
> 2016-11-22 0:56 GMT+05:00 Marvin Adeff <volleynbike@...277...>:
>
>> Hi,
>>
>> Power User Perspective:
>> Please ensure that these [X] selections can be controlled (as in
>> "disabled") if openvpn is installed by command line (quiet mode).
>>
>
> when installing in silent mode, you can specify any switches, is it ok ?
> those settings can be controlled.
>

--94eb2c0b9520f0b9aa0542249d24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, as long as we can specify any switches from the new i=
nstaller itself.=C2=A0 For instance, this is the cli we use for programatic=
ally (script) installing/updating:<div>&quot;...\openvpn-install-2.xxx /S /=
SELECT_SHORTCUTS=3D0 /SELECT_OPENVPNGUI=3D0&quot;</div><div><br></div><div>=
I imagine there will be more switches required with the 2.4+ installer.<br>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Nov 25, 2=
016 at 5:19 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." tar=
get=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote"><span class=3D"gmail-">2016-11-22 0=
:56 GMT+05:00 Marvin Adeff <span dir=3D"ltr">&lt;<a href=3D"mailto:volleynb=
ike@...277..." target=3D"_blank">volleynbike@...277...</a>&gt;</span>:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Power User Perspective:<br>
Please ensure that these [X] selections can be controlled (as in &quot;disa=
bled&quot;) if openvpn is installed by command line (quiet mode).<br></bloc=
kquote><div><br></div></span><div>when installing in silent mode, you can s=
pecify any switches, is it ok ?<br></div><div>those settings can be control=
led.</div></div></div></div></blockquote></div></div></div></div>

--94eb2c0b9520f0b9aa0542249d24--

