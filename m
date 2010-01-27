Message-ID: <4B5FFA05.70504@...1299...>
Date: Wed, 27 Jan 2010 21:32:05 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4B5E2895.4030906@...1299...> <1264523745.26411.1@...1207...>
	<4B5F33E4.5080508@...1299...> <4B5FB064.3070308@...1299...>
	<20100127081723.GJ857@...1296...>
In-Reply-To: <20100127081723.GJ857@...1296...>
Subject: Re: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 01/27/2010 09:17 PM, Gert Doering wrote:
> Is this a single server listening on both ports, or is this two independent
> servers?
>
>   

server running openvpn on tcp:1195 and udp:1195

client running openvpn with "nobind".

client connects to server via "remote server.name 1195 tcp", "lsof -ni"
on client shows openvpn is associated with  "*:2222" - ie  "nobind" is
working
client connects to server via "remote server.name 1195 udp", "lsof -ni"
on client shows openvpn is associated with "*:1194" - ie "nobind" is NOT
working

> (For a customer installation, I need a single server to listen on UDP/1194 
> and TCP/443, and as far as I understood so far, this was not possible)
>
>   

Yeah - can't be done. However, my problem is a client problem - you
sound like having a server problem. "nobind" only works in client mode

If you're using tun interfaces,  you'll need to split your pool range
between the two instances.


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


