Date: Fri, 19 Feb 2010 17:49:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219164940.GW9556@...1296...>
References: <4B7EBE5C.60702@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B7EBE5C.60702@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] verb 5 logging wrongly reports received
	bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Feb 19, 2010 at 05:37:48PM +0100, David Sommerseth wrote:
> ACK
> 
> Patch looks sensible, and applies cleanly to the master branch.

ACK.   I can see the reason for doing so (as I'll have a device "soon"
that will return 0 from tun device reads under certain circumstances)
and it doesn't break current usage.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

