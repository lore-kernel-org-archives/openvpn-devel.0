Message-ID: <53550084.2070404@...1227...>
Date: Mon, 21 Apr 2014 13:27:00 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-2-git-send-email-james@...515...>
In-Reply-To: <1398064204-26476-2-git-send-email-james@...515...>
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
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

On 21.04.2014 09:10, James Yonan wrote:
> Define PIP_OPT_MASK to represent all flags of interest to
> process_ip_header, so that it can have a fast exit path
> if no flags are set.

I haven't look at the code but if remember  correctly, this method does 
not get passed the actual flags but the flags should *potientially* be 
checked.

See also my never reviewed patch: 
http://thread.gmane.org/gmane.network.openvpn.devel/7532

Arne


