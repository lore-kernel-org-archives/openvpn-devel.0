References: <20200701122239.6924-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dee5fe07-aa6d-c59f-4f25-7a617e8a2dfc@...2181...>
Date: Wed, 1 Jul 2020 15:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200701122239.6924-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove parameter config from
 multi_client_connect_mda
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

On 01/07/2020 14:22, Arne Schwabe wrote:
> config is always used as mi->cc_config and we pass mi,
> so directly use mi->cc_config
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli

