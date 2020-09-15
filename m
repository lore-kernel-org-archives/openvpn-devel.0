MIME-Version: 1.0
References: <1600126181-16364-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1600126181-16364-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Sep 2020 09:48:15 +0300
Message-ID: <CAGyAFMUU_zfnEFseD=Ni_iSU6TLcupNdPOL7MjzzD4CaR2_7Xw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow --dhcp-option in config file when
 windows-driver is wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> -        msg(M_USAGE, "--dhcp-options requires --ip-win32 dynamic or adaptive");
> +        msg(M_USAGE, "--dhcp-option requires --ip-win32 dynamic or adaptive");

Nice, this typo has been there since at least 2005.

It looks like that warning is not quite correct - for example,
DNS can be set via iservice or netsh, which means that

--ip-win32 netsh
--dhcp-option DNS 8.8.8.8

is a valid combination regardless of driver type. On the other hand,
NBDD/NTP are set via DHCP.

It would be good to make the warning condition more fine-grained, but
this patch is good enough as it is, since it fixes important case - specify
DNS in the ovpn profile when using wintun.

Built and tested with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

