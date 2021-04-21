References: <20210421134348.1950392-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <762719d6-d87a-5cc3-8c8e-c2108d4416f5@...2181...>
Date: Thu, 22 Apr 2021 01:59:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210421134348.1950392-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/7] Remove --disable-multihome option
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

Hi,

On 21/04/2021 15:43, Arne Schwabe wrote:
> With this change we always build multihome support if the operating
> system supports it.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Shouldn't these go too?

$ grep -rn MULTIHOME
config-msvc.h:13:#define ENABLE_MULTIHOME 1
configure.ac:1155:test "${enable_multihome}" = "yes" &&
AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server
capability])

Otherwise it looks good.

Regards,


-- 
Antonio Quartulli

