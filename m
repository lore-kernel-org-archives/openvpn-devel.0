MIME-Version: 1.0
In-Reply-To: <1371811708-8528-1-git-send-email-arne@...1227...>
References: <20130620192348.GW20843@...1296...>
	<1371811708-8528-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 26 Jun 2013 21:06:26 -0400
Message-ID: <CAEsd45TSpnv27cuEuZYnEJe06ZwuAeZRLW-KUh6UrZg5W8BbVA@...278...>
Subject: Re: [Openvpn-devel] [Patch v7] Add support of utun devices under
 Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Jun 21, 2013 at 6:48 AM, Arne Schwabe <arne@...1227...> wrote:
> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).
>
> When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices
>
> v2: Fixed tap support, get device name via ioctl, add manage
> v3.1: Fix compiling without if/utun.h, fix manage errors
> v4/v5: Don't try open to dynamically open utun0 -255 when early utun initialization fails, fix fallback to tun, give fatal error message when utun fails but no tun fallback should be done
> v6: add commit message change log, replace strstr with strncmp, move #includes to the top of the file
> v7: Throw error if a user does the strange combination of --dev tun --dev-type tap and --dev-node utun

v7 works on 10.4 through 10.9, tested several different situations on
each. I didn't test it on an actual tap connection, but all the
tun/utun connections I tried worked, and the fallback to tun on 10.4
and 10.5 worked, and the misconfiguration of "--dev tun --dev-type tap
--dev-node utun" was caught.

This looks good to me, for either 2.3.x (because it will fix problems
people have with tuntaposx) or 2.4 (because it is a new feature).

Thanks, Arne.

