From: Kuhr Stefan <S.Kuhr@...2139...>
Date: Thu, 19 May 2016 08:46:46 +0000
Message-ID: <9D542DA272786745B160AD8534D3D3F641BCF1CA@...2140...>
References: <9D542DA272786745B160AD8534D3D3F641BCF060@...2140...>
	<573D5BEB.5080602@...515...>
In-Reply-To: <573D5BEB.5080602@...515...>
Content-Language: de-DE
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] New NDIS6 drivers in 2.3.11?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Samuli, hello everyone,

thanks for the reply. I have never seen before a second openvpn release for=
 Windows with the same version number but different content, I would not ha=
ve expected this to happen. I had a 2.3.10 binary release for windows here,=
 that has an authenticode timestamp dating back to March 10 2016 and with i=
dentical ndis driver packages to 2.3.8 and I downloaded this on 5th of Apri=
l 2016. However, the forum post you mention is from May 4th 2016, way after=
 the 2.3.10 release. So it appeared to me that the new drivers came with 2.=
3.11, not 2.3.10. Obviously a new 2.3.10 package was released inbetween wit=
h the new driver version alongside, right? Naming this a bit different woul=
d probably avoided my confusion, something like 2.3.10a and 2.3.10b or the =
likes...

Also I was confused with the versioning scheme of the driver package: All I=
 saw was the file version of tap0901.sys. It is 9.0.0.21 in both versions. =
It is now that I noticed that the string file version and product version h=
ave changed. This is very unfortunate, for at least the following two reaso=
ns:=20

- you don't see a version change if you look at the Details property page f=
or the file in Explorer in order to inspect the file version.
- installer engines usually look at the numerical file version field which =
is the same in both versions. This could lead to problems if you repackage =
the driver in your own installer like we do.

My experience is: Update the numerical file version field for Windows PE fi=
les and you are all safe. YMMV.

Thanks for replying, all my questions have been answered.


i.A. Stefan Kuhr

Software-Entwicklungsingenieur=20

Hardware Entwicklung=20
Hardware Development

ads-tec GmbH
Heinrich-Hertz-Str. 1
72622 N=FCrtingen
Germany=20=20

Tel.:    +49 7022 2522-2427
Fax:    +49 7022 2522-405
E-Mail: s.kuhr@...2139...
Web:    www.ads-tec.de

-----Urspr=FCngliche Nachricht-----
Von: Samuli Sepp=E4nen [mailto:samuli@...515...]=20
Gesendet: Donnerstag, 19. Mai 2016 08:24
An: Kuhr Stefan; openvpn-devel@lists.sourceforge.net
Betreff: Re: [Openvpn-devel] New NDIS6 drivers in 2.3.11?


> Hello everyone,
>
> I have posted a question in the "Community Project Server=20
> Administration Installation Help" forum about the updated ndis6=20
> drivers in openvpn
> 2.3.11 for windows. I was advised to subscribe to the developer=20
> mailing list and ask there again, so here goes my inquiry from
> https://forums.openvpn.net/viewtopic.php?f=3D5&t=3D21728:
>
> I noticed, that the NDIS6 drivers in the Windows Port of OpenVPN=20
> 2.3.11 (released this week) have been silently updated without notice=20
> in the changelog, albeit with the same driver version. It seems to me=20
> like there is now another signature on the driver package using the=20
> sha256 digest that has been created using an ev certificate. Is there=20
> anything else that has changed in the drivers except for the things I=20
> have observed? If there is no other change, what was the reasoning for=20
> the driver update? The older drivers from 2.3.10 have been timestamped=20
> way before the release of Windows 10, so the new requirement for ev=20
> certificates for drivers in windows 10 cannot be the reason, they will=20
> continue to run fine, because timestamping occurred before the ship=20
> date of windows 10. At least this is my understanding of the new ev=20
> cert enforcement in windows 10: If created before windows 10 rtm ship=20
> date, drivers will work.
>
> Any official comment from the openvpn dev team?

Hi,

We don't currently have official changelogs for the Windows _installers_. T=
he tap-windows6 driver package was not upgraded in 2.3.11, but in the lates=
t 2.3.10 installers:

<https://forums.openvpn.net/viewtopic.php?f=3D20&t=3D21681>

Typically we make 1-5 Windows installer releases per OpenVPN version.=20
Usually we just upgrade OpenSSL to the latest version.

The answer to your question is in the above announcement:

"The [OpenVPN 2.3.10] I604 installers also bundle a new tap-windows6 driver=
 (9.21.2) which has dual authenticode signatures (SHA1/SHA2) for the best p=
ossible compatibility across Windows versions (Vista -> Windows 10). In add=
ition, the 9.21.2 driver fixes a security vulnerability which, however, req=
uired local admin rights to be exploitable. OpenVPN-GUI has also seen minor=
 changes."

Best regards,

--
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
_______________________________________________
ads-tec GmbH
Sitz: 72622 N=FCrtingen
Registergericht Stuttgart HRB 224527

Geschaeftsfuehrer:
Dipl.-Ing. Thomas Speidel
_______________________________________________
Diese E-Mail enthaelt vertrauliche und/oder rechtlich
geschuetzte Informationen. Wenn Sie nicht der richtige
Adressat sind oder diese E-Mail irrtuemlich erhalten
haben, informieren Sie bitte sofort den Absender und=20
vernichten Sie diese E-Mail. Das unerlaubte Kopieren,
jegliche anderweitige Verwendung sowie die unbefugte
Weitergabe dieser Mail sind nicht gestattet.
_______________________________________________

This e-mail may contain confidential and/or privileged
information. If you are not the intended recipient (or have
received this e-mail in error) please notify the sender
immediately and destroy this e-mail. Any unauthorized
copying, disclosure, distribution or other use of the
material or parts thereof are strictly forbidden.
_______________________________________________


