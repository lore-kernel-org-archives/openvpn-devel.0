References: <56E185E9.60506@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56E67899.904@...515...>
Date: Mon, 14 Mar 2016 10:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <56E185E9.60506@...515...>
Subject: Re: [Openvpn-devel] Windows installer with SHA-256 signatures ready
	for testing
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


 > Hi,
>
> Here are new Windows 2.3.10 installers with OpenSSL 1.0.1s and SHA-2
> signatures:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3.10-I603-i686=
.exe>
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3.10-I603-x86_=
64.exe>
>
>
> I tested the latter lightly on Windows 7 Pro 64-bit and it seemed to
> work just fine and the signatures seemed to be correct. However, more
> testing is required before these installers can be officially released.
>
> There is potentially a severe issue which manifests itself on Windows
> Vista SP2 / Windows Server 2008 SP2:
>
> <https://support.microsoft.com/en-us/kb/2763674>
>
> A second problem should be limited to Windows 7 and Windows Server 2008
> R2 installations that are booted through a non-Windows bootloader (e.g.
> grub):
>
> <https://support.microsoft.com/en-us/kb/3033929>
>
> Let me know if you can confirm or discredit either of these issues -
> that would help us get the new installers released soon.
>
> Thanks,
>

Hi,

These installers are now live:

<https://openvpn.net/index.php/download/community-downloads.html>

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

