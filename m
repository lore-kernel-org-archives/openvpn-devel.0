Message-ID: <55963872.3070906@...515...>
Date: Fri, 03 Jul 2015 10:23:30 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <015601d0b436$d555ad60$80010820$@gmail.com>	<CAA1AbxKrPXnc1+PPH4dQV1OksY_0t3ewqRnqVrjhZL+i2Pbkmw@...278...>	<016901d0b446$15330540$3f990fc0$@gmail.com>
	<CAA1Abx+T8h8WcEPV7b_f2BaBKzyL2rckJJg+n+tosGPdjWTmpQ@...278...>
In-Reply-To: <CAA1Abx+T8h8WcEPV7b_f2BaBKzyL2rckJJg+n+tosGPdjWTmpQ@...278...>
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010
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
To: Steffan Karger <steffan@...1856...>, Fish Wang <fish.thss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


>> Also I believe Visual Studio provides better security guarantees (like s=
tack canaries, buffer checks etc.).
> Just for reference: those are supported by mingw/gcc too:
> -fstack-protector for canaries, -Wl,--nxcompat for DEP,
> -Wl,--dynamicbase for ASLR.

Steffan: so these are the magic incantations that would solve

<https://community.openvpn.net/openvpn/ticket/325>

I'll try those with openvpn-build and see what happens.

Thanks,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


