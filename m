Message-ID: <4EF45ECC.1020205@...1147...>
Date: Fri, 23 Dec 2011 11:58:20 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4EF33D15.3070104@...515...>
In-Reply-To: <4EF33D15.3070104@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2.2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi mattock,

Samuli Sepp=E4nen wrote:
> The OpenVPN community project team is proud to release OpenVPN 2.2.2. It
> can be downloaded from here:
>
> <http://openvpn.net/index.php/open-source/downloads.html>
>
> Changes include:
>
> - Pkcs11 support built into the Windows version
> - Fixed a bug in the Windows TAP-driver
>
>=20=20=20
this tap-driver bug seems to fix the DHCP NAK storm on Win7 !
I ran OpenVPN 2.2.0 with the tap-win32 9.8 driver, and checked that I=20
could trigger the DHCP NAK storm quite easily (just reconnect a couple=20
of times)
I then upgraded to 2.2.2 + tap-win32 9.9 and since then I have not seen=20
the DHCP NAK storm (in wireshark).

http://www.youtube.com/my_speed performance also seems improved:
- raw link : 14000+ kbps
- vpn link: between 3000 and 10000 kbps

(I remember it was worse before).

Excellent findings by Gert - I can't believe nobody caught the missing=20
'break' statement sooner; I went through the entire tapdrvr.c source=20
code to see if I could find any other missing 'breaks' but it seems OK.

cheers,

JJK

> Full list of changes is attached to this email and is also available here:
>
> <http://openvpn.net/index.php/open-source/documentation/change-log/425-ch=
angelog-for-openvpn-22.html>
>
> For generic help use these support channels:
>
> - Official documentation:
> <http://openvpn.net/index.php/open-source/documentation/howto.html>
> - Wiki: <https://community.openvpn.net>
> - Forums: <https://forums.openvpn.net>
> - User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> - User IRC channel: #openvpn at irc.freenode.net
>
> Please report bugs and ask development questions here:
>
> - Bug tracker and Wiki: <https://community.openvpn.net>
> - Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> - Developer IRC channel: #openvpn-devel at irc.freenode.net
>
> Note that we've recently switched to using a different Git repository:
>
>=20=20=20



