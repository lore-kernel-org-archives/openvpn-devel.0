References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
	<CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
Date: Wed, 22 Jun 2016 20:14:31 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Clarify which Windows versions
 require which TUN/TAP driver
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

I have not actually tested tap-windows (NDIS 5) on Windows 10, but I=20
believe NDIS 5 support was removed from Windows 10 a while back. If NDIS=20
5 drivers still work for Windows 10 then I can definitely reword this part.

> why "must" for windows 10 ?
>
> 2016-06-22 22:06 GMT+05:00 <samuli@...515... <mailto:samuli@...515...>>:
>
>     From: Samuli Sepp=C3=A4nen <samuli@...515... <mailto:samuli@...515...=
>>
>
>     Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...
>     <mailto:samuli@...515...>>
>     ---
>      INSTALL | 8 ++++----
>      1 file changed, 4 insertions(+), 4 deletions(-)
>
>     diff --git a/INSTALL b/INSTALL
>     index 42f78d8..334d0e6 100644
>     --- a/INSTALL
>     +++ b/INSTALL
>     @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
>
>          http://www.whiteboard.ne.jp/~admin2/tuntap/
>
>     -* Windows XP/2003/Vista/7:
>     +* Windows
>
>        OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN
>     installers
>        include this driver, so installing it separately is not usually
>     required.
>     -  The driver source code is available here:
>     -
>     -    https://github.com/OpenVPN/tap-windows
>     +  Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas
>     more recent
>     +  Windows versions should (Vista to 8.1) or must (Windows 10) use
>     the NDIS 6
>     +  driver (tap-windows6) instead.
>
>      ********************************************************************=
*****
>
>     --
>     2.1.4
>
>
>     ---------------------------------------------------------------------=
---------
>     Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in S=
an
>     Francisco, CA to explore cutting-edge tech and listen to tech luminar=
ies
>     present their vision of the future. This family event has something f=
or
>     everyone, including kids. Get more information and register today.
>     http://sdm.link/attshape
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>



