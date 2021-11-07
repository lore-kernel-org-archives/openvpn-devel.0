Message-ID: <847fdafb-71d3-59d1-3f26-a9c5b9e545e8@...2181...>
Date: Sun, 7 Nov 2021 17:35:01 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20210520151148.2565578-7-arne@...1227...>
 <20211106180055.3073072-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20211106180055.3073072-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Refactor early initialisation and
 uninitialisation into methods
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 06/11/2021 19:00, Arne Schwabe wrote:
> This put the early initialisation and uninitialisation that needs to
> happen between option parsing and post processing into small methods.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Change looks good, no error/warning upon compilation and a basic 
connectivity test just worked with both sitnl and iproute2.

Acked-by: Antonio Quartulli <a@...2640...>


-- 
Antonio Quartulli

