Message-ID: <e73fb8c56e6a375b069259300acc15c2.squirrel@...2257...>
In-Reply-To: <20171116140958.12847-1-steffan@...1856...>
References: <830a17f8babbca92e21d64c1324a15b1.squirrel@...2257...>
 <20171116140958.12847-1-steffan@...1856...>
Date: Fri, 17 Nov 2017 07:05:31 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4] Add per session pseudo-random jitter
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan@...1856...>

Hi,

> From: Simon Matter <simon.matter@...2249...>
>
> While we were suffering from the "TLS Renegotiation Slowdown" bug here
> https://community.openvpn.net/openvpn/ticket/854 we realized that there is
> still room for improvement in our use case.
>
> It appears that TLS renegotiation is getting more and more expensive in
> terms of CPU cycles with recent changes for more security. To make things
> worse, we realized that most renegotiation procedures took place at almost
> the same time and increased the CPU load too much during these periods.
> That's especially true on large, multi-instance openvpn setups.
>
> I've created attached patch to add a per session pseudo-random component
> to
> the --reneg-sec intervals so that renegotiation is evenly spread over
> time.
> It is configured by simply adding a second value to --reneg-sec as
> described in the --help text:
>
> --reneg-sec max [min] : Renegotiate data chan. key after at most max
>                   (default=3600) and at least min (default 90% of max on
>                   servers and equal to max on clients).
>
> The jitter is only enabled by default on servers, because the actual reneg
> time is min(reneg_server, reneg_client).  Introducing jitter at both ends
> would bias the actual reneg time to the min value.
>
> Note that the patch also slightly changes the log output to show the sec
> value in the same way as the bytes/pkts values:
>
> TLS: soft reset sec=3084/3084 bytes=279897/-1 pkts=1370/0
>
> The idea and first versions of this patch are from Simon Matter.  Steffan
> Karger later incorporated the mailing list comments into this patch.  So
> credits go to Simon, and all bugs are Steffan's fault ;-)
>
> Signed-off-by: Simon Matter <simon.matter@...2249...>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v3: incorporate comments from openvpn-devel@, don't add jitter by
>     default on the client side.
> v4: fix printing of reneg interval, clarify/typofix comments

I've tested it and it works as expected, thanks!

Regards,
Simon


