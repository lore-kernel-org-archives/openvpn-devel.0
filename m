Message-ID: <30bbca62-0283-ce6a-d8f6-a26b615d5b07@...2181...>
Date: Thu, 5 Oct 2023 23:39:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230905211357.581-1-a@...2181...>
 <CAKuzo_gi9NMH2-N41pigd345mU3nimZCgtndU6TN=zxSYa3Yvg@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_gi9NMH2-N41pigd345mU3nimZCgtndU6TN=zxSYa3Yvg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] man: extend description for
 "dhcp-option DNS" on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 05/10/2023 21:03, Selva Nair wrote:
[cut]

Thanks fr the feedback on the context of the patch.

> That said, I'm not convinced this is the right way to document this. 
> IMO, using "--dhcp-option DNS n.n.n" to set a DNS server not reachable 
> through the tunnel is a misuse of that option on any platform.
> 
> Even on "non-windows" one shouldn't do that as it's very reasonable for 
> a script that handles it to set it on the interface, instead of 
> globally, if the platform permits it. For example, using 
> systemd-resolved on Linux (though I'm not totally sure how exactly 
> interface-specific DNS works in this case).
> 
> So, if at all, why not state that the DNS server specified here should 
> be reachable through the tunnel irrespective of the platform?

Well I simply want to document the current behaviour (we spent a few 
hours debugging this situation because the documentation wasn't clear 
enough).

On Linux at the moment you can pass any DNS and, like you said, the user 
script will do something with it. On Windows, this is not the case and I 
simply want to note this down.

If you think we should accept only VPN-reachable IPs (which may make 
sense, although some people do crazy things and may not like it), then 
we should change the code in order to reject anything that cannot be 
routed through the VPN. But so far OpenVPN has always left the 
responsibility to the user/admin to make sure that all pieces will fit 
together.

So instead of forcing any semantic, I think we should simply document 
what the code does.

Cheers,

> 
> Regards,
> 
> Selva

-- 
Antonio Quartulli

