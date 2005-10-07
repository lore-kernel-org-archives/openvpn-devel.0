Message-ID: <4346A01F.4030106@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>	 <1128428582.7061.18.camel@...399...>	 <4342D092.4050502@...361...> <1128619301.7000.58.camel@...399...>
In-Reply-To: <1128619301.7000.58.camel@...399...>
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
Date: Fri Oct  7 09:21:40 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

Marcelo Toledo wrote:

>We have tested it in two ways:
>
>1. Applied only in the server, worked perfectly with 3 clients. Right
>now we're going to try few hundreds.
>
>2. Applied the patch only in the client, worked well but they couldn't
>see each other.
>
>Should I apply in both or only in the server is enough?
>  
>
Could be a silly question, but to be sure: you had the client-to-client 
option enabled on the server side?

The patch should work both on the client and the server, but for clients 
it hardly does anything at all.

