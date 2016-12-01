References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
Date: Thu, 1 Dec 2016 13:40:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
Subject: Re: [Openvpn-devel] combined ndis5 + ndis6 installer ?
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Il 30/11/2016 11:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>
>         (and, yes, I'm going to build multi-language installer, probably
>         right
>         after 2.4 release)
>
>
>     This makes sense. Any plans on how you're going to do it?
>
>
>
> as we do not support windows 2000 anymore, we can easily switch to unicod=
e.
> there are few questions
>
> 1) unicode nsis under linux (we use windows+mingw+nsis unicode, so, I'm
> not sure about linux)
>

Unicode seems to be present in Linux NSIS versions, according to this:

<http://stackoverflow.com/questions/19201702/nsis-unicode-build-for-linux>

The build computers need to be updated to a quite recent NSIS version,=20
though.


> 2) split installer into several language files (as done for openvpn-gui)

We'd also need to detect the language the user is using to select the=20
correct one. I personally don't like manual language selector as they=20
add one more step to the install process.

>
> 3) test everything
>
>
> it is not difficult, but it is time consuming, I'm afraid we will test
> it properly before 2.4

The plan is to release 2.5 pretty quickly after 2.4. Also, installer=20
changes do not necessarily need to go in sync with OpenVPN releases.

>
>     Another internationalization aspect we could improve is how we store
>     translations for OpenVPN-GUI. Editing the resource files directly is
>     clumsy and error-prone, as the files contain lots of "stuff" that is
>     not meant to be translated. A simple key-value file would be much
>     easier, although in OpenVPN-GUI's case the hardcoded window sizes
>     make this more complex.
>
>
> it makes sense to convert openvpn-gui resources into visual studio format.
> @selvanair some times ago told something like that.

Hmm, interesting, will need to look into it. Any format that could be=20
loaded by a translation memory application is better than what we have=20
now. Simple key-value resource files are also easy to convert into other=20
similar formats, if necessary.

> as for the rest, separate resources are just fine.
>
>
>
>     Also I'm not sure how easy it would be to separate the translatable
>     strings into a separate file. I would guess that the actual .res
>     files could be generated on the fly from a template and the
>     key-value file by the build scripts.
>
>
> it looks overcomplicated. some kind of "post build operation" which will
> identifies missing language resources would be nice however

Yeah, it could be hairy. Let's look into this in depth later.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

