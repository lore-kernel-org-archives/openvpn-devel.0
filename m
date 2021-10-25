References: <20211025145314.23009-1-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <15614158-4a67-7f28-9568-1325bbda2b89@...1227...>
Date: Mon, 25 Oct 2021 17:07:55 +0200
MIME-Version: 1.0
In-Reply-To: <20211025145314.23009-1-maximilian.fillinger@...2507...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Don't manually free DH params in
 OpenSSL 3
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 25.10.21 um 16:53 schrieb Max Fillinger:
> When the EVP_PKEY object with the Diffie-Hellman parameters is passed
> to SSL_CTX_set0_tmp_dh_pkey, it does not create a copy but stores the
> pointer in the SSL_CTX. Therefore, we should not free it.
> 
> The EVP_PKEY will be freed automatically when we free the SSL_CTX.
> 

Yes. The set0 indicates that it does a direct reference.

Acked-By: Arne Schwabe <arne@...1227...>

