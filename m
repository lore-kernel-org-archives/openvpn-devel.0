Date: Thu, 29 Apr 2010 09:58:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100429075820.GY12312@...1296...>
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
	<20100429070756.GX12312@...1296...>
	<o2n251896ce1004290039xcc5a287bm716433a44dfe8347@...278...>
Mime-Version: 1.0
In-Reply-To: <o2n251896ce1004290039xcc5a287bm716433a44dfe8347@...278...>
Subject: Re: [Openvpn-devel] [PATCH] TAP interface support for
	Solaris/OpenSolaris
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
To: Kazuyoshi Aizawa <admin2@...628...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Apr 29, 2010 at 04:39:35PM +0900, Kazuyoshi Aizawa wrote:
> Thank you for your support.
> Please find attached patch with diff -uw.

Thanks.  

I wouldn't claim to understand why the specific changes are needed, 
but this way it is obvious that the changes really only affect the 
Solaris-specific part of tun.c.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

