Message-ID: <52C6BF2B.8010809@...1227...>
Date: Fri, 03 Jan 2014 14:46:19 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20131230205032.GH226@...1296...>	<1388607026-12297-1-git-send-email-steffan@...1856...>
	<1388607026-12297-5-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-5-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] Remove OpenSSL tmp_rsa_callback.
 Removes support for ephemeral RSA in TLS.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 01.01.14 21:10, schrieb Steffan Karger:
> This code would not really generate ephemeral keys every time it is calle=
d,
> but a single key that would be reused during process lifetime and returned
> each time the function was called; probably not what users would expect.
>
> TLS allowes ephemeral keys to be used only when no other key exchange, su=
ch
> as (ephemeral) Diffie-Hellman, is performed. The end result is that it was
> only used by a number of (weak) export ciphers, which could give users a
> false sense of security.
>
> So, instead of fixing a weak cipher mode, we'll just remove support for it
> completely. Plenty of better alternatives are available in TLS.
>
ACK. (reading SSL_CTX_set_tmp_rsa_callback is scary btw).

Arne


