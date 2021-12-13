Message-ID: <54f9e8bc-d53d-094b-f125-850b45dd0037@...1227...>
Date: Mon, 13 Dec 2021 15:09:34 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211213135253.212-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211213135253.212-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH master] config-msvc.h: indicate key
 material export support
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Am 13.12.21 um 14:52 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> MSVC build uses OpenSSL from vcpkg, which at the moment
> is 1.1.1l. Key material export was added to 1.1.1, so it is safe
> to indicate its support unconditionally.
> 
> This enables Windows releases to benefit from tls-ekm
> data channel keys derivation.
> 

Acked-By: Arne Schwabe <arne@...1227...>

