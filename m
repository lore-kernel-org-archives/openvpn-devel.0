Message-ID: <4C20D014.7050802@...1147...>
Date: Tue, 22 Jun 2010 17:00:36 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
In-Reply-To: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
 Windows XP shares over port 445?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Henno_T=E4ht?= <henno.taht@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Hi Henno,

Henno T=E4ht wrote:
> Is it possible to share files from Windows XP using port 445 over
> OpenVPN tunnel?
>
> Everything works within the LAN but from the other side of OpenVPN
> connection I'm getting "No network provider accepted the given network
> path." error while trying to access XP's shares.
>
> Sniffing shows this:
> (zeus is the machine trying to access XP's shares)
>
> Time        Source        Destination     Proto    Info
> 1.718123    zeus            xp            TCP      3285 > 445 [SYN]
> Seq=3D0 Win=3D64240 Len=3D0 MSS=3D1460
> 1.830665    xp              zeus          TCP      445 > 3285 [RST,
> ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> 2.189052    zeus            xp            TCP      3285 > 445 [SYN]
> Seq=3D0 Win=3D64240 Len=3D0 MSS=3D1460
> 2.219486    xp              zeus          TCP      445 > 3285 [RST,
> ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> 2.735585    zeus            xp            TCP      3285 > 445 [SYN]
> Seq=3D0 Win=3D64240 Len=3D0 MSS=3D1460
> 2.766907    xp              zeus          TCP      445 > 3285 [RST,
> ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
>
> So XP is refusing port 445 connections from OpenVPN adapter. Firewall
> is off (otherwise no packet would be sent back).
>
> While NetBIOS over TCP/IP works (port 139), it has been disabled on
> zeus and as I understand DirectSMB (microsoft-ds or port 445) should
> be more efficient.
>=20=20=20
you're actually not the first person to report this issue...

I can reproduce the behaviour on Windows XP but not on Windows 2000 ,=20
using the exact same openvpn version and installation configuration.

similar to what you are seeing , I can see in wireshark is that any=20
access over port 445 to \\<VPN-IP>>\ is dropped immediately by windows=20
XP, yet on windows 2000 this works flawlessly.

The only thing I can think of is that Windows XP explicitly forbids=20
access to port 445 as a countersecurity measure unless it's coming from=20
an "official" network card.
It seems like OpenVPN is working as it should, it's just that Windows XP=20
(and Vista/7?) does not regard the tap-win32 adapter as an official=20
network card and hence does not allow access.

Your best bet is to continue using netbios-over-tcpip for the time being=20
(I always disable port 445 anyways) until a Windows kernel guru can tell=20
us just what the heck is happening here (where would this be logged? my=20
XP firewall is turned off

Maybe someone on the -devel list (CC'ed) knows more about the=20
interaction between the tap-win32 adapter and the rest of the windows os?

cheers,

JJK


