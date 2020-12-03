References: <20201203154951.29382-1-steffan@...1856...>
 <20201203154951.29382-2-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <afe3ac95-08e8-078d-48ad-f133290238f3@...1227...>
Date: Thu, 3 Dec 2020 17:06:50 +0100
MIME-Version: 1.0
In-Reply-To: <20201203154951.29382-2-steffan@...1856...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] tls-crypt-v2: also preload
 tls-crypt-v2 keys (if --persist-key)
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 03.12.20 um 16:49 schrieb Steffan Karger:
> This allows tls-crypt-v2 servers to drop privileges after reading the
> keys. Without it, the server would try to read the key file for each
> connecting client. (And clients for each reconnect.)
> 
> As with the previous patch, the pre-loading was developed in parallel
> with tls-crypt-v2, and the tls-crypt-v2 patches were never amended to
> implement the pre-loading.
> 
> Also as with the previous patch, it would be nicer if servers would not
> reload the tls-crypt-v2 server key for each connecting client. But let's
> first fix the issue, and see if we can improve later.

Agreed. One thing at a time.

Acked-By: Arne Schwabe <arne@...1227...>


