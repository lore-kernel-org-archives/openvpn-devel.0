From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Working with 2.6
Message-ID: <20031119023536.GC21644@...33...>
References: <Pine.LNX.4.58.0311180916570.17332@...136...> <200311181004.25751.matt@...137...> <twig.1069195404.87396@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1069195404.87396@...41...>
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
Date: Tue Nov 18 18:37:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 18 Nov 2003, James Yonan wrote:

> > That should allow openvpn to open the tun interface.
> > If that works, and you can't figure out what lines in the devfs
> > configuration to edit, post to this list and I'll see if I can determine
> > what exactly it is that I changed in the (devfsd) config.
> 
> I'm not running 2.6 yet, but if someone gives me ssh access, I will fix.

I can offer you daytime/evening (European time zones) access on a 2.6 BK
(post -test9) machine if need be, however, I don't see any difficulties
on my 2.6 machine talking to a FreeBSD 4.9 hosted OpenVPN 1.4.2.

I don't use devfs, so my machine may not be what you need.

James, if you still need ssh access, please send your ssh2 public key.

It seems the problem is devfs related (and then might be worked around
with the new --dev-* options).

