References: <20210422151724.2132573-1-arne@...1227...>
 <20210506141259.309741-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <15ee1133-6d9a-838b-831b-bffa41db025d@...2181...>
Date: Wed, 12 May 2021 11:36:17 +0200
MIME-Version: 1.0
In-Reply-To: <20210506141259.309741-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Return cached result in
 tls_authentication_status
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 06/05/2021 16:12, Arne Schwabe wrote:
> tls_authentication_status does caching to avoid file I/O more than
> every TLS_MULTI_AUTH_STATUS_INTERVAL (10s) per connection. But
> counter-intuitively it does not return the cached result but rather
> TLS_AUTHENTICATION_UNDEFINED if the cache is not refreshed by the call.
> 
> This is workarounded by forcing a refresh in some areas of the code
> (latency = 0).
> 
> This patch changes the behaviour by always returning the last known
> status and only updating the file status when the i/o timeout for the
> caches is reached.
> 
> The old logic in send_auth_failed is fragile in the sense that if
> it is called again while an exit is scheduled it will reset the timer
> to 5s again. Since we now always report the status from
> tls_authentication_status() instead only every 10s, this caused OpenVPN
> to infinitively reset the timer. Fix this by only setting the status
> if no exit is scheduled. The function is still called multiple times but
> since it is with coarse timer frequency, the 4 extra calls (1 per second)
> are better than to add more extra code to avoid these calls.
> 
> The patch also changes the DEFINE enum into a real enum.
> 
> Patch v2: only update tas_cache_last_udpate when actually updating the cache.
> Patch v3: avoid rearming timer
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

It turned out that this area of the code was quite twisted and by
improving its logic we uncovered some corner cases.

This patch does what it says (improves caching logic and reduces the
voodoo magic), but also introduced some delay (well, due to caching)
that we did not have before.

"[PATCH] Use exponential backoff for caching in
tls_authentication_status" takes care of removing this delay by
implementing a dynamic caching latency (exp backoff).


Acked-by: Antonio Quartulli <antonio@...515...>


Compiled in my lib zoo and tested in my basic environment.


-- 
Antonio Quartulli

