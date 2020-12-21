MIME-Version: 1.0
References: <20201215173004.26170-1-domagoj@...2540...>
 <CAGyAFMV8ztjmyRSMcT0=MPefkkcUQ9yMErT5xu7so3agCTB9HA@...278...>
 <20201219132233.GA175082@...2540...>
In-Reply-To: <20201219132233.GA175082@...2540...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 21 Dec 2020 11:30:41 +0200
Message-ID: <CAGyAFMW71fF6WkoKhLERnmCYieijyi50C5-VEJ36NFQixbnGnA@...278...>
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

> I've done some more investigation and I've found out that problem was
> introduced in commit:
>
> 09ae6280 tun.c: revise the IPv4 ifconfig flow on Windows

Right, we refactored code, added support for IPAPI and as a side-effect
DHCP renew/release code is always executed no matter adapter type.

With your explanation patch makes sense to me. Stared at the code
and tested with wintun.

Acked-by: Lev Stipakov <lstipakov@...277...>

