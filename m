Message-ID: <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
Date: Mon, 16 Dec 2024 09:41:24 +0100
MIME-Version: 1.0
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] port-share: Normalize IPv4-mapped
 IPv6 addresses
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
To: corubba <corubba@...68...>, openvpn-devel@lists.sourceforge.net

Hello,

On 15/12/2024 00:19, corubba via Openvpn-devel wrote:
> Before passing IPv4-mapped IPv6 addresses to the proxy journal,
> translate them to plain IPv4 addresses. Whether the connection was
> accepted by OpenVPN on a "dual stack" socket is of no importance to the
> proxy receiver.

Thank you very much for all these improvements!
We truly appreciate your work (especially because they are IPv6 related ;-D)

> 
> Signed-off-by: corubba <corubba@...68...>

However, for legal reasons we need the Signed-off-by line to contain 
your real name and surname. This line represents a real signature of 
acceptance of the license OpenVPN is shipped with.

Would you mind sending a v2 of this patchset with the modified 
signed-off-by line?

Thanks a lot.

Best Regards,

-- 
Antonio Quartulli


