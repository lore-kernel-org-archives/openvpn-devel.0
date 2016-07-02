References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<ab01dda4-e7fe-2c9b-c41f-26c7f8f92cd5@...1227...>
	<94cf2582-6f60-4b3f-0675-c362f2d91238@...1227...>
	<CAKuzo_iVWZVxUm9x_FHVaP9bWUVdzNjb+P-sK9OTx1H7UutvWA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cb9a91ab-452e-cf22-9152-a659979f032e@...1227...>
Date: Sun, 3 Jul 2016 00:38:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iVWZVxUm9x_FHVaP9bWUVdzNjb+P-sK9OTx1H7UutvWA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Exponentially backoff on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 02.07.16 um 18:56 schrieb Selva Nair:
> 
> On Sat, Jul 2, 2016 at 11:32 AM, Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     > And why sighup? Shouldn't just limiting sec be enought. SIGHUP has many
>     > side effects. I don't think we should trigger these for connection time.
>     >
>     >
>     > With default setting this results in a SIGHUP after some hours and also
>     > the last intervals with 5120s are too big for default settings. I would
>     > aim for something lower like five or ten minutes.
> 
>     I think a bit about that and I think a good way to specify exponential
>     back is something like
> 
>     connect-retry 5 1800, which would mean "scale back up to 1800s" and
>     maybe default that option to connect-retry 5 300. That also allows
>     specifying larger connect-retry values without backoff. E.g.
>     connect-retry 60 60
> 
> 
> Good idea.
> 
> Agreed, triggering SIGHUP is not ideal. The only reason for it was to
> reset the counters so that the backoff time doesn't get stuck at the
> highest value for ever. If we reduce the max backoff interval that's
> less of a concern.
> 
> One motivation for this patch is to avoid logs filling up. For a client
> stuck in a restart loop with verb=3 and 5 minutes max pause, the logs
> grow by about 1 M per  day --  may be not too bad.
> 
> Selva

Do you want to propose a new patch or should I do it. I would propose
still a exponential backoff but starting a 2s. so we get 2s 4s 8s ... or
as default conect-retry 2 256. It would then just stay at the 256s
interval until a sucessful connection is established. That simplifies
the logic and gives predictable (from a user perspective) results.

Iirc the logic of connect-retry was changed by me in master so changing
the logic again should not be a problem.



