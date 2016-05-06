References: <5729BA8F.4090602@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <572CC6FB.1040704@...515...>
Date: Fri, 6 May 2016 19:31:55 +0300
MIME-Version: 1.0
In-Reply-To: <5729BA8F.4090602@...515...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.3.10 Windows installers
 (I604/I003) released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net


> Hi all,
>
> New OpenVPN Windows installers have been released. The I003 and I604
> installers bundle OpenSSL 1.0.1t which fixes some security
> vulnerabilities. The I604 installers also bundle a new tap-windows6
> driver (9.21.2) which has dual authenticode signatures (SHA1/SHA2) for
> the best possible compatibility across Windows versions (Vista ->
> Windows 10). In addition, the 9.21.2 driver fixes a security
> vulnerability which, however, required local admin rights to be
> exploitable. OpenVPN-GUI has also seen minor changes.
>
> Best regards,
>

New Windows installers are now out for Windows XP:

<http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.10-I005=
-i686.exe>
<http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.10-I005=
-x86_64.exe>

They revert commit which caused the previous (I003) installer to bail=20
out immediately on Windows XP thinking that the user was trying to=20
install tap-windows6. Based on testing by a user on IRC these installers=20
should work correctly on Windows XP.

I will get into fixing the actual problem early next week at latest.=20
After proper testing I'll make yet another installer release.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1]=20
<https://github.com/OpenVPN/openvpn-build/commit/65e328c89182c47d1a93398e04=
ca92199bf17af3>

