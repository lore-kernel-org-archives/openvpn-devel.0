Message-ID: <535570CB.8010005@...515...>
Date: Mon, 21 Apr 2014 13:26:03 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-2-git-send-email-james@...515...>
	<53550084.2070404@...1227...>
In-Reply-To: <53550084.2070404@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Added PIP_OPT_MASK for
 process_ip_header fast exit path.
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 21/04/2014 05:27, Arne Schwabe wrote:
> On 21.04.2014 09:10, James Yonan wrote:
>> Define PIP_OPT_MASK to represent all flags of interest to
>> process_ip_header, so that it can have a fast exit path
>> if no flags are set.
>
> I haven't look at the code but if remember  correctly, this method does
> not get passed the actual flags but the flags should *potientially* be
> checked.

Yes, the point is to aggregate the potential flags of interest to 
process_ip_header under a single mask, i.e. PIP_OPT_MASK.

So instead of having "if (flags & (PIPV4_PASSTOS|PIP_MSSFIX|...|...))" 
you just have "if (flags & PIP_OPT_MASK)".

The main issue for us is that we have an internal patch for one of our 
services that adds an additional flag, and the previous usage is a merge 
conflict attractor because all the flags of interest are explicitly 
given on a single line.

> See also my never reviewed patch:
> http://thread.gmane.org/gmane.network.openvpn.devel/7532

Your patch would be simplified with this approach because you don't need 
to add the test for PIPV4_CLIENT_NAT to "if (flags & ...)".

James

