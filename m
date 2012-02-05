Message-ID: <4F2E8B96.3050003@...1114...>
Date: Sun, 05 Feb 2012 15:00:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120204172156.GX13929@...1296...>
In-Reply-To: <20120204172156.GX13929@...1296...>
Subject: Re: [Openvpn-devel] add ipv6 related env variables to openvpn.8
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

On 04/02/12 18:21, Gert Doering wrote:
> Hi,
>
> as discussed today.  Pretty much cut-and-paste from the ipv4 counterparts.
>
> gert

ACK.  Applied to master on -stable and -testing.

commit 04d66ef064d5ac1ade4b30329b87239aac95d821
Author: Gert Doering <gert@...1541...>
Date:   Sat Feb 4 18:18:45 2012 +0100

     Document IPv6-related environment variables.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...1347...>
     Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


