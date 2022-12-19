Message-ID: <d67c75a4-99cd-83b0-c227-3a01549a26fd@...1227...>
Date: Mon, 19 Dec 2022 13:12:32 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221218195810.1216368-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221218195810.1216368-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Reduce default restart pause to 1 second
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

Am 18.12.22 um 20:58 schrieb selva.nair@...277...:
> +--connect-retry n [max]
>     Wait ``n`` seconds between connection attempts (default :code:`5`).

you were close. but forgot to change the 5 in the next line to also say 1.

Arne

