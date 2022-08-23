Message-ID: <e6f1f8b6-d486-4e27-3bef-b1e247c05c80@...2181...>
Date: Tue, 23 Aug 2022 22:23:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220822141806.39406-1-frank@...2641...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220822141806.39406-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: do not require fping6
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/08/2022 16:18, Frank Lichtenheld wrote:
> fping and fping6 were merged in version 4.0,
> released in 2017. Many recent distributions do
> not include the compatibility symlink anymore.
> 
> So if we find fping but not fping6 do not error
> out but assume that fping is capable of IPv6.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

Quickly checked the behaviour of fping on gentoo (fping v5.0) and I can 
confirm what Frank said.

Also, on GH it is possible to read when the merge happened: 
https://github.com/schweikert/fping/releases/tag/v4.0


Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli

