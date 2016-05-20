References: <9D542DA272786745B160AD8534D3D3F641BCF060@...2140...>
	<573D5BEB.5080602@...515...>
	<9D542DA272786745B160AD8534D3D3F641BCF1CA@...2140...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <573ED081.5050008@...515...>
Date: Fri, 20 May 2016 11:53:21 +0300
MIME-Version: 1.0
In-Reply-To: <9D542DA272786745B160AD8534D3D3F641BCF1CA@...2140...>
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


> Hello Samuli, hello everyone,
>
> thanks for the reply. I have never seen before a second openvpn release f=
or Windows with the same version number but different content, I would not =
have expected this to happen. I had a 2.3.10 binary release for windows her=
e, that has an authenticode timestamp dating back to March 10 2016 and with=
 identical ndis driver packages to 2.3.8 and I downloaded this on 5th of Ap=
ril 2016. However, the forum post you mention is from May 4th 2016, way aft=
er the 2.3.10 release. So it appeared to me that the new drivers came with =
2.3.11, not 2.3.10. Obviously a new 2.3.10 package was released inbetween w=
ith the new driver version alongside, right? Naming this a bit different wo=
uld probably avoided my confusion, something like 2.3.10a and 2.3.10b or th=
e likes...

That is why we have the installer number after the version number:

openvpn-install-2.3.11-I601-*
openvpn-install-2.3.11-I602-*
openvpn-install-2.3.11-I603-*

...and so on.

The changes in the installer bundle may consist of

- Installer fixes
- OpenVPN-GUI fixes
- OpenSSL fixes
- Tap-windows6 fixes

Core OpenVPN code in each of the above bundles would always the same.=20
When a new OpenVPN release is made, the bundle numbering starts all over=20
again from I601.

The I00x bundles bundle the older tap-windows driver, which we can get=20
rid of when we drop Windows XP support. More on tap-windows/tap-windows6=20
below. We _could_ probably make installer version numbers easier to=20
understand without breaking the buildsystem. For example:

XP-I001
Vista-I001

This would probably make sense because after dropping XP support we=20
could not easily revert back from I60x to I00x for the tap-windows6=20
installers without some people shouting at us "where have the Vista+=20
binaries gone?!?"

> Also I was confused with the versioning scheme of the driver package: All=
 I saw was the file version of tap0901.sys. It is 9.0.0.21 in both versions=
. It is now that I noticed that the string file version and product version=
 have changed. This is very unfortunate, for at least the following two rea=
sons:

Indeed. The version numbering scheme is what it is for historical=20
reasons, not because it necessarily makes sense. That said, the file=20
name/version is set to tap0901 because that's hardcoded to OpenVPN=20
itself in version.m4:

     define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])

As long as we keep supporting Windows XP we really can't change that, as=20
we have two different tap-drivers:

- tap-windows (uses NDIS 5, works on Windows XP -> Windows 8.1)
- tap-windows6 (uses NDIS 6, works on Windows Vista and up)

If we were to change the hardcoded TAP_WIN_COMPONENT_ID, we'd also need=20
to build two different OpenVPN versions, each with different hardcoded=20
value. This does not make much sense, as there is really no dependency=20
between the OpenVPN version and the tap-windows[6] driver version,=20
except this hardcoded string.

In addition, if we updated tap0901 every time we modified tap-windows6,=20
we'd marry the driver a specific build of OpenVPN and end up with=20
several incompatible OpenVPN/tap-windows6 versions. Stripping away the=20
version number entirely would be a better strategy in my opinion, e.g.=20
tap0901 -> tap6. This change has already been done in OpenVPN Connect,=20
which uses "tapoas".

> - you don't see a version change if you look at the Details property page=
 for the file in Explorer in order to inspect the file version.
> - installer engines usually look at the numerical file version field whic=
h is the same in both versions. This could lead to problems if you repackag=
e the driver in your own installer like we do.

Yep. We update the four-digit numerical field on every new tap-windows6=20
release. The numbering scheme could probably be improved, as can be seen=20
from version.m4 in tap-windows6:

     define([PRODUCT_VERSION], [9.21.2])
     define([PRODUCT_VERSION_RESOURCE], [9,0,0,21])
     define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
     define([PRODUCT_TAP_WIN_MAJOR], [9])
     define([PRODUCT_TAP_WIN_MINOR], [21])

Without doing some research I'm not entirely sure where all those values=20
get used. The PRODUCT_VERSION_RESOURCE ends up as the four-digit version=20
in File properties and PRODUCT_VERSION as part of the installer name. We=20
can't change the "21" in PRODUCT_VERSION_RESOURCE without making it=20
inconsistent with PRODUCT_VERSION.

I assume PRODUCT_VERSION_RESOURCE should follow this scheme:

<https://en.wikipedia.org/wiki/Microsoft_version_numbering>

...which looks like this:

