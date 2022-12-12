Message-ID: <39b938a3-3431-fdbd-6ab0-a41a70fa3ab8@...1227...>
Date: Mon, 12 Dec 2022 12:56:12 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221126162648.150678-2-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 26.11.22 um 17:26 schrieb Max Fillinger:
> The current code only checks if the base64-encoded metadata is at most
> 980 characters. However, that can encode up to 735 bytes of data, while
> only up to 733 bytes are allowed. When passing 734 or 735 bytes, openvpn
> prints a misleading error message saying that the base64 cannot be
> decoded.
> 
> This patch checks the decoded length to show an accurate error message.
> 
>

Acked-By: Arne Schwabe <arne@...1227...>


