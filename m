Message-ID: <2680b52b-e2d8-9a44-e2ee-b227ac374313@...1227...>
Date: Mon, 12 Dec 2022 15:25:54 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221212115642.2139-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221212115642.2139-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] management: add timer to push
 BYTECOUNT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Am 12.12.22 um 12:56 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> At the moment BYTECOUNT in,out is pushed if there is traffic.
> With DCO, userspace process doesn't see the traffic, so we need
> to add a timer which periodically fetches stats from DCO and
> pushes to management client. The timer interval is set by existing
> "bytecount n" management command.
> 
> This commit only adds a timer, stats fetching from DCO will be added
> later.


If you do the timers anyway why keep the other logic that triggers on 
                    updating the byte count? That feels duplicating and 
unnecessary complexity. So if we switch to a timer, I would strongly 
advocate to remove the other code path to avoid having two code paths 
that only add complexity but do not offer any significant (none?) 
benefit vs only keeping the timer.

Arne


