Subject: Re: [Openvpn-devel] Many to one TCP question
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083092616.79848@...41...>
In-Reply-To: <408C37BA.5080806@...203...>
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
Date: Tue Apr 27 12:43:10 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lonnie Cumberland <lonnie@...203...>, Openvpn-devel@lists.sourceforge.net

Lonnie Cumberland <lonnie@...203...> said:

> Hello All,
> 
> Well, I've been away from the list for a little while and was wondering 
> if someone could please bring me up to speed on the development of the 
> "Many-to-One" TCP progress?
> 
> It is my understanding that in the OpenVPN 2.0 (early) Beta, that UDP 
> connections can be established in a many to one TAP/TUN interface, but 
> how about the TCP side?

TCP support for multiple-clients going through a single tun/tap interface is
probably not going to be here for a while unless someone sponsors the work. 
The problem is that it's difficult to scale, because TCP connections require
one socket per client, while UDP connections can use a single socket to talk
to any number of clients.  Most OSes lack an efficient API for waiting on the
status of a large number of sockets.  The one notable exception is Linux 2.6
which has the epoll API.  Most application developers get around this
limitation by using multiple threads or processes, where each thread/process
waits on a single socket.  But then you have the inefficiency of a large
number of threads/processes and the interprocess communication overhead
entailed by that.

James


