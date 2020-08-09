References: <20200809141922.7853-1-arne@...1227...>
 <20200809141922.7853-2-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <7f40ed5c-247d-efbc-5145-7001f6a1b646@...277...>
Date: Sun, 9 Aug 2020 17:35:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200809141922.7853-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] Document different behaviour of
 dynamic cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

spelling/grammar and some questions ...


On 09/08/2020 15:19, Arne Schwabe wrote:
> This adds a section in the man page that details the various behaviour
> of older client/servers when using OpenVPN 2.5.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                             | 23 +++++++
>   doc/man-sections/cipher-negotiation.rst | 87 +++++++++++++++++++++++++
>   doc/openvpn.8.rst                       |  1 +
>   3 files changed, 111 insertions(+)
>   create mode 100644 doc/man-sections/cipher-negotiation.rst
> 
> diff --git a/Changes.rst b/Changes.rst
> index 37792342..2cfd2ee2 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -29,6 +29,29 @@ Improved Data channel cipher negotiation
>       ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
>       prefers ChaCha20-Poly1305 but uses it only if the client supports it.
>   
> +    See the data channel negotiation section in the manual for more details.
> +
> +Removal of BF-CBC support in default configuration:
> +    By default OpenVPN 2.5 will only accept AES-256-GCM and AES-128-GCM as
> +    data ciphers. OpenVPN 2.4 allows AES-256-GCM,AES-128-GCM and BF-CBC when
> +    no --cipher and --ncp-ption were present. Accepting BF-CBC can be

--ncp-ption ??? --ncp-cipher


> +    enabled by adding
> +
> +        data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC
> +
> +    and when you need to support very old peers also
> +
> +        data-ciphers-fallback BF-CBC
> +
> +    to offer backwards compatiblity with older config an *explicit*

compatibility


> +
> +        cipher BF-CBC
> +
> +    in the configuration will be automatically translated in adding BF-CBC
> +    to the data-ciphers option and setting data-ciphers-fallback to BF-CBC
> +    commands above. We strongly recommend to switching away from BF-CBC to a
> +    more secure cipher.
> +
>   Asynchronous (deferred) authentication support for auth-pam plugin.
>       See src/plugins/auth-pam/README.auth-pam for details.
>   
> diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
> new file mode 100644
> index 00000000..98ce1fec
> --- /dev/null
> +++ b/doc/man-sections/cipher-negotiation.rst
> @@ -0,0 +1,87 @@
> +Data channel cipher negotiation
> +===============================
> +
> +OpenVPN 2.4 and higher have the capability to dynamically negotiate the data cipher that

Is "dynamically" required ?


> +is used to encrypt data packets. This section describes the mechanism in more detail and the
> +different backwards compatibility mechanism with older server and clients.
> +
> +OpenVPN 2.5 and higher behaviour
> +--------------------------------
> +When both client and server are at least running OpenVPN 2.5, that the order of
> +the ciphers of the server's ``--data-ciphers`` is used to pick the the data cipher.
> +That means that the first cipher in that last that is also in the client's

last -> list


> +``--data-ciphers`` list is chosen. If no common cipher is found the client is rejected
> +with a AUTH_FAILED message (as seen in client log):
> +
> +    AUTH: Received control message: AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)
> +
> +OpenVPN 2.5 will only allow the ciphers specified in ``--data-ciphers``. To ensure
> +backwards compatibility also if a cipher is specified using the ``--cipher`` option
> +it is automatically added to this list. If both options are unset the default is
> +:code:`AES-256-GCM:AES-128-GCM`.
> +
> +OpenVPN 2.4 clients
> +-------------------
> +The negotiation support in OpenVPN 2.4 was a first implementation and still had some
> +quirks. Its main goal was "upgrade to AES-256-GCM when possible".
> +An OpenVPN 2.4 client that is build against a crypto library that supports AES in GCM

build -> built


> +mode and does not have ``--ncp-disable`` will always announce support for
> +`AES-256-GCM` and `AES-128-GCM` even if the ``--ncp-ciphers`` option does not inlcude

inlcude -> include


