Message-ID: <4797E84F.5080904@...41...>
Date: Wed, 23 Jan 2008 18:22:23 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4797B53E.4020007@...41...>
	<1323691392.20080123234058@...449...>	<9e0cf0bf0801231453i796138cctb3ddb28d1c803c68@...278...>	<359159876.20080124000039@...449...>	<9e0cf0bf0801231507hf027b09jbc7a9cdae292f475@...278...>	<1235941264.20080124002142@...449...>
	<977951940.20080124021820@...449...>
In-Reply-To: <977951940.20080124021820@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

Carsten Kr=FCger wrote:
>> I try to setup a toolchain for windows.
>>    =20
>
> I build lzo-2.0.2 and openssl-0.9.7m (patched)
>
> OPENSSL_DIR=3D~/openssl-0.9.7m
> export OPENSSL_DIR
>
> building openvpn didn't work (maybe it's only to late and I didn't see
> an obvious thing)
>
> Carsten@...1075... ~/openvpn-2.1_rc5
> $ make -f makefile.w32
> gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I=
./openssl/include -I/include -I/include -c crypto.c -o crypto.o
> In file included from crypto.c:35:
> crypto.h:40:29: openssl/objects.h: No such file or directory
> crypto.h:41:26: openssl/rand.h: No such file or directory
> crypto.h:42:25: openssl/evp.h: No such file or directory
> crypto.h:43:26: openssl/hmac.h: No such file or directory
>
>
>  =20

Use ./domake-win to build OpenVPN on Windows (see comments as well in=20
this file).  Build settings are in install-win32/settings.in.

James


