References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
Date: Wed, 30 Nov 2016 11:36:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
Subject: Re: [Openvpn-devel] combined ndis5 + ndis6 installer ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 30/11/2016 09:53, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> Hello,
>
> as we finished x86 + x64 installer, we can do something else now.
> @mattock, which installer are you going to build ?
>
> it used to be (ndis5, ndis6) x (x86, x64) matrix, what will be future
> matrix ?

As discussed earlier bloating the (2.4) installers with NDIS5 drivers is=20
not worth it. NDIS5 driver is only aimed for Windows XP, and we have=20
dropped XP support in OpenVPN 2.4 already. Also, OpenvPN 2.3 will see=20
fewer and fewer fixes as 2.4.x releases stabilize. Eventually 2.3 will=20
go into "high severity security fixes only"-mode, like 2.2 did several=20
years ago.

So let's not beat the dead horse (NDIS5) anymore :).

>
> (and, yes, I'm going to build multi-language installer, probably right
> after 2.4 release)

This makes sense. Any plans on how you're going to do it?

Another internationalization aspect we could improve is how we store=20
translations for OpenVPN-GUI. Editing the resource files directly is=20
clumsy and error-prone, as the files contain lots of "stuff" that is not=20
meant to be translated. A simple key-value file would be much easier,=20
although in OpenVPN-GUI's case the hardcoded window sizes make this more=20
complex.

Also I'm not sure how easy it would be to separate the translatable=20
strings into a separate file. I would guess that the actual .res files=20
could be generated on the fly from a template and the key-value file by=20
the build scripts.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

