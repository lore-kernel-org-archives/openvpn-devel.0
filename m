Date: Fri, 9 Apr 2010 10:54:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100409085458.GR12312@...1296...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
In-Reply-To: <1269951178-30419-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure information to --version
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
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Tue, Mar 30, 2010 at 02:12:58PM +0200, David Sommerseth wrote:
> This patch will create ./configure.h which will contain two new #define
> strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED and
> DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
> complete ./configure line which was used when configuring the package
> for building.

A bit late, but "looks good to me" (and useful, too :) ).  ACK.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

