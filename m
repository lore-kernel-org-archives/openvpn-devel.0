Message-ID: <81f268ca-10cc-ff0b-1915-f44319ba722b@...1227...>
Date: Sat, 6 Aug 2022 18:55:12 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220627114337.10994-1-frank@...2641...>
 <20220628080814.745-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220628080814.745-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v4] doc: cleanup for --data-ciphers and
 related
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 28.06.22 um 10:08 schrieb Frank Lichtenheld:
> -these two ciphers. When a OpenVPN servers try to use `AES-256-GCM` or
> +these two ciphers. When a OpenVPN server tries to use `AES-256-GCM` or

Fix from one wrong thing to another less wrong %)

I think I wanted to say When OpenVPN servers try. It got corrected to a 
OpenVPN server but should really an OpenVPN server when you use singular.


>    Cipher negotiation is enabled in client-server mode only. I.e. if
> -  ``--mode`` is set to 'server' (server-side, implied by setting
> +  ``--mode`` is set to `server` (server-side, implied by setting
>    ``--server`` ), or if ``--pull`` is specified (client-side, implied by
> -  setting --client).
> +  setting ``--client``).

While that fixes the grammar/syntax the whole paragraph is still wrong 
for 2.6.

Cipher negotiation is available in client-server mode only for versions 
older than 2.6.

> -  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
> -  :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.

I am not sure why this is removed. That is still very true as OpenVPN 
2.4 only understands IV_NCP=2 and if you don't have those two ciphers in 
the list, it breaks NCP with 2.4.

The rest looks good. We can do a follow up patch to correct the P2P NCP 
stuff.

Acked-By: Arne Schwabe <arne@...1227...>

Arne