> +those two ciphers. It is therefore recommended to add `AES-256-GCM` and `AES-128-GCM`
> +to the ``--ncp-ciphers`` options to workaround this bug.
> +
> +
> +OpenVPN 3 clients
> +-----------------
> +Clients based on the OpenVPN 3.x library (https://github.com/openvpn/openvpn3/)
> +do not have a configurable ``--ncp-ciphers`` or ``--data-cipher`` option. Instead
> +these clients will announce support for all their supported AEAD ciphers
> +(`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chacha20-Poly1305`).
> +
> +To support OpenVPN 3.x based clients at least one of these ciphers needs to be
> +included in the ``--data-ciphers`` option.

in the server's ``--data-ciphers``
(for clarity)


> +
> +
> +OpenVPN 2.3 clients and older (and clients with ``--ncp-disable``)
> +------------------------------------------------------------------
> +When a client without cipher negotiation support connects to a server the
> +cipher specified with the ``--cipher`` option in the client configuration
> +must be included in the ``--data-ciphers`` option of the server to allow
> +the client to connect. Otherwise the client will be sent the ``AUTH_FAILED``
> +message that indicates no shared cipher.
> +
> +If the client has been configured with the ``--enable-small``
> +:code:``./configure`` argument, using ``data-ciphers-fallback cipher``
> +with the explicit cipher used by the client is necessary.
> +
> +OpenVPN 2.4 server
> +------------------
> +When a client indicates support for `AES-128-GCM` and `AES-256-GCM`
> +(with ``IV_NCP=2``) an OpenVPN 2.4 server will), send the first

server will), send ->
server will send


> +cipher of the ``--ncp-ciphers`` to the OpenVPN client regardless of what

regardless of what cipher is. ->
regardless of what the cipher is.

> +cipher is. To ensure compatibility with behaviour as a client, adding
> +`AES-128-GCM` and `AES-256-GCM` to the ``--data-ciphers`` is required
> +since OpenVPN 2.5+ will only announce the ``IV_NCP=2`` flag if those
> +ciphers are present.


To ensure compatibility with behaviour as a client

I don't really understand the meaning here ..

Do we add those ciphers to the server or client config ?



> +
> +OpenVPN 2.3 and older servers (and servers with ``-ncp-disable``)
> +-----------------------------------------------------------------
> +The cipher used by the server must be included in ``--data-ciphers`` to
> +allow the client connecting to a server without cipher negotiation
> +suppport.

suppport -> support

Again, added to the client or the server config ?


> +(As compatibility OpenVPN 2.5 will also accept the cipher set with
> +``--cipher``)

As compatibility ->
For compatibility   ?


> +
> +If the server has been configured with the ``--enable-small``
> +:code:``./configure` argument, using ``data-ciphers-fallback cipher``
> +with the explicit cipher used by the server is necessary.


Again, added to the client or the server config ?


> +
> +Blowfish in CBC mode (BFB-CBC) deprecation
> +------------------------------------------
> +The ``--cipher`` option defaulted to ``BF-CBC`` in OpenVPN in

extra 'in OpenVPN'


> +OpenVPN 2.4 and older version. The default was never changed
> +to ensure backwards compatibility. In OpenVPN 2.5 this behaviour
> +has now been changed that if the ``--cipher`` is not explicitly

been changed that if ->
been changed so that if


> +set it does not allow the weak ``BF-CBC`` cipher anymore and

anymore -> any more


> +needs to explicitly added as ``--cipher BFC-CBC`` or added to
> +``-data-ciphers``.
> \ No newline at end of file
> diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
> index 4a7ca3aa..db81274f 100644
> --- a/doc/openvpn.8.rst
> +++ b/doc/openvpn.8.rst
> @@ -75,6 +75,7 @@ placed in a configuration file.
>   .. include:: man-sections/client-options.rst
>   .. include:: man-sections/server-options.rst
>   .. include:: man-sections/encryption-options.rst
> +.. include:: man-sections/cipher-negotiation.rst
>   .. include:: man-sections/network-config.rst
>   .. include:: man-sections/script-options.rst
>   .. include:: man-sections/management-options.rst
> 

