Message-ID: <991e5560-533b-9c32-7dd6-a449317100d8@...2181...>
Date: Tue, 7 Feb 2023 23:44:04 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230206112218.51430-1-frank@...2641...>
 <20230207132026.41580-1-frank@...2641...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230207132026.41580-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v3] configure: enable DCO by default on
 FreeBSD/Linux
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

On 07/02/2023 14:20, Frank Lichtenheld wrote:
> Automatically disabled when
> - iproute2 is enabled
>    (Don't want to force people specifying --disable-dco explicitely)
> - libnv is missing on FreeBSD
>    (FreeBSD version too old anyway)
> 
> Will still error out if libnl-genl is missing on Linux to
> make people aware of the new dependency.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

