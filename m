Message-ID: <4F2D2C35.9080708@...1114...>
Date: Sat, 04 Feb 2012 14:01:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120203172157.GN13929@...1296...>
In-Reply-To: <20120203172157.GN13929@...1296...>
Subject: Re: [Openvpn-devel] more t_client.sh fixes
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

On 03/02/12 18:21, Gert Doering wrote:
> Hi,
>
> last patch for "sudo functionality in t_client.sh" was incomplete, and
> for some reason I didn't notice on the test system - fell on my feet on
> the freebsd 7.4 test client, and is now fixed for good :-)
>
> gert

ACK.  Applied to master branch on -testing and -stable.

commit fc3ee19dee6c66e2325a24e864b5328128404e83
Author: Gert Doering <gert@...1296...>
Date:   Fri Feb 3 19:18:07 2012 +0200

     Fix RUN_SUDO functionality for t_client.sh

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...1347...>
     Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


