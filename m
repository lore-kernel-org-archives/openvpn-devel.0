Date: Wed, 24 Feb 2010 16:35:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100224153506.GA19530@...1296...>
References: <1266874909-7144-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1266874909-7144-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] FRP: Present a warning on deprecated
	features during start-up
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
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Feb 22, 2010 at 10:41:49PM +0100, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> Added a new function, warn_deprecated_features(), which is located in
> deprecated.[ch].  All deprecated features should present a warning here.
> This function will be called during start-up and will show all warnings
> after the OpenVPN title string.
> 
> Included a deprecated feature warning for the resolv-random feature.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>

ACK!

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

