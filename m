From: Waldemar Brodkorb <wbx@...270...>
Subject: Re: [Openvpn-devel] OpenVPN patch to load tun/tap dynamically
Message-ID: <20050210034342.GB26410@...352...>
References: <200502101302.31213.doconnor@...351...>
Mime-Version: 1.0
In-Reply-To: <200502101302.31213.doconnor@...351...>
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
Date: Wed Feb  9 19:44:33 2005
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Daniel O'Connor <doconnor@...351...>
Cc: openvpn-devel@lists.sourceforge.net, matthias.andree@...83...

Hi,
Daniel O'Connor wrote,

> Hi,
> I have a patch for OpenVPN to attempt to load if_tun.ko/if_tap.ko when the 
> first open attempt fails with either ENOENT or ENXIO. It's FreeBSD only at 
> the moment but I imagine it would work on (at least) NetBSD and OpenBSD too.

No need on OpenBSD. It is in GENERIC and kernel modules are not
used. (most off the time, 99%)
 
bye
    Waldemar

