From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] 2.0.1-rc6: support LZO 2.01 (liblzo.*
 -> liblzo2.*)
In-Reply-To: <20050720092613.GA29615@...33...>
Message-ID: <Pine.LNX.4.58.0507211443310.7851@...41...>
References: <20050720092613.GA29615@...33...>
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
Date: Thu Jul 21 13:47:13 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

Matthias,

Thanks -- I've released your 2 patches as 2.0.1-rc7.

James

On Wed, 20 Jul 2005, Matthias Andree wrote:

> The attached patch checks for liblzo2 if LZO v2 headers have been found,
> to support LZO 2.01 and newer, which renamed the library to liblzo2.
> 
> This was tested on SUSE Linux 9.3 without LZO, with LZO 1.08, 2.00 and 2.01.
> 
> -- 
> Matthias Andree
> 

