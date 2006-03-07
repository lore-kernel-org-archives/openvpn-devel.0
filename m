Message-ID: <440DBD44.5060302@...564...>
From: Kosta Welke <kosta@...564...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] float is broken when source port changes
References: <440D05E9.7030203@...564...> <1e6368e80603070813y6d2d144ex3cef3a8a26a02d9@...278...>
In-Reply-To: <1e6368e80603070813y6d2d144ex3cef3a8a26a02d9@...278...>
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
Date: Tue Mar  7 09:05:04 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Leonard Isham <leonard.isham@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Leonard Isham wrote:
> On 3/6/06, Kosta Welke <kosta@...564...> wrote:
>> 04:25:40.379210 IP client.1042 > server.1194: UDP, length 53
>> 04:25:50.641933 IP server.1194 > client.1042: UDP, length 53
>> [connection breaks -> client has same IP thanks to NAT, but other port]
>> 04:25:50.949669 IP client.39630 > server.1194: UDP, length 53
>> 04:26:00.774602 IP server.1194 > client.1042: UDP, length 53
>> 04:26:10.390386 IP client.39630 > server.1194: UDP, length 53
>> 04:26:20.239776 IP server.1194 > client.1042: UDP, length 53

>> the server should have sent those last two packets to client.39630, of
>> course. As it does not, I have to wait for a connection timeout.

> UDP is connectionless so there can be overlap where one side has
> determined there is a dropped connection and the other has not.  Which
> would cause the type of results shown by tcpdump.

I should not detect a connection drop, it should detect an address 
change. Here is an extract from the man page:

"--float when specified with --remote allows an OpenVPN session to 
initially connect to a peer at a known address, however if packets 
arrive from a new address and pass all authentication tests, the new 
address will take control of the session.
Essentially, --float tells OpenVPN to accept authenticated packets from 
any address, not only the address which was specified in the --remote 
option."

(Note that I'm using --float on the server and --remote on the client)

This is exactly what I want. Based on my understanding, it should also 
apply to any combination of ip address and port number changes. Sadly it 
does not. :(

Yours,
Kosta

