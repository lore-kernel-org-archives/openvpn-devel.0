From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506231324.52051.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506231750330.10675@...41...>
References: <200506141234.50171.nomis80@...401...> <20050623083639.GA14170@...33...>
 <Pine.LNX.4.58.0506230942080.10675@...41...> <200506231324.52051.nomis80@...401...>
MIME-Version: 1.0
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
Date: Thu Jun 23 16:56:06 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 23 Jun 2005, Simon Perreault wrote:

> On Thursday 23 June 2005 12:05, James Yonan wrote:
> > One concern I would have is whether the PAM version test at build time is
> > always predictive of what the PAM version will be at run time.
> 
> No, but then that would be going into the realm of cross-compiling.

I was thinking more about someone who builds a binary RPM on a machine
that has a correctly linked pam-modules set causing autoconf to sense this
-- now that RPM can't be used on a machine with an earlier broken version
of pam-modules.

James


