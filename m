From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN Project Update
Message-ID: <20020917155518.GE18780@...33...>
References: <20020914221924.GA32072@...33...> <200209151916.g8FJGxG17026@...41...>
Mime-Version: 1.0
In-Reply-To: <200209151916.g8FJGxG17026@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=openvpn-devel>
Date: Tue Sep 17 08:57:06 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 15 Sep 2002, James Yonan wrote:

> Well actually "Forking server support" is really a misnomer.  It would
> be better titled "Server support for arbitrary number of connecting
> clients without requiring a separate config file and a
> pre-instantiated daemon for every client, or just "scalability
> support".  xinetd is an interesting idea.  Anyone using xinetd with
> OpenVPN?

I tried and failed, and the problem is that openvpn is not prepared to
be run from xinetd -- it would have to take the socket it is passed in,
rather than trying to opening a new one.

Here's how far I got, it would take openvpn to add an --inetd option,
I'll see if I get that done. Note that server_args is a single line.

service openvpn
{
	type		= UNLISTED
	port		= 5002
	socket_type	= dgram
	protocol	= udp
	wait		= yes
	user		= root
	server		= /usr/local/sbin/openvpn-log
	server_args	= --user vpn --verb 5 --float --dev tun0 --ifconfig 192.168.0.1 192.168.0.129 --up /service/openvpn/script-up --comp-lzo --mlock --secret /service/openvpn/openvpn.key --ping 60
}

-- 
Matthias Andree

