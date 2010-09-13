MIME-Version: 1.0
In-Reply-To: <4818AFFA-B84A-4DCE-8F6B-9CA42E63AF48@...1348...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
	<D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
	<AANLkTi=a1GqkMfo2d17XP_JVcD5kOoGBAA=th3WA+rNz@...278...>
	<4818AFFA-B84A-4DCE-8F6B-9CA42E63AF48@...1348...>
Date: Mon, 13 Sep 2010 21:40:57 +0200
Message-ID: <AANLkTinwAb4U7zN3Ae5b7inxTM90sJjcpUL3UqM2qjVy@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On Mon, Sep 13, 2010 at 9:29 PM, Toby Thain <toby@...1348...> wrote:
>>> NMAKE is convenient for Windows builds as it will also happily run
>>> under Linux/WINE, targeting both 32 and 64 bit Windows runtimes with
>>> the 'freely downloadable' Express toolchain. It may even be possible
>>> to combine autotools with the Microsoft compiler, though I haven't
>>> tried it (CC=3D"wine cl", etc).
>>
>> Won't work ever!
>
> Are you certain?
>
> Certainly this works:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ wine nmake /f foo.mak
>
> I have dozens of projects which cross-build this way for 32 and 64 bit
> Windows.

autoconf/automake/libtool will not be able to execute the compilers correct=
ly.
You still need to write and maintain two separate build systems, one
for windows and the other for the rest of the world.
I would also avoid calling using wine "cross-build"... :)

