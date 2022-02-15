Message-ID: <ef4c391d-d2eb-6bd1-8849-dcb0313fd043@...2080...>
Date: Tue, 15 Feb 2022 14:40:39 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211209171138.8589-2-frank@...2641...>
 <20220214173342.12655-1-frank@...2641...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220214173342.12655-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 2/3 v2] doc: fix misc documentation
 issues
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 14/02/2022 18:33, Frank Lichtenheld wrote:
> - Broken/missing formatting
> - Make it obvious which arguments are optional
> 
> Only the files touched have been reviewed, all other
> files likely have similar issues.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   doc/man-sections/client-options.rst  |  4 ++--
>   doc/man-sections/generic-options.rst | 34 ++++++++++++++++++++--------
>   doc/man-sections/link-options.rst    | 26 +++++++++++++--------
>   src/openvpn/options.c                |  2 +-
>   4 files changed, 43 insertions(+), 23 deletions(-)
> 
> v2: remove some changes David disliked. Not that important.
> > 
> Regards,
> --
> Frank Lichtenheld

Thanks!

This time I've only glared at the changes in diff format, but they all 
look sane and good to me.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


