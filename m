From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN multi instancing
Message-ID: <20040302100927.GC7417@...33...>
References: <200402291538.45014.cd@...154...>
Mime-Version: 1.0
In-Reply-To: <200402291538.45014.cd@...154...>
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
Date: Tue Mar  2 02:16:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 29 Feb 2004, Christian Daniel wrote:

> Hello everybody!
> 
> For a student research project I'm trying to add multi instance capability to 
> OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all 
> variables in a struct and then have only one select()-call for all open 
> tunnels at once.

Oh. You're in for plentiful fun with the various select()
"features"^Wbugs across the various operating system kernels.

Better check out poll() and epoll() where available. These happen to
(usually) be more scalable as the number of fds increases.

> Each tunnel should have it's own tun/tap-device open - the linux kernel has no 
> problem to cope with so many interfaces... I don't think, that it's a good 
> idea, to create only one tun-device and then have some kind of internal 
> routing-engine...

It cannot work. The interfaces have distinct addresses and netmasks, for
some kind of internal routing-engine, you'd have to re-implement the
stack on top of raw sockets. Not easy, not portable, not desirable.

> - how to handle the garbage collection? Is it really necessary or is the code 
> leak-free?

<ducks>go figure as a side project, going to fill your thesis or
homework or whatever other paper or PDF you're going to turn in. :-)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

