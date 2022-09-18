Message-ID: <913ca50c-1da5-66f7-e8d6-0b51885259a7@...2181...>
Date: Sun, 18 Sep 2022 23:19:57 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220917213154.29285-1-a@...2181...>
 <Yybu8YT8PGGUvDTx@...1296...>
 <abf165f5-ee06-71ec-bfd8-182e1294d5bf@...2181...>
 <YyeADrx4yBHHHh9U@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YyeADrx4yBHHHh9U@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] is_ipv_X: improve packet consistency
 checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 18/09/2022 22:31, Gert Doering wrote:
> Hi,
> 
> On Sun, Sep 18, 2022 at 09:47:56PM +0200, Antonio Quartulli wrote:
>> In the worst case I will only address the second point of the list above
>> (as we may later access an IPv6 header that is not fully allocated).
> 
> I think everything that actually looks further down the header *does*
> check if the size is big enough.  MSS definitely does.
> 

Well, this function has a check like this:

  51         if (BLEN(buf) < sizeof(struct openvpn_iphdr))
  52         {
  53             return false;
  54         }

However this check is assuming that the network header is IPv4.
We don't check if the buffer is long enough to contain an IPv6 header, 
when the packet is IPv6.

The following code is trying to address this issue:

+    /* ensure that there is enough room for a header of the expected 
version */
+    size_t ih_len = 0;
+    switch (eth_ip_proto)
+    {
+        case OPENVPN_ETH_P_IPV4:
+            ih_len = sizeof(struct openvpn_iphdr);
+            break;
+
+        case OPENVPN_ETH_P_IPV6:
+            ih_len = sizeof(struct openvpn_ipv6hdr);
+            break;
+    }
+    if (BLEN(buf) < (offset + ih_len))
+    {
+        return false;
+    }

On the other hand, if we think that proper checks are done later in the 
code, we could remove this check entirely (and only make sure we have 
the required bytes to access the version_len field).

> Why do we care about ethernet types?  What is the problem this check
> is supposed to address?  Does it work for 802.1q packets (different
> ether type)?
> 

The ethernet type is just used to perform a consistency check: if 
Ethernet says the next header is IPv4, but then we have IPv6, this means 
the packet is bogus and should be discarded. (same for the other way around)

Does it make sense?

Cheers,

> gert

-- 
Antonio Quartulli

