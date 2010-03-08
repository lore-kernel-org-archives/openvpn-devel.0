Date: Mon, 08 Mar 2010 10:47:14 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B950E0B.1030908@...41...> <20100308164010.17629.qmail@...1287...>
In-Reply-To: <20100308164010.17629.qmail@...1287...> (from peter@...1287... on
	Mon Mar  8 10:40:10 2010)
Message-Id: <1268066834.17518.4@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Linux tun/tap performance issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/08/2010 10:40:10 AM, Peter Stuge wrote:
> James Yonan wrote:
> > all of the CPU-intensive cryptographic operations are being done in
> > user space.
>=20
> Could some kind of crypto acceleration of OpenSSL be in play?

Particularly in combination with context switching overhead
going back and forth from kernel to userspace?  It's the
kernel that has to do all the copying, right?  I remember having
thoughts along these lines when benchmarking.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


