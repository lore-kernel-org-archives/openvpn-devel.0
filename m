From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 1.3.2 Released
Message-ID: <20021024160113.GA20448@...33...>
References: <200210240241.g9O2f1e15971@...41...>
Mime-Version: 1.0
In-Reply-To: <200210240241.g9O2f1e15971@...41...>
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
Date: Thu Oct 24 09:02:05 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 24 Oct 2002, James Yonan wrote:

> Download:
> 
> https://sourceforge.net/projects/openvpn/
> 
> Change Log:
> 
> * Added FreeBSD 4.1.1+ TUN/TAP driver notes to
>   INSTALL (Matthias Andree).

The FreeBSD port update (to version 1.3.2, you'd guessed that) has just
been committed to the ports tree and will show up on the mirrors soon.

It now features an example start script that shows the user how to load
the "tap" kernel module automatically at boot-up, to avoid "device not
configured" errors. (It's not really more than comments, case and
kldload.)

-- 
Matthias Andree

