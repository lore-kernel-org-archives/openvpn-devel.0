Message-ID: <3efe819e-84aa-fb09-8b85-f58e3542f206@...1227...>
Date: Fri, 6 Jan 2023 15:51:09 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230103202330.1835-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230103202330.1835-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] dco: properly re-initialize
 dco_del_peer_reason
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 03.01.23 um 21:23 schrieb Antonio Quartulli:
> After processing a message, all fields of the dco object should be
> re-initialized so that future processings are not affected by stale
> values.
> 
> This includes dco_del_peer_reason.
> 
> Since its values can start at 0, re-initialize it with -1.

Acked-By: Arne Schwabe <arne@...1227...>

The place we do the reinitialisation is weird but for now just fix it.

ARne


