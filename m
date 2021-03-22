References: <20210319142001.2201-4-arne@...1227...>
 <20210322091621.7864-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b0aa434a-cb11-a410-e5a2-8f3c145ea190@...2181...>
Date: Mon, 22 Mar 2021 10:43:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210322091621.7864-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 5/5] Deprecate the --verify-hash
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

On 22/03/2021 10:16, Arne Schwabe wrote:
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
> Patch v3: rebased on v3 version of other patches.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

