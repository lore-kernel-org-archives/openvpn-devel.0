From: Thomas Glanzmann <sithglan@...162...>
Subject: Re: [Openvpn-devel] tap support for freebsd
Message-ID: <20040220173445.GD18676@...172...>
References: <loom.20040220T055425-265@...171...>
Mime-Version: 1.0
In-Reply-To: <loom.20040220T055425-265@...171...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Feb 20 09:51:04 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I submitted that patch. And will fix it. - If you not already did that.

> I have been attempting to use 1.6_beta6 and found that support for the
> tap device wasn't working on FreeBSD 5.1. I discovered it worked fine
> on FreeBSD 5.1 with 1.6_beta1. 

Ic.

> I believe that it is necessary to conditionalise the write_tun and
> read_tun functions (tun.c) in the same way as has been done for
> openbsd so that the protocol uint32 is only prepended for tun devices.
> At least, with that change, both tun and tap support work fine under
> FreeBSD 5.1 for me.

Could you please send me a patch for this.

	Thomas

