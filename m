From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] TUN Server: Suggested IP allocation change
In-Reply-To: <BAY19-F4e8tlMazUSxv0000c938@...160...>
Message-ID: <Pine.LNX.4.61.0411141708280.28677@...210...>
References: <BAY19-F4e8tlMazUSxv0000c938@...160...>
MIME-Version: 1.0
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
Date: Sun Nov 14 08:18:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: die pes <diepes@...160...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 14 Nov 2004, die pes wrote:

> Hi I tried Openvpn and it worked great, hardest part is setting up the pki.
>
> Problem with openvpn routing.
>
> Currently for IP routing using the tun device, each client is assigned a /30 
> subnet.  This does not make sence as the server has only a single IP.  (Could 
> work if individual interface created on server with unique IP for each)
>
> I suggest we simplify it into a point to multipoint setup with /32 mask per 
> client.

It's done this way to be compatible with windows, which does not support 
true PtP interfaces.

I think the new option --ifconfig-pool-linear introduced with beta12, does 
what you want, but you loose windows compatibility.

You could also use tap and bridging which only occupies one address per 
client, but then you have the drawback of the extra overhead...

-- 
_________________________________________________________
Mathias Sundman              (^)   ASCII Ribbon Campaign
NILINGS AB                    X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28      / \   NO Word docs in e-mail

