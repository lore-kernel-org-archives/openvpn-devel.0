MIME-Version: 1.0
References: <20200314124428.GE1431@...1296...>
 <20200314125801.1031-1-simon@...2293...>
In-Reply-To: <20200314125801.1031-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 15 Mar 2020 22:42:49 +0200
Message-ID: <CAGyAFMWBgDvukaBadC+B3Hx1G9q_8S7tRMrYOigXVnhcZrGd-A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] tun.c: revise the IPv4 ifconfig
 flow on Windows
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Checked that diff between v1 and v2 is only what was mentioned in review:

 - ip_win32 is set to netsh only for wintun and only if existing value
is dhcp_mask or adaptive

 - flushing arp cache is skipped for wintun

Tested various combinations, works as expected.

Acked-by: Lev Stipakov <lstipakov@...277...>

