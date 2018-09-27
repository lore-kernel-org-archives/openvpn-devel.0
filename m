References: <20180926134458.20920-1-arne@...1227...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <8a3508d0-c11c-2ec3-4602-ee83c24c7a4b@...68...>
Date: Thu, 27 Sep 2018 22:20:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180926134458.20920-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Add support for tls-ciphersuites for
 TLS 1.3
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
To: openvpn-devel@lists.sourceforge.net

Hi Arne,

I haven't looked at the code, only at strings for now, and I'd like to
pick a few nits.


Am 26.09.18 um 15:44 schrieb Arne Schwabe:
> OpenSSL 1.1.1 introduces a seperate list for TLS 1.3 ciphers. As these
> interfaces are meant to be user facing or not exposed at all and we
> expose the tls-cipher interface, we should also expose tls-cipherlist.
> [...]

> index 15a10296..0b44a29d 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5001,11 +5001,13 @@ determines the derivation of the tunnel session keys.
>  .\"*********************************************************
>  .TP
>  .B \-\-tls\-cipher l
> +.TQ
> +.B \-\-tls\-ciphersuites l
>  A list
>  .B l
>  of allowable TLS ciphers delimited by a colon (":").
>  
> -This setting can be used to ensure that certain cipher suites are used (or
> +These setting can be used to ensure that certain cipher suites are used (or

These setting_s_ ...

>  not used) for the TLS connection.  OpenVPN uses TLS to secure the control
>  channel, over which the keys that are used to protect the actual VPN traffic
>  are exchanged.
> @@ -5014,13 +5016,24 @@ The supplied list of ciphers is (after potential OpenSSL/IANA name translation)
>  simply supplied to the crypto library.  Please see the OpenSSL and/or mbed TLS
>  documentation for details on the cipher list interpretation.
>  
> +For OpenSSL the

add a comma before "the"


> +.B \-\-tls-cipher
> +is used for TLS 1.2 and below. For TLS 1.3 and up

add a comma at the end.


> +the
> +.B \-\-tls\-ciphersuites
> +setting is used. mbed TLS has no TLS 1.3 support yet and only the
> +.B \-\-tls-cipher
> +setting is used.
> +
>  Use
>  .B \-\-show\-tls
>  to see a list of TLS ciphers supported by your crypto library.
>  
>  Warning!
>  .B \-\-tls\-cipher
> -is an expert feature, which \- if used correcly \- can improve the security of
> +and
> +.B \-\-tls\-ciphersuites
> +are expert features, which \- if used correcly \- can improve the security of
>  your VPN connection.  But it is also easy to unwittingly use it to carefully

...use _them_...


> +  msg(M_WARN, "mbed TLS does not support setting tls-ciphersuites. Ignoring TLS 1.3 cipher list: %s", ciphers);
> +}
> +

Is the blank between mbed and TLS right?


Cheers,
Matthias


