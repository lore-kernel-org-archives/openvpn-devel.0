Message-ID: <44ce157b-9742-f156-7245-fc6132332962@...1227...>
Date: Mon, 12 Dec 2022 12:54:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221126162648.150678-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Correct tls-crypt-v2 metadata
 length in man page
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
> The manual page claims that the client metadata can be up to 735 bytes
> (encoded as upt to 980 characters base64), but the actual maximum length
> is 733 bytes which is also encoded as 980 characters in base64.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

Acked-By: Arne Schwabe <arne@...1227...>


