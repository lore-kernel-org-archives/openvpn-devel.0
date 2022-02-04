Message-ID: <47ac86dd-b0df-77af-76aa-85a42db19917@...2181...>
Date: Fri, 4 Feb 2022 17:41:55 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220204154504.16830-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220204154504.16830-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Get rid of README.IPv6 and revamp
 TODO.IPv6
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
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>

Hi,

On 04/02/2022 16:45, Antonio Quartulli wrote:
> README.IPv6 is quite useless because IPv6 is not a second
> class citizen anymore. Most of the content is "obvious" or explained in
> the manpage along with other details/options.
> 
> TODO.IPv6 is old and many implemented things are still reported there
> for no clear reason. Prune all useless details and keep what seems to
> still be not implemented.
> 
> Cc: Gert Doering <gert@...1296...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> I am personally in favour of killing TODO.IPv6 as well and rather
> document missing features in trac tickets. Thoughts?
> 
> 
> 
>   README.IPv6 |  56 ----------------
>   TODO.IPv6   | 180 +++-------------------------------------------------

Note: this patch is missing a piece: README.IPv6 should be removed from 
Makefile.am as well.

Will send v2 if the general idea is accepted.

Cheers,



-- 
Antonio Quartulli

