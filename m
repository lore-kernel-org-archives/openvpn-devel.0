Message-ID: <4E801FAE.5010700@...515...>
Date: Mon, 26 Sep 2011 09:46:06 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4e6f25dc2a58c3.42657146@...1498...>
	<4e7850551f9909.15751189@...1498...>	<201109201228.30353.heiko.hund@...1489...>
	<201109201318.00120.heiko.hund@...1489...>
In-Reply-To: <201109201318.00120.heiko.hund@...1489...>
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


> On Tuesday 20 September 2011 12:28:30 Heiko Hund wrote:
>> or maybe it's just that _MSC_VER was not defined
> Misread the code, it's an #ifndef. Could someone test if replacing the
>
> 	#ifndef _MSC_VER
>
> lines in socket.c and win32.h with
>
> 	#if WINVER < 0x0600
>
> leads to a problem when building with MSVC.=20
>
> Heiko

I'll test and report back later today.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


