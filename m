From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Openvpn for RH62 - eek!
Message-ID: <20030502160513.GA29245@...33...>
References: <3EB1726A.4000700@...7...> <200305020432.h424WN105246@...41...>
Mime-Version: 1.0
In-Reply-To: <200305020432.h424WN105246@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May  2 09:15:17 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Fri, 02 May 2003, James Yonan wrote:

> How do most other initialization scripts handle the differences between bash 1
> and 2?  Do they just restrict themselves to the least common denominator (a)?

Yes. /bin/sh is standardized; Solaris for some strange reason ship
b0rked year-old stuff though (they may need /usr/xpg4/bin/sh -- but
that's a different matter). OTOH, init scripts don't need real
processing work, so getting them to fly with the rotten Solaris /bin/sh
is feasible and should be done. If it works there, it'll most likely
work anywhere else as well :-)

> Or do they try to explicitly instantiate bash2 (b)?
> 
> -#!/bin/sh
> +#!/bin/bash2
> (b) could be risky if there are distros where where /bin/bash2 is not present.

It is indeed harmful, it will actually break SuSE and FreeBSD. I know
systems that don't have bash at all, but just pdksh...

