Message-ID: <257522ae-92d0-9b32-1e98-0941a348147b@...1227...>
Date: Sun, 25 Dec 2022 01:23:06 +0100
MIME-Version: 1.0
References: <20221224194253.3202231-1-arne@...1227...>
 <20221224194253.3202231-10-arne@...1227...>
 <Y6eHtDvs+r+A8BSs@...1296...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y6eHtDvs+r+A8BSs@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 9/9] Ignore
 OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
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

Am 25.12.22 um 00:13 schrieb Gert Doering:
> Hi,
> 
> On Sat, Dec 24, 2022 at 08:42:53PM +0100, Arne Schwabe wrote:
>>           buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
>> +        if (mi->context.c2.tls_multi)
>> +        {
>> +            buf_printf(&out, " peer-id=%d", mi->context.c2.tls_multi->peer_id);
>> +        }
> 
> Do I read this right, this will add the peer-id=%d to every single
> log line in p2mp mode?  In DCO mode, this might be a relevant information
> (... for things related to DCO), but in non-DCO mode, it's mostly
> "uninteresting", no?
> 
> I'm all for complete log information, but making the lines too long
> isn't that helpful either...

Yeah. This accidentially slipped into the patch set. I am sorry for 
including it. It was however really helpful for doing the debugging.

Arne


