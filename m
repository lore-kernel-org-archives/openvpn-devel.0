Message-ID: <4F2D2C70.8000308@...1114...>
Date: Sat, 04 Feb 2012 14:02:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120203084426.GA24955@...1296...>
	<ae352eb1958ae39e2805169386bb144e@...1528...>
	<20120203151931.GI13929@...1296...>
	<20120203171243.GM13929@...1296...>
In-Reply-To: <20120203171243.GM13929@...1296...>
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
 IPv6 [v2]
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

On 03/02/12 18:12, Gert Doering wrote:
> Hi,
>
> On Fri, Feb 03, 2012 at 04:19:31PM +0100, Gert Doering wrote:
>> On Fri, Feb 03, 2012 at 03:10:37PM +0100, Michael wrote:
>>> the patch does not remove
>>>
>>> +++ b/push.c
>>> @@ -245,8 +245,9 @@ send_push_reply (struct context *c)
>>>         /* TODO: push "/netbits" as well, to allow non-/64 subnet sizes
>>>          *       (needs changes in options.c, options.h, and other
>>> places)
>>>          */
>
> Now it does :-)  - thanks for pointing this out.  v2 patch attached.
>
> "git --reset" is my friend ;-)

ACK.  Applied to master branch on -testing and stable.

commit c55e9562d64f381ba46b83a02503f6239e23d3ef
Author: Gert Doering <gert@...1296...>
Date:   Fri Feb 3 17:11:03 2012 +0100

     Implement IPv6 interface config with non-/64 prefix lengths.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...1347...>
     Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


