Reply-To: openvpn-devel@lists.sourceforge.net
References: <20181024113341.1242-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2c30a581-b699-150f-2dc8-309e15860f27@...2080...>
Date: Fri, 26 Oct 2018 13:31:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181024113341.1242-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Document comp-lzo no and compress being
 incompatible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 24/10/18 13:33, Arne Schwabe wrote:
> Most of the new compress but not v2 version do use swap operation. For
> 'compress lzo' the swap option is not used for backwards compatibility.
> For lz4 the swap option is also not a problem since there is no version
> without swap. Unfortunately, compress introduced a second stub format
> with swap, contrary to the one in 'comp-lzo no' that does not use swap.
> 
> Document this weirdness to let not others fall into this trap.
> ---
>  doc/openvpn.8 | 3 +++
>  1 file changed, 3 insertions(+)

This patch does not apply to git master .... which commit is this based on?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


