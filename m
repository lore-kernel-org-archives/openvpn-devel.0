Message-ID: <20100310173326.21575.qmail@...1287...>
Date: Wed, 10 Mar 2010 18:33:26 +0100
From: Peter Stuge <peter@...1287...>
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
	<4B978D0E.9090606@...1114...>
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
	<4B97CDF3.6060703@...1114...>
	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
	<4B97D385.3010506@...1114...>
	<20100310172636.20173.qmail@...1287...>
MIME-Version: 1.0
In-Reply-To: <20100310172636.20173.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE
	if	not defined
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
To: openvpn-devel@lists.sourceforge.net

Peter Stuge wrote:
> RHEL4.6 can easily build a release that was prepared using the most
> recent autoconf.

In fact, I would suggest that using the newest autotools when
creating the package makes it *more* likely to build effortlessly
on older systems.


//Peter

