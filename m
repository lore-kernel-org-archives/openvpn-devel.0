From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] The use of lzo if OpenSSL has zlib
Message-ID: <20050904170025.GA17528@...33...>
References: <423638938.20050903211124@...450...>
Mime-Version: 1.0
In-Reply-To: <423638938.20050903211124@...450...>
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
Date: Sun Sep  4 10:01:10 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, 03 Sep 2005, mts.spb.suxx@...450... wrote:

>   I did not have lzo's lib and headers before I attempted OpenVPN
>   port, so I had to "./configure --disable-lzo".

So get LZO, compile and install it, then compile OpenVPN.

>   When I ported OpenSSL (long ago) - I ./configure'd it to use zlib.

Doesn't matter. Why would OpenVPN care for zlib?

>   Now, when I use the resulting ssl.lib for OpenVPN (or any other
>   SSL-dependent package) - I have to link with zlib as well (otherwise
>   I get unresolved symbols errors).

Right.

>   What if I port lzo too and use it for OpenVPN configuration?
>   I will still have to link with the zlib, but which compression the
>   OpenVPN daemon will use if lzo is enabled in it's configuration?

If OpenSSL wants zlib, you need to link with it, no matter if LZO is
there or not. LZO is a different compression, not compatible with zlib.

-- 
Matthias Andree

