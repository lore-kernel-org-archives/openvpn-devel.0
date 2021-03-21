References: <20210319142001.2201-1-arne@...1227...>
 <20210319142001.2201-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9937ce82-dd48-8494-5413-a3259128d5dd@...2181...>
Date: Sun, 21 Mar 2021 18:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210319142001.2201-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Deprecate the --verify-hash
 option
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

On 19/03/2021 15:20, Arne Schwabe wrote:
> Despite trying to figure out with multiple people what the use case for
> this option is, we could not come up with a good one. Checking that only
> a specific CA is used can be also done by only using that CA in the --ca
> directive.
> 
> Although it feels a bit strange to deprecate the option after improving
> it with peer-fingerprint patches, all the improvements are needed for
> --peer-fingerprint and making them specify to --peer-fingerprint would
> have added more (unecessary) changes.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch looks good to me, but it does not apply on top of the
previous 4. Maybe it was committed without considering the old 4/4?

Regards,


-- 
Antonio Quartulli

