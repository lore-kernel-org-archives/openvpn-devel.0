MIME-Version: 1.0
References: <20221214224220.307-1-lstipakov@...277...>
 <202212151234.2BFCY9af082666@...2054...>
In-Reply-To: <202212151234.2BFCY9af082666@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Dec 2022 14:48:49 +0200
Message-ID: <CAGyAFMXzj1yQtq9Yvy5sJXXov0LL_x0+Dp8P6ic09_Zs+fLZUw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: management: add timer to
 output BYTECOUNT
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
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

> So it seems as the timer activation got delayed somehow
> -> this is something we need to come back to, when Linux/FreeBSD DCO
> stats get implemented.  Starting with "management-hold", then "bytecount",
> then "hold release" gave me counters right away.  Mysteries...

This is because we do not trigger this new timer (for example by
calling reset_coarse_timers)
when we init it in man_bytecount(). We do not have "struct context"
there to do it.

Follow-up calls to reset_coarse_timers() or process_coarse_timers()
will do the trick. However, in DCO case nothing might happen in userspace
for a while, hence delay. GUI does "management-hold", sends "bytecount 5"
and after that "hold-release".

-Lev

