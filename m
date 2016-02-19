References: <5052BCEE4D2D42CBABE65B18A5C7C795@...2089...>
	<56C194ED.9030508@...515...>
	<CAFHpkQFV7wgy01o2hH+3kAGR79HiNaNKWXNpWPOLZMdvGxb29Q@...278...>
	<56C4A43C.5010100@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C6CDC3.5090203@...515...>
Date: Fri, 19 Feb 2016 10:09:39 +0200
MIME-Version: 1.0
In-Reply-To: <56C4A43C.5010100@...515...>
Subject: Re: [Openvpn-devel] Micro-sha-ft
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


> Hi,
>
> We just got an EV certificate token thingy, which certainly does not
> have SHA-1. The problem is that the token makes it impossible to safely
> automate the signing process. So basically we have to turn off automated
> signing in openvpn-build and just sign the files we absolutely have to.
> This probably boils down to
>
> openvpn-installer-*.exe
> tap-windows6 drivers
> tap-windows6 installer
>
> It would be nice to sign openvpn-gui, but then openvpn-build would have
> to fetch a pre-built and signed openvpn-gui.exe instead of building and
> signing it itself.
>
> According to Microsoft documentation[*] we _could_ continue using non-EV
> certs (+ automated signing) for non-driver code, but that would probably
> mean paying for two certificates. I'll ask around to see if this is
> indeed the case.

We decided to rekey our current non-EV certificate with SHA-2 - it will=20
be valid until the upcoming September. This will buy us some time to=20
think about our next move. So what I'll do next is:

- Sign the tap-windows6 driver with the EV-cert
- Start using the rekeyed non-EV cert for the rest of the signing

This should solve all the certificate validation issues we currently=20
have on Windows.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

