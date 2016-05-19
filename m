References: <9D542DA272786745B160AD8534D3D3F641BCF060@...2140...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <573D5BEB.5080602@...515...>
Date: Thu, 19 May 2016 09:23:39 +0300
MIME-Version: 1.0
In-Reply-To: <9D542DA272786745B160AD8534D3D3F641BCF060@...2140...>
Subject: Re: [Openvpn-devel] New NDIS6 drivers in 2.3.11?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Kuhr Stefan <S.Kuhr@...2139...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello everyone,
>
> I have posted a question in the "Community Project Server Administration
> Installation Help" forum about the updated ndis6 drivers in openvpn
> 2.3.11 for windows. I was advised to subscribe to the developer mailing
> list and ask there again, so here goes my inquiry from
> https://forums.openvpn.net/viewtopic.php?f=3D5&t=3D21728:
>
> I noticed, that the NDIS6 drivers in the Windows Port of OpenVPN 2.3.11
> (released this week) have been silently updated without notice in the
> changelog, albeit with the same driver version. It seems to me like
> there is now another signature on the driver package using the sha256
> digest that has been created using an ev certificate. Is there anything
> else that has changed in the drivers except for the things I have
> observed? If there is no other change, what was the reasoning for the
> driver update? The older drivers from 2.3.10 have been timestamped way
> before the release of Windows 10, so the new requirement for ev
> certificates for drivers in windows 10 cannot be the reason, they will
> continue to run fine, because timestamping occurred before the ship date
> of windows 10. At least this is my understanding of the new ev cert
> enforcement in windows 10: If created before windows 10 rtm ship date,
> drivers will work.
>
> Any official comment from the openvpn dev team?

Hi,

We don't currently have official changelogs for the Windows=20
_installers_. The tap-windows6 driver package was not upgraded in=20
2.3.11, but in the latest 2.3.10 installers:

<https://forums.openvpn.net/viewtopic.php?f=3D20&t=3D21681>

Typically we make 1-5 Windows installer releases per OpenVPN version.=20
Usually we just upgrade OpenSSL to the latest version.

The answer to your question is in the above announcement:

"The [OpenVPN 2.3.10] I604 installers also bundle a new tap-windows6=20
driver (9.21.2) which has dual authenticode signatures (SHA1/SHA2) for=20
the best possible compatibility across Windows versions (Vista ->=20
Windows 10). In addition, the 9.21.2 driver fixes a security=20
vulnerability which, however, required local admin rights to be=20
exploitable. OpenVPN-GUI has also seen minor changes."

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

