Subject: Re: [Openvpn-devel] OpenVPN multi instancing
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078255119.33941@...41...>
In-Reply-To: <20040302121623.4177df8a.lademann@...76...>
References: <twig.1078170122.8125@...41...> <twig.1078170122.8125@...41...> <twig.1078182908.84967@...41...> <Pine.LNX.4.58.0403011745030.30913@...136...>, <Pine.LNX.4.58.0403011745030.30913@...136...>
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
Date: Tue Mar  2 11:24:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lademann@...76..., openvpn-devel@lists.sourceforge.net

Christian Lademann <lademann@...76...> said:

> Hello, James hello, Christian,
> 
> is it also going to be supported in 2.0 to have multiple tup/tap interfaces
> but only a single TCP-port on the server side waiting for incoming connections?

The ultimate goal is to have all connection options open in either
point-to-point or point-to-multipoint mode.  The initial 2.0 beta will
specialize in serving multiple clients on a single UDP port, single tun/tap
interface, and single config file.

Actually if you want single TCP-port, one tun/tap interface per client, that
sounds like the inetd-based forking server model which is already functional
(in a limited sense) in the 1.6 beta series.  The limitation is that you use
SSL/TLS + bridging.  See the FAQ for more info.

James


