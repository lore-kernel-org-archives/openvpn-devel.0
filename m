MIME-Version: 1.0
References: <20230404075931.840-1-lstipakov@...277...>
 <CAKuzo_hx9rqbMMV+EidpSe5-myQppMfbQXaYN0ikAkSSWtOi-w@...278...>
In-Reply-To: <CAKuzo_hx9rqbMMV+EidpSe5-myQppMfbQXaYN0ikAkSSWtOi-w@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 6 Apr 2023 09:41:08 +0300
Message-ID: <CAGyAFMXBmLQB0XDGHixESqVWj8SksVNvgLtFgv9AfpZTr5r-Qw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Support of DNS domain for DHCP-less
 drivers
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

> Adding "!tuntap_maybe_dhcp()" here looks wrong. We must set the domain if not set during IPv4 processing and that is indicated by did_ifconfig_setup. Just as done in the case handled by interactive-service above.

Right, did_ifconfig_setup is not set if the IPv4 address is not
pushed, in which case we don't do DHCP stuff (as seen in
tuntap_post_open) and tap will be left without a DNS domain. Will
remove this condition.

> Once that check is removed there is no need to introduce tuntap_maybe_dhcp() in this patch at all.

Idea behind tuntap_maybe_dhcp() was to make some parts of code easier
to read by hiding long "if" statements behind this function. But I
agree that it would be easier to review just wmic parts and do long
overdue refactoring separately.

v2 is coming.

-Lev

