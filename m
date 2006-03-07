Message-ID: <1e6368e80603070813y6d2d144ex3cef3a8a26a02d9@...278...>
From: "Leonard Isham" <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] float is broken when source port changes
In-Reply-To: <440D05E9.7030203@...564...>
MIME-Version: 1.0
References: <440D05E9.7030203@...564...>
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
Date: Tue Mar  7 08:14:08 2006
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Kosta Welke <kosta@...564...>
Cc: openvpn-devel@lists.sourceforge.net

On 3/6/06, Kosta Welke <kosta@...564...> wrote:
> Hi!
>
> I really enjoy openvpn. I also found a bug :)
>
> Consider this network layout, float is enabled:
> (client and server are the openvpn client and server)
>
> client -- box1 -- NAT --- server
>         \- box2 -/
>
> The client has an instable connection to both boxes. If a connection
> breaks, it simply uses the other one. openvpn client does this without
> any problem. However, the server fails to update to the new client port.
> Here's what tcpdump on the server says:
>
> 04:25:40.379210 IP client.1042 > server.1194: UDP, length 53
> 04:25:50.641933 IP server.1194 > client.1042: UDP, length 53
> [connection breaks -> client has same IP thanks to NAT, but other port]
> 04:25:50.949669 IP client.39630 > server.1194: UDP, length 53
> 04:26:00.774602 IP server.1194 > client.1042: UDP, length 53
> 04:26:10.390386 IP client.39630 > server.1194: UDP, length 53
> 04:26:20.239776 IP server.1194 > client.1042: UDP, length 53
>
> the server should have sent those last two packets to client.39630, of
> course. As it does not, I have to wait for a connection timeout.
>
> I tried finding the bug myself, however, wherever i looked, both ip
> address and port number were compared, or sockaddr_in was compared,
> which essentially is the same. Any hints how to fix it?
>

OK none of the developers have answered yet so here goes.

UDP is connectionless so there can be overlap where one side has
determined there is a dropped connection and the other has not.  Which
would cause the type of results shown by tcpdump.

Additionally if you are using static keys or allowing duplicate
certificates IIUC there is no mechanism for the server to determine a
UDP connection has been closed/discarded by the client.  TCP on the
other hand is connection oriented and the server will realize the
connection is dropped. HTH

--
Leonard Isham, CISSP
Ostendo non ostento.

