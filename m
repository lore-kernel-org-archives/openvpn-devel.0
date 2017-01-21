MIME-Version: 1.0
In-Reply-To: <CAKuzo_jh4cxwwv+ENDU1C1ED83hjnCHTEJuv9BHO0w5TYLTTeg@...278...>
References: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
	<f1b1c4ec-989b-67ef-2c97-006bee3bea0b@...277...>
	<efc2a91b-9b69-484a-c1d9-576d0ab30931@...515...>
	<CAKuzo_jh4cxwwv+ENDU1C1ED83hjnCHTEJuv9BHO0w5TYLTTeg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Jan 2017 22:11:13 -0500
Message-ID: <CAKuzo_hVK4zoTokCM4=vWW_4D4xSmfDJ7em=XL_qVoynjR=q2A@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05a07ab0188d0546921fb6
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

--94eb2c05a07ab0188d0546921fb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
On Fri, Jan 20, 2017 at 11:42 AM, Selva Nair <selva.nair@...277...> wrote:

> On Fri, Jan 20, 2017 at 9:43 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
>> wrote:
>> Thanks for testing! I think we just have to merge the ASLR/DEP change in
>> openvpn-build and see what happens.
>>
>
> For ASLR we may have to add some option to get reloc information into the
> exe? As per discussion under GUI PR 123 (https://github.com/OpenVPN/
> openvpn-gui/pull/123) mingw does not do this by default. There
> --export-all-symbols is used, which I think is a terrible hack.
>
> Checking aslr is enabled or not using process explorer may help -- openssl
> dll has to be checked too.
>

Checked this on win7. Process explorer shows ASLR flag is set on the
executable. But ASLR is not really active. The GUI is loaded at the same
address each time (as per vmmap from sysinternals). I see no address
randomization.

Recompiling by exporting at least one function fixes this so the linker is
indeed not adding reloc section to the exe otherwise.

The build option does make ASLR work for openssl dll so the only thing
missing there was the flag in the header. Not so for the executables.

We need to find some fix for this, else I fear this will be ASLR in name
only.

Selva

--94eb2c05a07ab0188d0546921fb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div class=3D"gmail_quote">Hi,<br>On Fri, J=
an 20, 2017 at 11:42 AM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mailto=
:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D=
"gmail_extra"><span class=3D"gmail-"><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div id=3D"gmail-m_31338153612211540=
9gmail-:26u" class=3D"gmail-m_313381536122115409gmail-a3s gmail-m_313381536=
122115409gmail-aXjCH gmail-m_313381536122115409gmail-m159bc569f05e9b12"><sp=
an class=3D"gmail-im">On Fri, Jan 20, 2017 at 9:43 AM, Samuli Sepp=C3=A4nen=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank=
">samuli@...515...</a>&gt;</span> wrote:</span><br>
Thanks for testing! I think we just have to merge the ASLR/DEP change in<br>
openvpn-build and see what happens.</div></blockquote></div><div class=3D"g=
mail_extra"><br></div></span>For ASLR we may have to add some option to get=
 reloc information into the exe? As per discussion under GUI PR 123 (<a hre=
f=3D"https://github.com/OpenVPN/openvpn-gui/pull/123" target=3D"_blank">htt=
ps://github.com/OpenVPN/<wbr>openvpn-gui/pull/123</a>) mingw does not do th=
is by default. There --export-all-symbols is used, which I think is a terri=
ble hack.=C2=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra">Checking aslr is enabled or not using process explorer may help -=
- openssl dll has to be checked too.</div></blockquote></div><div class=3D"=
gmail_extra"><br></div>Checked this on win7. Process explorer shows ASLR fl=
ag is set on the executable. But ASLR is not really active. The GUI is load=
ed at the same address each time (as per vmmap from sysinternals). I see no=
 address randomization. <br><br>Recompiling by exporting at least one funct=
ion fixes this so the linker is indeed not adding reloc section to the exe =
otherwise. <br><br></div><div>The build option does make ASLR work for open=
ssl dll so the only thing missing there was the flag in the header. Not so =
for the executables.<br>=C2=A0<br></div>We need to find some fix for this, =
else I fear this will be ASLR in name only.<br><br></div>Selva<br></div></d=
iv>

--94eb2c05a07ab0188d0546921fb6--

