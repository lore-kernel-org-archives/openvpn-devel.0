Date: Tue, 26 Apr 2022 12:26:46 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1663168327.417964.1650968806604@...2642...>
In-Reply-To: <20220422142953.3805364-11-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-11-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 20/28] Change reliable_get_buf_sequenced
 to reliable_get_entry_sequenced
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

Acked-By: Frank Lichtenheld <frank@...2641...>

Trivial change. Applies on top of 15/28 (probably sooner, but this is the one
I tested).
Only compile/UT tested.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This returns not just the buffer of a reliable_entry but the whole
> entry. This allows the caller to also inspect the original opcode
> and packet id.
> ---
>  src/openvpn/reliable.c | 6 +++---
>  src/openvpn/reliable.h | 7 +++----
>  src/openvpn/ssl.c      | 7 ++++---
>  3 files changed, 10 insertions(+), 10 deletions(-)

Regards,
--
Frank Lichtenheld

