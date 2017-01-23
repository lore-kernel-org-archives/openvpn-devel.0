References: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
	<f1b1c4ec-989b-67ef-2c97-006bee3bea0b@...277...>
	<efc2a91b-9b69-484a-c1d9-576d0ab30931@...515...>
	<CAKuzo_jh4cxwwv+ENDU1C1ED83hjnCHTEJuv9BHO0w5TYLTTeg@...278...>
	<CAKuzo_hVK4zoTokCM4=vWW_4D4xSmfDJ7em=XL_qVoynjR=q2A@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7a5e68c0-0eba-4306-d95b-c857d7a69e14@...515...>
Date: Mon, 23 Jan 2017 11:55:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hVK4zoTokCM4=vWW_4D4xSmfDJ7em=XL_qVoynjR=q2A@...278...>
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
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 21/01/2017 05:11, Selva Nair ha scritto:
> Hi,
> On Fri, Jan 20, 2017 at 11:42 AM, Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
>
>         On Fri, Jan 20, 2017 at 9:43 AM, Samuli Sepp=C3=A4nen
>         <samuli@...515... <mailto:samuli@...515...>> wrote:
>         Thanks for testing! I think we just have to merge the ASLR/DEP
>         change in
>         openvpn-build and see what happens.
>
>
>     For ASLR we may have to add some option to get reloc information
>     into the exe? As per discussion under GUI PR 123
>     (https://github.com/OpenVPN/openvpn-gui/pull/123
>     <https://github.com/OpenVPN/openvpn-gui/pull/123>) mingw does not do
>     this by default. There --export-all-symbols is used, which I think
>     is a terrible hack.
>
>     Checking aslr is enabled or not using process explorer may help --
>     openssl dll has to be checked too.
>
>
> Checked this on win7. Process explorer shows ASLR flag is set on the
> executable. But ASLR is not really active. The GUI is loaded at the same
> address each time (as per vmmap from sysinternals). I see no address
> randomization.
>
> Recompiling by exporting at least one function fixes this so the linker
> is indeed not adding reloc section to the exe otherwise.
>
> The build option does make ASLR work for openssl dll so the only thing
> missing there was the flag in the header. Not so for the executables.
>
> We need to find some fix for this, else I fear this will be ASLR in name
> only.
>
> Selva

So we need a small code change in OpenVPN to get ASLR actually working,=20
like in OpenVPN GUI?

<https://github.com/OpenVPN/openvpn-gui/pull/123/>

In particular something like this:

<https://github.com/OpenVPN/openvpn-gui/pull/123/files#diff-2045016cb90d1e6=
5d71c2407a2570927R72>

Correct?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

