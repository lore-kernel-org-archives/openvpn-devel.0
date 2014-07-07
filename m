Message-ID: <53BA5F48.2080303@...1227...>
Date: Mon, 07 Jul 2014 10:50:16 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
	<1402244175-31462-3-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-3-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Add proper check for crypto modes
 (CBC or OFB/CFB)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 08.06.14 18:16, schrieb Steffan Karger:
> OpenSSL has added AEAD-CBC mode ciphers like AES-128-CBC-HMAC-SHA1, which
> have mode EVP_CIPH_CBC_MODE, but require a different API (the AEAD API).
> So, add extra checks to filter out those AEAD-mode ciphers.
>
> Adding these made the crypto library agnostic function cfb_ofb_mode()
> superfuous, so removed that on the go.
>
> Also update all cipher mode checks to use the new cipher_kt_mode_*()
> functions for consistency.
>
>
ACK. Apart from the AEAD changes is also only refactoring.

Arne

