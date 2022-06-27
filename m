Message-ID: <6fb8cdab-86d0-5743-344a-1f78ef65be3b@...1227...>
Date: Mon, 27 Jun 2022 13:04:44 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220624083809.23487-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 03/25] dco: use specific metric when
 installing routes
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
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
> When using DCO iroutes and routes all live in the same routing table,
> However, the latter should always come after the former.
> 
> for this reason assign a default metric of 200 to routes. iroutes will
> later get a metric of 100.

Can you also add documentation of this? (if it is not coming in a later 
patch)

Acked-By: Arne Schwabe <arne@...1227...>

