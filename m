References: <20200908154157.13809-1-arne@...1227...>
 <20200908154157.13809-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2540f2a5-77b4-0dbd-ab1e-db587a79d1eb@...2181...>
Date: Fri, 19 Mar 2021 16:07:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200908154157.13809-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/4] Document the simple self-signed
 certificate setup in examples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

Minor change below

On 08/09/2020 17:41, Arne Schwabe wrote:
> Also remove the static key setup example as it is less secure and we
> want to avoid it for new setups as we want to slowly deprecate these.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                      |  5 ++++
>  doc/man-sections/examples.rst    | 46 ++++++++++++++++++++------------
>  doc/man-sections/tls-options.rst |  4 +++
>  3 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 6007412c..6ae706c6 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -8,6 +8,11 @@ Certificate pinning/verify peer fingerprint
>      fingerprint of the peer. The option has use a number of
>      SHA256 fingerprints.
>  
> +TLS mode with self-signed certificates
> +    When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` option
> +    become optional. This allows for small OpenVPN setups without setting up
> +    a PKI with Easy-RSA or similar software.
> +
>  New features
>  ------------
>  Client-specific tls-crypt keys (``--tls-crypt-v2``)
> diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
> index 3f494ea4..ae7a49b4 100644
> --- a/doc/man-sections/examples.rst
> +++ b/doc/man-sections/examples.rst
> @@ -60,8 +60,8 @@ that is part of your local subnet for either of the tunnel endpoints,
>  you will get a weird feedback loop.
>  
>  
> -Example 1: A simple tunnel without security
> --------------------------------------------
> +Example 1: A simple tunnel without security (not recommended)
> +-------------------------------------------------------------
>  
>  On bob:
>  ::
> @@ -92,31 +92,41 @@ The ``--verb 9`` option will produce verbose output, similar to the
>  quietly.
>  
>  
> -Example 2: A tunnel with static-key security (i.e. using a pre-shared secret)
> ------------------------------------------------------------------------------
> +Example 2: A tunnel with self-signed certificates and fingerprint
> +-----------------------------------------------------------------
>  
> -First build a static key on bob.
> +First build a self-signed certificate on bob and display its fingerprint.
>  ::
>  
> -   openvpn --genkey --secret key
> +   openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout bob.pem -out bob.pem -nodes -sha256 -days 3650 -subj '/CN=bob'
> +   openssl x509 -noout -sha256 -fingerprint -in bob.pem
>  
> -This command will build a key file called ``key`` (in ascii format). Now
> -copy ``key`` to ``alice.example.com`` over a secure medium such as by using
> -the ``scp``\(1) program.
> +and the same on alice:
> +::
> +
> +   openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout alice.pem -out alice.pem -nodes -sha256 -days 3650 -subj '/CN=alice'
> +   openssl x509 -noout -sha256 -fingerprint -in alice.pem
> +
> +
> +These commands will build a text file called ``bob.pem`` or ``alice.pem`` (in ascii format)
> +that contain both self-signed certificate and key and show the fingerprint of the certificates.
> +Transfer the fingerprints  over a secure medium such as by using
> +the ``scp``\(1) or ``ssh``\(1) program.
>  
>  On bob:
>  ::
>  
> -   openvpn --remote alice.example.com --dev tun1  \
> -            --ifconfig 10.4.0.1 10.4.0.2 --verb 5 \
> -            --secret key
> +   openvpn --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dev tun --dh none \
> +           --cert bob.pem --key bob.pem --cipher AES-256-GCM \
> +           --peer-fingerprint "$fingerprint_of_alices_cert"
>  
>  On alice:
>  ::
>  
> -   openvpn --remote bob.example.com --dev tun1   \
> -           --ifconfig 10.4.0.2 10.4.0.1 --verb 5 \
> -           --secret key
> +   openvpn --remote bob.example.com --tls-client --dev tun1   \
> +           --ifconfig 10.4.0.2 10.4.0.1 --cipher AES-256-GCM  \
> +           --cert alice.pem --key alice.pem
> +           --peer-fingerprint "$fingerprint_of_bobs_cert"
>  
>  Now verify the tunnel is working by pinging across the tunnel.
>  
> @@ -130,9 +140,11 @@ On alice:
>  
>     ping 10.4.0.1
>  
> +Note: This example use a elliptic curve (`secp384`), which allows
> +``--dh`` and to ``none``.

and to -> to be set to

>  
> -Example 3: A tunnel with full TLS-based security
> -------------------------------------------------
> +Example 3: A tunnel with full PKI and TLS-based security
> +--------------------------------------------------------
>  
>  For this test, we will designate ``bob`` as the TLS client and ``alice``
>  as the TLS server.
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index 658300b8..c2bf573f 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -609,6 +609,10 @@ If the option is inlined, ``algo`` is always :code:`SHA256`.
>      11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00
>      </peer-fingerprint>
>  
> +  When the ``--peer-fingerprint`` option is used, specifying a CA with ``--ca`` or ``--capath`` is
> +  optional. This allows the he ``--peer-fingerprint`` to be used as alternative to a PKI with
> +  self-signed certificates for small setups. See the examples section for such a setup.
> +
>  --verify-x509-name args
>    Accept connections only if a host's X.509 name is equal to **name.** The
>    remote host must also pass all other tests of verification.
> 

Rest looks good. Maybe the typ0 can be fixed on the fly upon commit.
In any case, this patch has to wait for the others before being merged.

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

