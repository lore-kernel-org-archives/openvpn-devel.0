MIME-Version: 1.0
References: <20200924064452.1001-1-simon@...2293...>
 <20200924064452.1001-3-simon@...2293...>
In-Reply-To: <20200924064452.1001-3-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Sep 2020 12:24:40 +0300
Message-ID: <CAGyAFMURuHocxj=pscqr0JfyW_3R3Uqq841C9Ni8JTt+gPkTig@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] netsh: Delete WINS servers on TUN
 close
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

> +                    "%s%s interface ipv4 delete winsservers %lu all",

For DNS we use "dns", so it would be nice to unify it - either use
dnsservers/winsservers or dns/wins. But that could be done later.

Code makes sense, compiled/tested on MSVC/Win10.

Acked-by: Lev Stipakov <lstipakov@...277...>

