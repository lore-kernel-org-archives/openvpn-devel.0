References: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
Date: Wed, 3 Mar 2021 12:56:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 03.03.21 um 08:46 schrieb Tony He:
> Hi Arne,
> 
> I encountered segmentation fault in your dco branch. Master branch is
> OK. I reverted the commit "Linux data-channel offload support", but it
> still happens.
> Anything wrong? Can you reproduce?

OpenVPN without any encryption or TLS is not something I tested.
Consider this obscure mode broken as part of being a preview release.

Thanks for the report.

Arne

