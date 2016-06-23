References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
	<CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
	<60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
	<CAFHpkQEYAKVACJuRj2+G2SHRWpc7DKCR3v+-__k13BW7=-f0PA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <576B9C82.6050209@...2080...>
Date: Thu, 23 Jun 2016 10:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEYAKVACJuRj2+G2SHRWpc7DKCR3v+-__k13BW7=-f0PA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Clarify which Windows versions
 require which TUN/TAP driver
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 22/06/16 19:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> we use ndis5 on windows 10.

If the rumours I've heard are right, NDIS5 support will disappear in
some Windows updates.  The very first rumours was that it would
disappear in Win 8.2 (whatever that version ended up as), but Microsoft
might have delayed the deprecation a bit longer.

On a more general note, please use the NDIS6 (tap6) driver instead, as
that is what gets most of the attention these days and it does need far
more testing.  We really do want the old NDIS5 drive to die.  My opinion
is that once OpenVPN 2.4 will be released, we should stop shipping the
NDIS5 driver when git master begins to target for
OpenVPN 2.5.


--=20
kind regards,

David Sommerseth


> 2016-06-22 22:14 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>=20
>     I have not actually tested tap-windows (NDIS 5) on Windows 10, but I
>     believe NDIS 5 support was removed from Windows 10 a while back. If
>     NDIS 5 drivers still work for Windows 10 then I can definitely
>     reword this part.
>=20
>         why "must" for windows 10 ?
>=20
>         2016-06-22 22:06 GMT+05:00 <samuli@...515...
>         <mailto:samuli@...515...> <mailto:samuli@...515...
>         <mailto:samuli@...515...>>>:
>=20
>             From: Samuli Sepp=C3=A4nen <samuli@...515...
>         <mailto:samuli@...515...> <mailto:samuli@...515...
>         <mailto:samuli@...515...>>>
>=20
>             Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...
>         <mailto:samuli@...515...>
>             <mailto:samuli@...515... <mailto:samuli@...515...>>>
>=20
>             ---
>              INSTALL | 8 ++++----
>              1 file changed, 4 insertions(+), 4 deletions(-)
>=20
>             diff --git a/INSTALL b/INSTALL
>             index 42f78d8..334d0e6 100644
>             --- a/INSTALL
>             +++ b/INSTALL
>             @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
>=20
>                  http://www.whiteboard.ne.jp/~admin2/tuntap/
>=20
>             -* Windows XP/2003/Vista/7:
>             +* Windows
>=20
>                OpenVPN on Windows needs a TUN/TAP kernel driver to work.
>         OpenVPN
>             installers
>                include this driver, so installing it separately is not
>         usually
>             required.
>             -  The driver source code is available here:
>             -
>             -    https://github.com/OpenVPN/tap-windows
>             +  Windows XP/2003 must use the NDIS 5 (tap-windows) driver,
>         whereas
>             more recent
>             +  Windows versions should (Vista to 8.1) or must (Windows
>         10) use
>             the NDIS 6
>             +  driver (tap-windows6) instead.
>=20
>=20=20=20=20=20=20=20=20=20=20=20=20
>          ****************************************************************=
*********
>=20
>             --
>             2.1.4
>=20



