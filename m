Message-ID: <5132f6d7-d93c-b8aa-f756-cb217939358b@...2108...>
Date: Mon, 11 Sep 2023 10:57:38 +0200
MIME-Version: 1.0
Content-Language: en-GB, nb-NO
References: <20230709231929.195048-1-jeremyfleischman@...277...>
 <20230906171758.344862-1-jeremyfleischman@...277...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <20230906171758.344862-1-jeremyfleischman@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix StatusChangeCallback so it works
 without a LogCallback
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
To: Jeremy Fleischman <jeremyfleischman@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 06/09/2023 19:17, Jeremy Fleischman wrote:
> `StatusChangeCallback` requires that LogForward be enabled, which
> previously only happened in `LogCallback`. Now both of them do it, which
> requires a bit of bookkeeping. This fixes
> https://github.com/OpenVPN/openvpn3-linux/issues/197
> 
> Signed-off-by: Jeremy Fleischman <jeremyfleischman@...277...>
> ---
>   src/python/openvpn3/SessionManager.py | 69 ++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 11 deletions(-)
> 

Thanks a lot for your patience and persistence through this review.

Your patch has been put into the queue for the coming v21 release.  I've 
not yet pushed out that branch, as I'm waiting for our QA team to 
complete the testing of an updated OpenVPN 3 Core library release first; 
which is required to be able to build OpenVPN 3 Linux from the public repos.

But consider your patch applied.  I've only done minor edits to some 
comments and commit messages, but the code itself is unchanged.

I'll follow-up with an update once this commit is public.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



