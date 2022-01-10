Message-ID: <fa42d671-d5ef-4ae5-0262-3129bff1c36d@...1227...>
Date: Mon, 10 Jan 2022 15:43:30 +0100
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
References: <20220110144013.7233-1-a@...2181...>
Content-Language: en-GB
In-Reply-To: <20220110144013.7233-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] doc/ciper-negotiation.rst: avoid
 warning by fixing indentation
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
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.01.22 um 15:40 schrieb Antonio Quartulli:
> Indentation is wrong and triggers the following:
> 
> rst2man.py openvpn.8.rst > openvpn.8
> man-sections/cipher-negotiation.rst:20: (WARNING/2) Definition list ends without a blank line; unexpected unindent.
> rst2man.py openvpn-examples.5.rst > openvpn-examples.5
> rst2html.py openvpn.8.rst > openvpn.8.html
> man-sections/cipher-negotiation.rst:20: (WARNING/2) Definition list ends without a blank line; unexpected unindent.
> 
> Get rid of it.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   doc/man-sections/cipher-negotiation.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
> index efa4c6c9..9bcaed0a 100644
> --- a/doc/man-sections/cipher-negotiation.rst
> +++ b/doc/man-sections/cipher-negotiation.rst
> @@ -16,7 +16,7 @@ with a AUTH_FAILED message (as seen in client log):
>       AUTH: Received control message: AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)
>   
>   OpenVPN 2.5 and later will only allow the ciphers specified in ``--data-ciphers``.
> - If ``--data-ciphers`` is not set the default is :code:`AES-256-GCM:AES-128-GCM`.
> +If ``--data-ciphers`` is not set the default is :code:`AES-256-GCM:AES-128-GCM`.
>   In 2.6 and later the default is changed to
>   :code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when Chacha20-Poly1305 is available.
>   

Acked-By: Arne Schwabe <arne@...1227...>


