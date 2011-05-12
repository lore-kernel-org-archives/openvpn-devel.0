Message-ID: <4DCBC87B.40202@...1147...>
Date: Thu, 12 May 2011 13:46:03 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4DCBB9A5.9010409@...1460...>
In-Reply-To: <4DCBB9A5.9010409@...1460...>
Subject: Re: [Openvpn-devel] [Openvpn-users] behavior of remote address with
 more than one A	record
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: William Cooley <william@...1460...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users <openvpn-users@lists.sourceforge.net>

William Cooley wrote:
> I'd like to have a remote address setting that has two A records. The 
> client should randomly try to connect to one of the addresses and if 
> it fails it should either try the other IP address or do a randomize 
> operation on the IP selection again.
> In previous versions of openvpn if you specified a domain that 
> resolved to two or more IP addresses you'd get a long line like
> /RESOLVE: NOTE: vpndomain.com resolves to 2 addresses, choosing one by 
> random/
> and I believe it performed as I described above.
> However it looks like with openvpn 2.1.4 and newer you simply get
> /RESOLVE: NOTE: vpndomain.com resolves to 2 addresses/
> and if it fails to connect to the first IP address it never tries the 
> other address and simply indefinitely tries to connect to the same 
> address.
>
> Was there some type of change in the code that was not mentioned in 
> the changelog? Does any one have more information on this? Is there a 
> setting that can restore this behavior?
>
it's mentioned in the changelog:

* Implemented multi-address DNS expansion on the network field of route
  commands.

  When only a single IP address is desired from a multi-address DNS
  expansion, use the first address rather than a random selection.


but it seems this had the unintentional side-effect , namely what you 
describe.
this is either a bug or it should have been documented better.

cheers,

JJK


