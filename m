MIME-Version: 1.0
References: <20200310094822.588-1-simon@...2293...>
In-Reply-To: <20200310094822.588-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 12 Mar 2020 10:02:49 +0200
Message-ID: <CAGyAFMXN=ai=yXGY7UvyQFqXXkMpkpcRvck+2nJ8chw2J69UEg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] tun.c: reorder IPv6 ifconfig on
 Windows
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

Explanation makes sense and code does what is says -
adds address/route/dns and removes in reverse direction.

Compiled and smoke-tested with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

