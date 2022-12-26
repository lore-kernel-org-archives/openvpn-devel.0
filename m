Message-ID: <ec71e35a-b62d-0efb-9899-8a9e4034349e@...1227...>
Date: Mon, 26 Dec 2022 20:50:33 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
 <20210907223126.8440-3-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20210907223126.8440-3-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Use a template for "unsupported
 management commands" error
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 08.09.21 um 00:31 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> The message
> "ERROR: The 'foo' commmand is not supported by current daemon mode"
> is repeatedly used in manage.c. Move it to a function for uniformity
> in messaging.
> 
> v3, v3: no change

Acked-By: Arne Schwabe <arne@...1227...>


This patch currently has a conflict since PF code was removed. I will 
let Gert decide if he wants to adjust the patch or a rebased v4.

