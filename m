Message-ID: <4F2E77C8.1030506@...1114...>
Date: Sun, 05 Feb 2012 13:36:24 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1328442685-8550-1-git-send-email-dejong@...1435...>
In-Reply-To: <1328442685-8550-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Moved out of memory prototype to
 error.h, as the definition is in error.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 05/02/12 12:51, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong<dejong@...1435...>
> ---
>   buffer.h |    4 +---
>   error.h  |    3 +++
>   2 files changed, 4 insertions(+), 3 deletions(-)

ACK to both patches.  Applied to master on -testing and -stable.

commit bee92b479414d12035b0422f81ac5fcfe14fa645
Author: Adriaan de Jong <dejong@...1435...>
Date:   Sun Feb 5 12:51:25 2012 +0100

     Removed support for calling gc_malloc with a NULL gc_arena struct

commit 2b7deeb6632582fcfb23492e77bb09395d1be4ca
Author: Adriaan de Jong <dejong@...1435...>
Date:   Sun Feb 5 12:51:24 2012 +0100

     Moved out of memory prototype to error.h, as the definition is in 
error.c

     Signed-off-by: Adriaan de Jong <dejong@...1435...>
     Acked-by: David Sommerseth <davids@...1347...>
     Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth

