MIME-Version: 1.0
In-Reply-To: <efc2a91b-9b69-484a-c1d9-576d0ab30931@...515...>
References: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
	<f1b1c4ec-989b-67ef-2c97-006bee3bea0b@...277...>
	<efc2a91b-9b69-484a-c1d9-576d0ab30931@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Jan 2017 11:42:23 -0500
Message-ID: <CAKuzo_jh4cxwwv+ENDU1C1ED83hjnCHTEJuv9BHO0w5TYLTTeg@...278...>
Content-Type: multipart/alternative; boundary=001a113eea5acd504305468956c2
Subject: Re: [Openvpn-devel] ASLR/DEP -enabled 2.4.0 Windows installer
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113eea5acd504305468956c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 9:43 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> > Task manager shows DEP enabled while Windows is configured for
> > DEP on Windows processes only but the machine has Hardware enabled DEP
> > and shows DEP for 2.4.0-i601 as well . so not a very good test.
> >
> > I don't have a 32bit windows compatible with 2.4
> >
> > Regards.
>
> Thanks for testing! I think we just have to merge the ASLR/DEP change in
> openvpn-build and see what happens.
>

For ASLR we may have to add some option to get reloc information into the
exe? As per discussion under GUI PR 123 (
https://github.com/OpenVPN/openvpn-gui/pull/123) mingw does not do this by
default. There --export-all-symbols is used, which I think is a terrible
hack.

Checking aslr is enabled or not using process explorer may help -- openssl
dll has to be checked too.

Selva

--001a113eea5acd504305468956c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jan 20, 2017 at 9:43 AM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt=
;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D"gmail-:26u" class=3D"gmai=
l-a3s gmail-aXjCH gmail-m159bc569f05e9b12">&gt; Task manager shows DEP enab=
led while Windows is configured for<br>
&gt; DEP on Windows processes only but the machine has Hardware enabled DEP=
<br>
&gt; and shows DEP for 2.4.0-i601 as well . so not a very good test.<br>
&gt;<br>
&gt; I don&#39;t have a 32bit windows compatible with 2.4<br>
&gt;<br>
&gt; Regards.<br>
<br>
Thanks for testing! I think we just have to merge the ASLR/DEP change in<br>
openvpn-build and see what happens.</div></blockquote></div><div class=3D"g=
mail_extra"><br></div>For ASLR we may have to add some option to get reloc =
information into the exe? As per discussion under GUI PR 123 (<a href=3D"ht=
tps://github.com/OpenVPN/openvpn-gui/pull/123">https://github.com/OpenVPN/o=
penvpn-gui/pull/123</a>) mingw does not do this by default. There --export-=
all-symbols is used, which I think is a terrible hack.=C2=A0</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Checking aslr is ena=
bled or not using process explorer may help -- openssl dll has to be checke=
d too.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>Selva</div></div>

--001a113eea5acd504305468956c2--

