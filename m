MIME-Version: 1.0
In-Reply-To: <1468314848-11820-1-git-send-email-arne@...1227...>
References: <1468314848-11820-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 12 Jul 2016 11:35:27 +0200
Message-ID: <CAA1AbxJ0+qYoeVu-Z0KRLKAn_DBjQJhG6fQzmiU5XWj4KDS9+w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use AES ciphers in our sample
 configuration files and add a few modern 2.4 examples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Makes sense, feature-ACK.

On Tue, Jul 12, 2016 at 11:14 AM, Arne Schwabe <arne@...1227...> wrote:
> diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
> index fedcbd6..d8dfd96 100644
> --- a/sample/sample-config-files/client.conf
> +++ b/sample/sample-config-files/client.conf
> @@ -110,12 +110,16 @@ tls-auth ta.key 1
>  # Select a cryptographic cipher.
>  # If the cipher option is used on the server
>  # then you must also specify it here.
> -;cipher x
> +# Note that 2.4 client/server will automatically
> +# negoiate AES-256-GCM in TLS mode.
> +# See also the ncp-cipher option in the manpage
> +cipher AES-256-CBC
> +
>

Typo in 'negotiate'.  And was the extra newline on purpose?

>  # Enable compression on the VPN link.
>  # Don't enable this unless it is also
>  # enabled in the server config file.
> -comp-lzo
> +#comp-lzo

Very good, let's disable compression 'by default' in de samples.

> diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
> index c85ca0f..79e1234 100644
> --- a/sample/sample-config-files/server.conf
> +++ b/sample/sample-config-files/server.conf
> @@ -246,14 +246,21 @@ tls-auth ta.key 0 # This file is secret
>  # Select a cryptographic cipher.
>  # This config item must be copied to
>  # the client config file as well.
> -;cipher BF-CBC        # Blowfish (default)
> -;cipher AES-128-CBC   # AES
> -;cipher DES-EDE3-CBC  # Triple-DES
> -
> -# Enable compression on the VPN link.
> +# Note that 2.4 client/server will automatically
> +# negoiate AES-256-GCM in TLS mode.
> +# See also the ncp-cipher option in the manpage
> +cipher AES-256-CBC

Same typo as above.

Apart from the typo's, ACK.

-Steffan

