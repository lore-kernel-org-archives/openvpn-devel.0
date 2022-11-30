Date: Wed, 30 Nov 2022 11:41:20 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4czUOv34wnWHUSE@...2685...>
References: <20221127203228.3543200-1-arne@...1227...>
 <20221129113031.3735598-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221129113031.3735598-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add section about common error with
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

Still a few small suggestions. See below. But generally

Acked-By: Frank Lichtenheld <frank@...2641...>

On Tue, Nov 29, 2022 at 12:30:31PM +0100, Arne Schwabe wrote:
> We expect a number of configuration to no longer work with OpenVPN

"configurations"

> 2.6 and OpenSSL 3.0. This section tries to explain the most common
> errors that will come up and how to work around them.
> 
> Patch V2: several mistakes highlighed and suggestions made by Frank
>           included.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/Changes.rst b/Changes.rst
> index f316115f3..39d43a7f4 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -190,6 +190,99 @@ User-visible Changes
>    software that enumerates interfaces, looking for "broadcast capable?" and
>    expecting certain results.  Normal uses should not see any difference.
>  
> +- The default configuration will no longer allow connections to OpenVPN 2.3.x
> +  peer or earlier, use the new ``--compat-mode`` option if you need
> +  compatibility with older versions. See the manual page on the
> +  ``--compat-mode`` for details.
> +
> +Common errors with OpenSSL 3.0 and OpenVPN 2.6
> +----------------------------------------------
> +Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
> +configuration will no longer work. This section will cover the most common

"configurations"

> +causes and error message we have seen and explain their reason and temporary
> +workarounds. You should fix the underlying problems as soon as possible since
> +these workaround are not secure and will eventually stop working in a future
> +update.
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
> +  OpenSSL 3.0 no longer allows weak signatures on certificates. You can
> +  downgrade your security to allow them by using ``--tls-cert-profile insecure``
> +  but should replace/regenerate these certificates as soon as possible.
> +
> +
> +- 1024 bit RSA certificates, 1024 bit DH parameters, other weak keys
> +
> +  This happens if you use private keys or other cryptographic material that
> +  does not meet today's cryptographic standards anymore. Messages are similar
> +  to::
> +
> +      OpenSSL: error:0A00018F:SSL routines::ee key too small
> +      OpenSSL: error:1408518A:SSL routines:ssl3_ctx_ctrl:dh key too small
> +  
> +  DH parameters (``--dh``) can be regenerated with ``openssl dhparam 2048``.
> +  For other cryptographic keys, these keys and certificates need to be
> +  regenerated. TLS Security level can be temporarily lowered with
> +  ``--tls-cert-profile legacy`` or even ``--tls-cert-profile insecure``.
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
> +  You can manually add the missing cipher to the ``--data-ciphers``. The
> +  standard ciphers should be included as well, e.g.
> +  ``--data-ciphers AES-256-GCM:AES-128-GCM:?Chacha20-Poly1305:?AES-128-CBC``.
> +  You can also use the ``--compat-mode`` option. Note that these message may
> +  also indicate other cipher configuration problems. See the data channel
> +  cipher negotiation manual section for more details. (Available online under
> +  https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-negotiation.rst)
> +
> +- Use of a legacy or deprecated cipher (e.g. 64bit block ciphers)
> +
> +  OpenSSL 3.0 no longer supports a number of insecure and outdated ciphers in
> +  its default configuration. Some of these ciphers are known to be vulnerable (SWEET32 attack).
> +
> +  This will typically manifest itself in messages like::
> +
> +      OpenSSL: error:0308010C:digital envelope routines::unsupported
> +      Cipher algorithm 'BF-CBC' not found
> +      Unsupported cipher in --data-ciphers: BF-CBC
> +
> +  If your OpenSSL distribution comes with the legacy provider (see
> +  also ``man OSSL_PROVIDER-legacy``), you can load the OpenSSL legacy provider
> +  that contains the old algorithms. Use ``--providers legacy default`` to load
> +  the OpenSSL legacy provider.

Much redundancy. Maybe

"If your OpenSSL distribution comes with the legacy provider (see
also ``man OSSL_PROVIDER-legacy``), you can load it with ``--providers legacy default``.
This will re-enable the old algorithms."

> +
> +- OpenVPN version not supporting TLS 1.2 or later
> +
> +  The default in OpenVPN 2.6 and also in many distributions is now TLS 1.2 or
> +  later. Connecting to a peer that does not support this will results in
> +  messages like::
> +
> +    TLS error: Unsupported protocol. This typically indicates that client and
> +    server have no common TLS version enabled. This can be caused by mismatched
> +    tls-version-min and tls-version-max options on client and server. If your
> +    OpenVPN client is between v2.3.6 and v2.3.2 try adding tls-version-min 1.0
> +    to the client configuration to use TLS 1.0+ instead of TLS 1.0 only
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

