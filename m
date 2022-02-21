Message-ID: <d87c452e-adf2-2635-f7cb-ae0844e3e483@...1227...>
Date: Mon, 21 Feb 2022 21:23:23 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220221111933.1314-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220221111933.1314-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] doc: cleanup for --data-ciphers and
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

Am 21.02.22 um 12:19 schrieb Frank Lichtenheld:
> - Fix various formatting inconsistencies
> - Explain what NCP means before using it.
> - Also replace some of the usages of NCP
>    with the clearer "cipher negotiation".
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   doc/man-sections/protocol-options.rst | 34 +++++++++++++--------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
> index 1c6b1200..4af65983 100644
> --- a/doc/man-sections/protocol-options.rst
> +++ b/doc/man-sections/protocol-options.rst
> @@ -73,7 +73,7 @@ configured in a compatible way between both the local and remote side.
>     Starting with 2.6.0, this option is always ignored in TLS mode
>     when it comes to configuring the cipher and will only control the
>     cipher for ``--secret`` pre-shared-key mode (note: this mode is
> -  deprecated strictly not recommended).
> +  deprecated and strictly not recommended).
>   
>     If you wish to specify the cipher to use on the data channel,
>     please see ``--data-ciphers`` (for regular negotiation) and
> @@ -87,8 +87,8 @@ configured in a compatible way between both the local and remote side.
>     Set ``alg`` to :code:`none` to disable encryption.
>   
>   --compress algorithm
> -  **DEPRECATED** Enable a compression algorithm.  Compression is generally
> -  not recommended.  VPN tunnels which use compression are susceptible to
> +  **DEPRECATED** Enable a compression algorithm. Compression is generally
> +  not recommended. VPN tunnels which use compression are susceptible to
>     the VORALCE attack vector. See also the :code:`migrate` parameter below.
>   
>     The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`,
> @@ -191,7 +191,8 @@ configured in a compatible way between both the local and remote side.
>   
>     For servers, the first cipher from ``cipher-list`` that is also
>     supported by the client will be pushed to clients that support cipher
> -  negotiation.
> +  negotiation. (That feature is also called ``Negotiable crypto parameters``
> +  or ``NCP`` for short).

That was actually a decision to leave out NCP out of this document. NCP 
is an internal thing and the documentation does not need to introduce it 
and can just talk about cipher negotitation in a non-specific way.

Arne


