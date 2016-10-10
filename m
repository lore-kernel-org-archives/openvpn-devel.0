References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20161009150659.GP78279@...1296...>
	<20161009152550.GQ78279@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <4d267ceb-f72e-b0e5-477b-2d408f4d71de@...515...>
Date: Mon, 10 Oct 2016 16:42:05 +0300
MIME-Version: 1.0
In-Reply-To: <20161009152550.GQ78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
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
To: Gert Doering <gert@...1296...>, Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Il 09/10/2016 18:25, Gert Doering ha scritto:
> Hi,
>
> On Sun, Oct 09, 2016 at 05:06:59PM +0200, Gert Doering wrote:
>> Running more tests with that hunk reverted next...
>
> With the following patch applied on top of Heiko's patch
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 4a11d10..1250547 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1373,11 +1373,13 @@ do_ifconfig (struct tuntap *tt,
>  	else
>  	  {
>  	    /* example: netsh interface ipv6 set address interface=3D42 2001:60=
8:8003::d store=3Dactive */
> +	    char iface[64];
> +	    openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", tt->adapt=
er_index );
>  	    argv_printf (&argv,
> -			 "%s%sc interface ipv6 set address interface=3D%lu %s store=3Dactive",
> +			 "%s%sc interface ipv6 set address %s %s store=3Dactive",
>  			 get_win_sys_path(),
>  			 NETSH_PATH_SUFFIX,
> -			 tt->adapter_index,
> +			 iface,
>  			 ifconfig_ipv6_local );
>  	    netsh_command (&argv, 4, M_FATAL);
>  	  }
>
>
> ... the resulting binary now actually works :-) - tested on win7, without=
(!)
> iservice (because Heiko already tested that), testing all the variants
> of "--ip-win32".  Only a single tap adapter in the system, but will test
> with 2-3 taps next (and trying to run multiple instances).
>
> I've done a "v2" of Heiko's patch with that change included, which I'll
> append below.  Samuli, could you build us a windows installer with master
> plus that patch, for "windows early alpha testing"?  If that change
> works for people, we are very close to 2.4_alpha1...
>
> gert
>

Installers with the attached patch:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-x86_64.exe>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

