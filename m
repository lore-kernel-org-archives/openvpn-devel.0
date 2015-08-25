Message-ID: <55DC0998.8030908@...277...>
Date: Tue, 25 Aug 2015 08:22:16 +0200
From: Jiri Horky <jiri.horky@...277...>
MIME-Version: 1.0
References: <551A5509.702@...277...> <20150824181826.GD34798@...1296...>
	<55DB6DD8.4040203@...277...>
	<20150824211025.GE34798@...1296...>
In-Reply-To: <20150824211025.GE34798@...1296...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: FF Systems <ff-system@...2025...>, openvpn-devel@lists.sourceforge.net

Hi Gert,

thanks for clarifying this.

Cheers
Jirka H.

On 08/24/2015 11:10 PM, Gert Doering wrote:
> Hi,
>
> On Mon, Aug 24, 2015 at 09:17:44PM +0200, Jiri Horky wrote:
>> thanks for the information. I see you effectively increased the size to
>> 1.2k which, as far as I know, will not work for people with dial ups.
> If that wouldn't work, openvpn data transfers would not work either - but
> surprisingly, they do :-) - data packets are 1500+ bytes in size, unless
> specifically told (--link-mtu) to be smaller.  We do cap the control channel
> MTU to a smaller value to give particularily broken setups (like, 1400 MTU
> *and* broken fragments) the chance to push smaller --link-mtu from the
> server.
>
> "Dial-Up", per se, does not imply a smaller-than-1500 MTU - some folks
> do that, for "performance reasons" (reducing MTU actually reduces
> performance, as it increases TCP overhead, but what do I know against
> glossy computer magazine advice...), but even a 574 byte MTU will still
> work *if* fragmentation works.  
>
> Which it normally does in this combination - fragmentation tends to break
> if stupid NAT routers are involved, but "dialup with modem links and 
> 574 mtu" is usually not connected to a NAT router but modem->PC...
>
> But as I said - I'm waiting for feedback.
>
> gert
>


