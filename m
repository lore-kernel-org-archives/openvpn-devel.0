Message-ID: <43BEDC3B.3070605@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] feature request: "tcp-nodelay" option
References: <20060104171034.2187.UMEZAWA@...528...>
In-Reply-To: <20060104171034.2187.UMEZAWA@...528...>
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
Date: Fri Jan  6 13:09:11 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: UMEZAWA Takeshi <umezawa@...528...>
Cc: openvpn-devel@lists.sourceforge.net

UMEZAWA Takeshi wrote:

>Hello, all.
>
>It would be nice if we can set TCP_NODELAY socket option for tunnel
>connection when OpenVPN uses TCP transport, in order to achieve smaller
>latency rather than higher throughput.
>
>I think that it is not a good way to set this option in
>create_socket_tcp() (in socket.c), because it also set the option for
>management connection...
>  
>
TCP_NODELAY is supported in 2.1 -- see man page.

James


