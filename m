Date: Mon, 28 Nov 2022 11:09:49 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4SI7ZhCsT0wgvv7@...2678...>
References: <20221127203228.3543200-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221127203228.3543200-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add section about common error with
 OpenVPN 2.6 and OpenSSL 3.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Nov 27, 2022 at 09:32:28PM +0100, Arne Schwabe wrote:
> We expect a number of configuration to no longer work with OpenVPN
> 2.6 and OpenSSL 3.0. This section tries to explain the most common
> errors that will come up and how to work around them.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/Changes.rst b/Changes.rst
> index c532d47f0..c470efa6e 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -196,6 +196,90 @@ User-visible Changes
>    software that enumerates interfaces, looking for "broadcast capable?" and
>    expecting certain results.  Normal uses should not see any difference.
>  
> +- The default configuration will no longer allow connection to OpenVPN 2.3.x
> +  or earlier, use the new ``--compat-mode`` option if you need compatibility
> +  with older version. See the manual page for details.

"versions"?

> +
> +Common errors with OpenSSL 3.0 and OpenVPN 2.6
> +----------------------------------------------
> +Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
> +configuration will no longer work. This section will cover the most common
> +error we have seen and explain their reason and temporary workarounds. You

"errors"
"reason" -> "cause" ?

> +should fix the problems since these workaround are not secure and will

"problems" -> "underlying problems as soon as possible"

> +eventually stop working in a future update.
> +
> +- weak SHA1 or MD5 signature on certificates
> +
> +  This will happen on either loading of certificates or on connection
> +  to a server::
> +  
> +      OpenSSL: error:0A00018E:SSL routines::ca md too weak
> +      Cannot load certificate file cert.crt
> +      Exiting due to fatal error
> +
> +  OpenSSL 3.0 no longer allows weak singatures on certificates. You can
> +  downgrade your security to allow  by using ``--tls-cert-profile insecure``

"allow" -> "allow them"

> +  but should replace/regenerate these certificates as soon as possible.
> +
> +
> +- 1024 bit RSA certificates, 1024 bit DH parameters, other weak keys
> +
> +  This happens if you private keys or other cryptographic material that

"you" -> "you use"

> +  does not meet today's cryptographic standards anymore. Messages are
> +  similar to::
> +
> +      OpenSSL: error:0A00018F:SSL routines::ee key too small
> +      OpenSSL: error:1408518A:SSL routines:ssl3_ctx_ctrl:dh key too small
> +  
> +  DH parameters (``--dh``) can be regenerated them with

remove "them"

> +  ``openssl dhparam 2048``. For other cryptographic keys, these keys
> +  and certificates need to regnerate. TLS Security level can be temporarily

"regnerate" -> "be regenerated". But the sentence is still bad due to the
repetition of "regenerate". Don't have a good replacement, though.

> +  lowered until the problem is addressed with ``tls-cert-profile legacy`` or

remove "until the problem is addressed", it is implied anyway.
"--tls-cert-profile" for consistency.

> +  even ``tls-cert-profile insecure``.
> +
> +- Connecting to a OpenVPN 2.3.x server or allowing OpenVPN 2.3.x or earlier
> +  clients
> +
> +  This will normally result in messages like::
> +
> +     OPTIONS ERROR: failed to negotiate cipher with server.  Add the server's cipher ('AES-128-CBC') to --data-ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') if you want to connect to this server.
> +
> +     or
> +
> +     client/127.0.0.1:49954 SENT CONTROL [client]: 'AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)' (status=1)
> +
> +  You can manually add the missing cipher to the ``--data-ciphers`` or use
> +  the ``--compat-mode`` option. Note that these message can also indicate

"messages", or "this"

> +  other cipher configuration. See the data channel cipher negotiation manual

missing "problems"?

> +  for more details (Available online under
> +  https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-negotiation.rst)

Might want to use https://build.openvpn.net/man/openvpn-2.6/openvpn.8.html#data-channel-cipher-negotiation instead?
Doesn't exist yet, but will be created on Alpha release.

> +
> +- Use of a legacy 64bit block ciphers or another deprecated cipher

"another" -> "other"
"cipher" -> "ciphers"

> +
> +  OpenSSL 3.0 no longer a number of insecure and outdated ciphers. Some of

missing "supports"?

> +  these cipehrs are known vulnerable (SWEET32 attack).

"ciphers"

> +
> +  This will typically manifest itself in messages like::
> +
> +      OpenSSL: error:0308010C:digital envelope routines::unsupported
> +      Cipher algorithm 'BF-CBC' not found
> +      Unsupported cipher in --data-ciphers: BF-CBC
> +
> +  If your OpenSSL distribution comes with the legacy provider, it will allow to
> +  load a legacy provider that contains the old providers. In this case you can

"it will allow ..." -> "you can load it to enable support for the old ciphers".
Remove "In this case".

> +  use ``--providers legacy default`` to load the legacy cipher provider.
> +
> +- OpenVPN version not supporting TLS 1.2 or later
> +
> +  The default in OpenVPN 2.6 and also in many distributions is now TLS 1.2.
> +  Connecting to peer that does not support this will results in messages like::

"a peer"

> +
> +    TLS error: Unsupported protocol. This typically indicates that client and server have no common TLS version enabled. This can be caused by mismatched tls-version-min and tls-version-max options on client and server. If your OpenVPN client is between v2.3.6 and v2.3.2 try adding tls-version-min 1.0 to the client configuration to use TLS 1.0+ instead of TLS 1.0 only

Line breaks?

> +    OpenSSL: error:0A000102:SSL routines::unsupported protocol
> +
> +  This can be an OpenVPN 2.3.6 or earlier version. ``compat-version 2.3.0`` will
> +  enable TLS 1.0 support if supported by the OpenSSL distribution. Note that
> +  on some Linux distributions enabling TLS 1.1 or 1.0 is not possible.
>  
>  Overview of changes in 2.5
>  ==========================

Regards,
-- 
  Frank Lichtenheld

