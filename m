Date: Thu, 9 Dec 2021 14:39:50 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <149639180.742902.1639057190751@...2642...>
In-Reply-To: <20211207170211.3275837-13-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-13-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 12/21] Fix datagram_overhead and
 assorted functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:02 geschrieben:
> 
>  
> This function is supposed to calculate the overhead of the protocol
> header (IP/IPv6 + TCP/UDP). But at some point the index that used

FWIW, that point was 30077d1f415b8dc9bd7c8a1ac6a7585136ac6261, AFAICT

commit 30077d1f415b8dc9bd7c8a1ac6a7585136ac6261
Author: Arne Schwabe <arne@...1227...>
Date:   Sat Nov 23 20:57:04 2013 +0100

    Split the PROTO_UDP_xx options into AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.

Acked-By: Frank Lichtenheld <frank@...2641...>

--
Frank Lichtenheld

