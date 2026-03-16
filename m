Message-ID: <8573cf46-0e95-41ee-bb9f-53138747ff45@...1227...>
Date: Mon, 16 Mar 2026 12:57:35 +0100
MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315184337.1541272-2-luca.boccassi@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20260315184337.1541272-2-luca.boccassi@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Increase TLS_CHANNEL_BUF_SIZE from
 2048 to 8192
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
To: luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net

Am 15.03.26 um 19:39 schrieb luca.boccassi@...277...:
> From: Luca Boccassi <luca.boccassi@...277...>
> 
> When authenticating via a JWT token 2048 bytes are not enough, which
> breaks the auth process. In my local case the token is ~2100 bytes.
> Bump the maximum harcoded size from 2k to 8k to leave some headroom.

This is a change that can break compability. The normal limit is only 
128 bw.

#define USER_PASS_LEN 128

Overall things like such big data should really be implemented via 
auth-pending method or similar.

Arne

