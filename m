Message-ID: <ad2031eb-2d68-2dec-5f94-830529f2bdcb@...2080...>
Date: Wed, 9 Feb 2022 23:20:16 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211209171138.8589-1-frank@...2641...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20211209171138.8589-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] doc/Makefile: rebuild rst docs if
 input files change
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

On 09/12/2021 18:11, Frank Lichtenheld wrote:
> For now the dependencies are statically defined, which
> should be fine and is still a much better solution than
> to have no dependencies.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   doc/Makefile.am | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 

Done code review and lightly tested it, where it does what it is 
intended to do.  This change makes a lot of sense as well.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


