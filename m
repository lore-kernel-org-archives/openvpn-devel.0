Message-ID: <18edbb2b-475d-36e5-9d7a-0355afb4e673@...1227...>
Date: Sat, 12 Feb 2022 01:32:07 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220210162632.3309974-1-arne@...1227...>
 <20220210162632.3309974-3-arne@...1227...> <YgZIKSDaeZjKDYLD@...1296...>
 <YgZJd5GpPFsuCPgV@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YgZJd5GpPFsuCPgV@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4 3/8] Add mtu paramter to --fragment
 and change fragment calculation
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


> ... moves the crash onward to
> 
> 0x00005555555891b6 in datagram_overhead (proto=<error reading variable: Cannot access memory at address 0x24>, af=10) at socket.h:617
> 617         overhead += (proto == PROTO_UDP) ? 8 : 20;
> (gdb) where
> #0  0x00005555555891b6 in datagram_overhead (proto=<error reading variable: Cannot access memory at address 0x24>, af=10) at socket.h:617
> #1  get_ip_encap_overhead (lsi=0x0, options=0x555555642280) at mss.c:248
> #2  frame_calculate_mssfix (lsi=0x0, options=0x555555642280, kt=0x555555642b40, frame=0x555555642dd0) at mss.c:305
> #3  frame_calculate_dynamic (frame=frame@...1851...=0x555555642dd0, kt=kt@...1851...=0x555555642b40, options=options@...1851...=0x555555642280, lsi=0x0)
>      at mss.c:334
> #4  0x000055555557b2bb in init_instance (c=c@...1851...=0x555555642280, env=<optimized out>, flags=flags@...1851...=10) at init.c:4234
> #5  0x000055555557c4a6 in inherit_context_child (dest=dest@...1851...=0x555555642280, src=src@...1851...=0x7fffffffc4b0) at init.c:4459
> 
> which looks weird, but is likely due to inlining.
> 
> 
> The culprit is this one:
> 
>      return datagram_overhead(af, lsi->proto);
> 
> "lsi" is still NULL...
> 
> Not sure how to fix this in a good way.
> 

This function is called to early now and doesn't anything useful anymore 
apart when used in --static/crypto none context. So I changed it to not 
crash in these cases and added a comment that the call is superflous for 
most of OpenVPN's operation. If we at some point remove --static/no 
crypto (non TLS modes), we can do a lot of cleanup.

Arne

