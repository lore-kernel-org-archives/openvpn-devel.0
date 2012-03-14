MIME-Version: 1.0
In-Reply-To: <4F60903E.9090506@...515...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
	<CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
	<4F4E6104.2000900@...1114...>
	<CAOazyz3fg_qSWb92ftSeq3Z7qN1fhfEBnuURfxenOsBbxGWQ4g@...278...>
	<CAOazyz1=87RqYEo=ovMtGkc1n=yh5VOQcc_YdM4nMHbQ8oNTNA@...278...>
	<CAOazyz2Svm8sG3kZMiMzH2hppNpRkQn2a_8NK9sGM0o9qCJKzg@...278...>
	<4F5720D3.7060309@...515...>
	<CAOazyz0Qopk1b8VRSobuui8QBZ3GNr5zbu4moa4abJZWyzaQWQ@...278...>
	<4F606088.8030607@...1114...>
	<CAOazyz2ZrDL-kaFa+Nc-aDcyWgOVJd82scypg9vZsZghvsY7Wg@...278...>
	<4F60903E.9090506@...515...>
Date: Wed, 14 Mar 2012 14:37:19 +0200
Message-ID: <CAOazyz3hA9LPCq0sEOWbY30PwjwxPUyCkDFWWq9x4S3dxfYVXw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Thanks.

In the mean time I upgraded the VC support for 2010 (and above? hopefully).

Athanasios, you may try again.

Alon.

2012/3/14 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Il 14.03.2012 11:13, Alon Bar-Lev ha scritto:
> > On Wed, Mar 14, 2012 at 11:10 AM, David Sommerseth
> > <openvpn.list@...1114...> wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> On 14/03/12 09:33, Alon Bar-Lev wrote:
> >>> As the mingw build is the formal build, there is no reason to keep
> >>> supporting old visual studio configurations.
> >> That's debatable. =C2=A0James Yonan is using MSVC for the OpenVPN AS c=
lient,
> >> and has indicated that he wanted that. =C2=A0I don't know much more th=
an
> >> this,
> >> but it might be related to his concerns about the old mingw32 tool
> >> chain
> >> not being too well maintained. =C2=A0I know that's not an issue with t=
he
> >> mingw64 stuff.
> >>
> >> However, currently the official tool chain is MSVC for Windows builds.
> >> All other platforms uses the autotools toolchain. =C2=A0We can surely
> >> discuss
> >> if this is the right discussion, but that's a discussion where James
> >> will
> >> have the final word.
> >>
> >> - From my perspective, the less toolchains we need to care about, the
> >> better. =C2=A0But we are not in a position where we can overrule James'
> >> decisions, especially not without involving him in the discussion.
> > So please involve.
> > Again, I did not wrote to remove MSVC, just to support 2010 and above.
> >
> > Alon.
> I'll try to involve him in this week's or next week's IRC meeting :).
>
> Personally, I got the feeling that the Python-based MSVC buildsystem he
> started writing (and which I finished) was a reaction to the general
> crappiness of OpenVPN Windows buildsystem(s). And that should not be an
> argument after the new "generic" buildsystem is merged.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

