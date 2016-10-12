References: <3572b3e5-8830-3418-87d7-725d611bb04a@...515...>
	<1184387968.3914907.1476271754068@...2084...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <63fb8930-367f-46df-abbe-fdcc08c70608@...515...>
Date: Wed, 12 Oct 2016 16:08:15 +0300
MIME-Version: 1.0
In-Reply-To: <1184387968.3914907.1476271754068@...2084...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Help testing OpenVPN 2.4-alpha1
 preview installers?
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
To: "Jose Alf." <josealf@...1237...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi Jose,

Thanks for testing! The documentation about the new services is probably=20
suboptimal right now. I will need to improve it a bit, because I believe=20
what is said here

<https://github.com/OpenVPN/openvpn-gui>

is all we have right now. Quickly summarizing:

1) OpenVPNService (provided by openvpnserv2.exe)

This is a new background service based on openvpnserv2. It is intended=20
for running one or more VPN connections in the background without user=20
interaction.

2) OpenVPNServiceInteractive (provided by openvpnserv.exe)

This service co-operates with OpenVPN-GUI to allow unprivileged users to=20
successfully launch VPN connection.

3) OpenVPNServiceLegacy (provided by openvpnserv.exe)

This is the old background service. It does not work well on anything=20
post-Windows 7 and is pretty crude in general. It is intended for=20
running one or more VPN connections in the background without user=20
interaction.

I will add this documentation somewhere - probably INSTALL-win32.txt.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


Il 12/10/2016 14:29, Jose Alf. ha scritto:
> Samuli,
>
> I tested the 64 bit installer on Windows 7 Enterprise using default
> settings. It ran smoothly. I notice that now there are 3 services -
> OpenVPN Interactive Service (appears started automatic)
> - OpenVPN Legacy Service (manual)
> - OpenVPNService (manual)
>
> Any pointers to documentation about this?
>
> I use OpenVPN-MI-GUI. I had to start OpenVPNService to connect to my
> server. Other than that, it worked fine.
>
> Regards,
> Jose
>
> ------------------------------------------------------------------------
> *From:* Samuli Sepp=C3=A4nen <samuli@...515...>
> *To:* "openvpn-devel@lists.sourceforge.net"
> <openvpn-devel@lists.sourceforge.net>;
> "openvpn-users@lists.sourceforge.net" <openvpn-users@...475...=
t>
> *Sent:* Tuesday, October 11, 2016 5:36 AM
> *Subject:* [Openvpn-users] Help testing OpenVPN 2.4-alpha1 preview
> installers?
>
> Hi all,
>
> We're really close to OpenVPN 2.4-alpha1 release now. In yesterday's IRC
> meeting[1] we deemed that "late this week" might be doable.
>
> However, we'd need to help with testing these preview installers:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-i686.exe>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifcon=
fig-after-tun-v2-I601-x86_64.exe>
>
> Note that the installers contain a much improved OpenVPN-GUI that
> behaves differently under the hood from the one bundled in OpenVPN 2.3.x:
>
> <https://github.com/OpenVPN/openvpn-gui>
>
> The installer also contains a new, much improved Windows system service
> called openvpnserv2:
>
> <https://github.com/OpenVPN/openvpnserv2>
>
> Based on earlier tests openvpnserv2 should be able to handle
> suspend/resume gracefully. It should also automatically restart a
> connection that dies for whatever reason.
>
> So far the installers linked to above have passed some basic tests:
>
> <https://community.openvpn.net/openvpn/wiki/OpenVPN24WindowsTests>
>
> If you can, please test the installers in your environment and let us
> know how it went: we'd like to minimize the chance of breaking existing
> setups before we make the official 2.4-alpha1 release.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> [1]
> <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1265=
7.html>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> <mailto:Openvpn-users@lists.sourceforge.net>
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>


