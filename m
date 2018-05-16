MIME-Version: 1.0
Date: Wed, 16 May 2018 11:26:15 -0700
From: Scott Shambarger <devel@...2399...>
In-Reply-To: <20180516121616.GO1207@...1296...>
References: <2f575943f32de2328843b3cec3286ca1@...2399...>
 <20180516121616.GO1207@...1296...>
Message-ID: <e47e242be0df9e29aa850d658a52149b@...2399...>
Subject: Re: [Openvpn-devel] Darwin tap ipv6 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 2018-05-16 05:16, Gert Doering wrote:
> 
> This part will break routes that need to go over the LAN interface, not
> over the tap interface - namely, the /128 that is installed if you
> have overlapping v6-over-v6 setups (... if you have link-local next
> hops).
> 

Are you sure it won't work? There's some code higher up in the function 
that appears to handle that case:

#ifndef _WIN32
     if (r6->iface != NULL)              /* vpn server special route */
     {
         device = r6->iface;
         if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
         {
             gateway_needed = true;
         }
     }
#endif

I'll test it on my build if you can point me towards an example...

> So NAK on the patch "as is" - for the rest, I'll look into it next 
> week.

Thanks!
Scott

