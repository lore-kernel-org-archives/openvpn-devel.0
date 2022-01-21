Message-ID: <a91217dd-5c98-accf-2fb5-ebdaba2a0ecb@...2181...>
Date: Fri, 21 Jan 2022 22:55:09 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211213162841.15763-1-frank@...2641...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20211213162841.15763-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] Make build deterministic,
 remove __DATE__
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

On 13/12/2021 17:28, Frank Lichtenheld wrote:
> The information provided by this is minimal
> and it makes it more difficult to provide
> deterministic builds. There are work-arounds
> for that but I think it is easier to just remove
> it completely.
> 
> Allows the build to pass with -Wdate-time -Werror.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

