References: <20210408133626.29232-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <57f54ffd-4da5-376e-66f8-bd1628474903@...2181...>
Date: Sun, 18 Apr 2021 21:20:08 +0200
MIME-Version: 1.0
In-Reply-To: <20210408133626.29232-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Ensure using const variables with
 EVP_PKEY_get0_*
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

On 08/04/2021 15:36, Arne Schwabe wrote:
> These functions return const pointers in OpenSSL 3.0.0alpha14, so
> our pointers should be also const to avoid casting the const away.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


Trivial change. No behaviour is expected to be modified by this.

This change improves implicit code documentation (thanks to the OpenSSL
devs).

Compiled tested against various LibreSSL/OpenSSL versions and none
complained about the const.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

