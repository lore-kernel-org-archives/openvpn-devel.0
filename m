Date: Fri, 19 Feb 2010 15:53:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219145350.GT9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...>
	<4B7EA181.4050103@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B7EA181.4050103@...1114...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
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

On Fri, Feb 19, 2010 at 03:34:41PM +0100, David Sommerseth wrote:
> So I lean towards JJO here, as far as possible, avoid using functions
> which are not thread safe.

I'm not yet convinced that inet_ntop() is actuall not thread-save -
but independent of that, it's not a tie-breaker here :-)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

