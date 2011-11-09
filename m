Message-ID: <4EBA6F45.2030006@...515...>
Date: Wed, 09 Nov 2011 14:17:09 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4e6f25dc2a58c3.42657146@...1498...> <4E801FAE.5010700@...515...>
	<4E806C6A.9090907@...515...>
	<201109261437.45686.heiko.hund@...1489...>
In-Reply-To: <201109261437.45686.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel]
 Snapshot	openvpn-2.x-20110909-master-install.exe fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 26/09/2011 15:37, Heiko Hund ha scritto:
> On Monday 26 September 2011 14:13:30 Samuli Sepp=E4nen wrote:
>> Ok, did as suggested for socket.c and win32.h and got the following
>> build failure using MSVC:
>>
>> <http://pastebin.com/xZ8J2yrq>
> ---8<------------------------------------------------------------------
> c:\users\samuli\openvpn-build\openvpn\win32.h(282) :=20
> error C2373: 'inet_ntop' : redefinition; different type modifiers
> ---8<------------------------------------------------------------------
>
> This is hopefully just because MSVC still believes it's building for Vist=
a or=20
> later. Does the message disappear if you include syshead.h in win32.h? In=
=20
> there WINVER is already defined to signal building for XP. If that doesn'=
t=20
> help, you should also check in <Ws2tcpip.h> if the declaration of inet_nt=
op is=20
> #ifdef'd taking WINVER into account.
>
> Heiko
Hi Heiko,

Took a while, but I finally managed to debug the WinXP inet_ntop issue
somewhat. The results are here:

<https://community.openvpn.net/openvpn/ticket/169>

In a nutshell, OpenVPN builds ok, but does not launch. Did not look into
<Ws2tcpip.h> yet.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


