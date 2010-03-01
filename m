From: Enrico Scholz <enrico.scholz@...1291...>
References: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
	<20100228145928.GA14572@...1276...>
Date: Mon, 01 Mar 2010 17:15:01 +0100
In-Reply-To: <20100228145928.GA14572@...1276...> (Till Maas's
	message of "Sun, 28 Feb 2010 15:59:28 +0100")
Message-ID: <ly1vg410je.fsf@...1290...>
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@...1291...>
Subject: Re: [Openvpn-devel] [PATCH] Allow 'lport 0' setup for random port
	binding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Till Maas <till.maas@...519...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Till Maas <till.maas@...519...> writes:

>> |-       if (!legal_ipv4_port (port))
>> |+       if (port != 0 && !legal_ipv4_port (port))
>
> I am pretty sure that it is possible to listen on port 0, 

not on linux; e.g. see in net/ipv4/inet_connection_sock.c the implementation
of

| /* Obtain a reference to a local port for the given sock,
|  * if snum is zero it means select any available local port.
|  */
| int inet_csk_get_port(struct sock *sk, unsigned short snum)

and its caller.  Windoze seems to have a similar mechanism accordingly
http://msdn.microsoft.com/en-us/library/ms737550%28VS.85%29.aspx

| Binding to a specific port number other than port 0 is discouraged for
| client applications since there is a danger of conflicting with
| another socket already using that port number on the local computer.



RFC 768 states

| Source Port is an optional field ... If not used, a value of zero is
| inserted.

which implies that port 0 is something special which is not to be used
for normal communication.




Enrico

