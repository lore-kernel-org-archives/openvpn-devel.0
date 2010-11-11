Message-ID: <20101111184911.3669.qmail@...1287...>
Date: Thu, 11 Nov 2010 19:49:11 +0100
From: Peter Stuge <peter@...1287...>
References: <AANLkTinA0-1sAsFh0oo-cmREc+qUBE-2X8d-E7vSVf+s@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTinA0-1sAsFh0oo-cmREc+qUBE-2X8d-E7vSVf+s@...278...>
Subject: Re: [Openvpn-devel] Architecture diagram & Theory of
	Operation	documents
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

john s wolter wrote:
> When it comes to debugging problems inside OpenVPN and other FOSS
> software there is a lack of design information.

I disagree that this is relevant for debugging.


> Architecture diagram & Theory of Operation documents are a minimum
> starting point for those not directly involved in development.

Again, I disagree.

Such documentation is indeed good for some things, but as far as
interaction between PKCS#11 providers and PKCS#11 users I actually
think the need is for *less* documentation. :) There is the PKCS#11
standard, but it doesn't provide much overview, it mostly focuses on
matters relevant for implementation of PKCS#11.

There should be fairly much accessible documentation on PKCS#11
online already.

What Jan describes happening in OpenVPN doesn't make a lot of sense
and is "simply" a bug that should be investigated and fixed.


> Do you have a link to these documents?

Until you or someone else writes them, they don't exist. Indeed your
help with this would be most welcome!


//Peter

