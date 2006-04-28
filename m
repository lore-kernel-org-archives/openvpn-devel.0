From: Roy Marples <uberlord@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Stick routes to interfaces for Linux
References: <200604072030.52833.uberlord@...594...> <200604132240.07989.uberlord@...594...> <20060417172228.GB25449@...619...>
In-Reply-To: <20060417172228.GB25449@...619...>
MIME-Version: 1.0
Message-Id: <200604281128.46146.uberlord@...594...>
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
Date: Fri Apr 28 03:29:20 2006
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Monday 17 April 2006 18:22, Petre Rodan wrote:
> I have the following on the server's setup:
>
> push "route 10.0.0.0 255.255.255.0"
> push "route 0.0.0.0 0.0.0.0"
> push "redirect-gateway local"

.. snip ..

>
> but with a patched beta14 version, I end up having 2 default gateways:
>
> it basically fails to remove my old default gateway.

I don't see that as an error as you're pusing a new gateway "route 0.0.0.0 
0.0.0.0" and you're saying redirect local.

So you would want to do either one or the other.

-- 
Roy Marples <uberlord@...594...>
Gentoo/Linux Developer (baselayout, networking)

