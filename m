References: <1567784437-25922-1-git-send-email-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ce5425f8-2797-e553-446f-09b824af0ef8@...2181...>
Date: Fri, 6 Sep 2019 21:14:59 +0200
MIME-Version: 1.0
In-Reply-To: <1567784437-25922-1-git-send-email-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] tun.h: change tun_set() return value
 type to void
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 06/09/2019 17:40, Lev Stipakov wrote:
> This function's return value is never used, so make it void.
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>

Does what it says and git suggests that its return value was never used.
Using void as return type also clarifies its usage.

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