<PRIMARY>.<SECONDARY>.<BUILD>.<AUXILIARY>

So probably something like this would be more reasonable:

     define([PRODUCT_VERSION], [9.21.2])
     define([PRODUCT_VERSION_RESOURCE], [9,21,2,0])
     define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap6])
     define([PRODUCT_TAP_WIN_MAJOR], [9])
     define([PRODUCT_TAP_WIN_MINOR], [21])

On every tap-windows6 release we'd update PRODUCT_VERSION and=20
PRODUCT_VERSION_RESOURCE.

Thoughts?

> My experience is: Update the numerical file version field for Windows PE =
files and you are all safe. YMMV.

Can you elaborate which PE files you mean exactly?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

>
> Thanks for replying, all my questions have been answered.
>
>
> i.A. Stefan Kuhr
>
> Software-Entwicklungsingenieur
>
> Hardware Entwicklung
> Hardware Development
>
> ads-tec GmbH
> Heinrich-Hertz-Str. 1
> 72622 N=FCrtingen
> Germany
>
> Tel.:    +49 7022 2522-2427
> Fax:    +49 7022 2522-405
> E-Mail: s.kuhr@...2139...
> Web:    www.ads-tec.de
>
> -----Urspr=FCngliche Nachricht-----
> Von: Samuli Sepp=E4nen [mailto:samuli@...515...]
> Gesendet: Donnerstag, 19. Mai 2016 08:24
> An: Kuhr Stefan; openvpn-devel@lists.sourceforge.net
> Betreff: Re: [Openvpn-devel] New NDIS6 drivers in 2.3.11?
>
>
>> Hello everyone,
>>
>> I have posted a question in the "Community Project Server
>> Administration Installation Help" forum about the updated ndis6
>> drivers in openvpn
>> 2.3.11 for windows. I was advised to subscribe to the developer
>> mailing list and ask there again, so here goes my inquiry from
>> https://forums.openvpn.net/viewtopic.php?f=3D5&t=3D21728:
>>
>> I noticed, that the NDIS6 drivers in the Windows Port of OpenVPN
>> 2.3.11 (released this week) have been silently updated without notice
>> in the changelog, albeit with the same driver version. It seems to me
>> like there is now another signature on the driver package using the
>> sha256 digest that has been created using an ev certificate. Is there
>> anything else that has changed in the drivers except for the things I
>> have observed? If there is no other change, what was the reasoning for
>> the driver update? The older drivers from 2.3.10 have been timestamped
>> way before the release of Windows 10, so the new requirement for ev
>> certificates for drivers in windows 10 cannot be the reason, they will
>> continue to run fine, because timestamping occurred before the ship
>> date of windows 10. At least this is my understanding of the new ev
>> cert enforcement in windows 10: If created before windows 10 rtm ship
>> date, drivers will work.
>>
>> Any official comment from the openvpn dev team?
>
> Hi,
>
> We don't currently have official changelogs for the Windows _installers_.=
 The tap-windows6 driver package was not upgraded in 2.3.11, but in the lat=
est 2.3.10 installers:
>
> <https://forums.openvpn.net/viewtopic.php?f=3D20&t=3D21681>
>
> Typically we make 1-5 Windows installer releases per OpenVPN version.
> Usually we just upgrade OpenSSL to the latest version.
>
> The answer to your question is in the above announcement:
>
> "The [OpenVPN 2.3.10] I604 installers also bundle a new tap-windows6 driv=
er (9.21.2) which has dual authenticode signatures (SHA1/SHA2) for the best=
 possible compatibility across Windows versions (Vista -> Windows 10). In a=
ddition, the 9.21.2 driver fixes a security vulnerability which, however, r=
equired local admin rights to be exploitable. OpenVPN-GUI has also seen min=
or changes."
>
> Best regards,
>
> --
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
> _______________________________________________
> ads-tec GmbH
> Sitz: 72622 N=FCrtingen
> Registergericht Stuttgart HRB 224527
>
> Geschaeftsfuehrer:
> Dipl.-Ing. Thomas Speidel
> _______________________________________________
> Diese E-Mail enthaelt vertrauliche und/oder rechtlich
> geschuetzte Informationen. Wenn Sie nicht der richtige
> Adressat sind oder diese E-Mail irrtuemlich erhalten
> haben, informieren Sie bitte sofort den Absender und
> vernichten Sie diese E-Mail. Das unerlaubte Kopieren,
> jegliche anderweitige Verwendung sowie die unbefugte
> Weitergabe dieser Mail sind nicht gestattet.
> _______________________________________________
>
> This e-mail may contain confidential and/or privileged
> information. If you are not the intended recipient (or have
> received this e-mail in error) please notify the sender
> immediately and destroy this e-mail. Any unauthorized
> copying, disclosure, distribution or other use of the
> material or parts thereof are strictly forbidden.
> _______________________________________________
>



