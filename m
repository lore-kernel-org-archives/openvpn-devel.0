MIME-Version: 1.0
Sender: kubec.daniel@...277...
In-Reply-To: <CAA1Abx+iih31Sby-9bvM5h9n9LA3HaOcOwF+C_Px9zxN_kZtPg@...278...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
	<CAA1Abx+iih31Sby-9bvM5h9n9LA3HaOcOwF+C_Px9zxN_kZtPg@...278...>
From: daniel kubec <niel@...1898...>
Date: Sun, 5 Jun 2016 11:45:57 +0200
Message-ID: <CAEW7GUskk12Jp=kxtWdW-88OYvUPURb29f+VW0wjAOE=ggTyrA@...278...>
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
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
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I am very fascinated - Travis is super cool :-) I building and even
running  / testing (qemu userland emulation) quite complex build
matrix. clang/gcc several OSX/Version + multiple sdk version,
Win32/64, Linux + sdk on many architectures.

Actually building my kbuild build system fork on x86_32, x86_64,
arm32, arm64, os390 (experimental), os390x (experimental)

https://travis-ci.org/n13l/kbuild

$ file ./obj/sysconfig
./obj/sysconfig: PE32+ executable (console) x86-64, for MS Windows
$OS_EXEC ./obj/sysconfig

cpu.vendor=3Dintel
cpu.arch=3Dx86
cpu.sse4.2=3Dyes
cpu.crypto.crc32=3D1
cpu.pagesize=3D4096
cpu.struct.align=3D8
cpu.cacheline=3D64
sys.platform=3Dwin32
sys.sizeof int=3D4
sys.sizeof ptr=3D8


$ file ./obj/sysconfig
./obj/sysconfig: ELF 64-bit MSB  executable, IBM S/390, version 1
(SYSV), dynamically linked (uses shared libs), for GNU/Linux 3.2.0,
BuildID[sha1]=3D3e0888a1fa3fe65baebeb06bcdf1a2da669bda11, not stripped
$OS_EXEC ./obj/sysconfig

sysconfig utility
cpu.vendor=3Dibm
cpu.arch=3Ds390
cpu.crypto.crc32=3D0
cpu.pagesize=3D4096
cpu.struct.align=3D4
cpu.cacheline=3D32
sys.platform=3Dlinux
sys.sizeof int=3D4
sys.sizeof ptr=3D8

On 5 June 2016 at 10:01, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On Sun, Jun 5, 2016 at 12:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>> I was impressed by unit testing efforts, so I suggest to implement somet=
hing
>> like that
>>
>> https://travis-ci.org/chipitsine/openvpn/builds/135318558
>>
>> ( https://github.com/OpenVPN/openvpn/pull/52 )
>>
>> we can use Linux, Mac OSX, gcc, clang, various configure options.
>>
>> (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3 do=
es
>> not compile openvpn with openssl)
>
> Cool.  This looks like a very decent start.
>
> Afaik, OSX no longer ships with up-to-date versions of openssl.  We'd
> need to build openssl before building openvpn, just like you currently
> do with mbedtls.
>
> -Steffan
>
> -------------------------------------------------------------------------=
-----
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traf=
fic
> patterns at an interface-level. Reveals which users, apps, and protocols =
are
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> J-Flow, sFlow and other flows. Make informed decisions using capacity
> planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

