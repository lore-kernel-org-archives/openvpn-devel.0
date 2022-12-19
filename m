Message-ID: <6da9f1f6-a808-b381-fa77-3d1023825b7e@...1227...>
Date: Mon, 19 Dec 2022 13:11:40 +0100
MIME-Version: 1.0
References: <20221218192203.1214943-1-selva.nair@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221218192203.1214943-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not include auth-token in pulled
 option digest
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 18.12.22 um 20:22 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> As change in auth-token is common on restart and does not
> require tun-reopen, exclude it from the "pulled options digest"
> calculation. Without this tun is always re-opened on SIGUSR1
> if auth-token is in use which breaks persist-tun.
> 

Makes sense

Acked-By: Arne Schwabe <arne@...1227...>


