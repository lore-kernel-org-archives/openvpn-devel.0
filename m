Message-ID: <4ac0f3e9-2372-51a4-0861-7b5174cd5b5b@...2108...>
Date: Thu, 2 Mar 2023 21:25:03 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230228044142.39803-1-heiko@...2662...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <20230228044142.39803-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] dns option: remove support for
 exclude-domains
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

On 28/02/2023 05:41, Heiko Hund wrote:
> No DNS resolver currently supports this and it is not possible to
> emulate the behavior without the chance of errors. Finding the
> effective default system DNS server(s) to specify the exclude
> DNS routes is not trivial and cannot be verified to be correct
> without resolver internal knowledge. So, it is better to not
> support this instead of supporting it, but incorrectly.
> 
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>   doc/man-sections/client-options.rst | 14 +++++---------
>   src/openvpn/dns.c                   | 13 ++-----------
>   src/openvpn/dns.h                   |  7 -------
>   src/openvpn/options.c               | 16 ----------------
>   4 files changed, 7 insertions(+), 43 deletions(-)


I've only glared at the code and quickly done a few compile tests. 
LGTM.  Change itself also makes sense.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc



