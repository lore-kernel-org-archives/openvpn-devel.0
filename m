MIME-Version: 1.0
References: <20201215173004.26170-1-domagoj@...2540...>
In-Reply-To: <20201215173004.26170-1-domagoj@...2540...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 18 Dec 2020 12:45:43 +0200
Message-ID: <CAGyAFMV8ztjmyRSMcT0=MPefkkcUQ9yMErT5xu7so3agCTB9HA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Skip DHCP renew with Wintun adapter
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

The patch looks fine, but I wonder how did you manage to trigger this case?

dhcp_release() or dhcp_renew() are called if dhcp_masq_post is set to true,
which only happens for tap-windows6.

fork_dhcp_action() is no-op unless dhcp-renew/dhcp-pre-release
are explicitly defined in the ovpn profile.

If latter is the case, I wonder if options postprocessing would be a
better place
to fix it.

-Lev

