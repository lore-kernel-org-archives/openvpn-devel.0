Date: Tue, 20 Feb 2024 18:04:26 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZdTbmrcqgTxtmuRx@...2685...>
References: <20240219192822.2477258-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20240219192822.2477258-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Document that auth-user-pass may be
 inlined
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Feb 19, 2024 at 02:28:22PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Commits 7d48d31b, 39619b7f added support for inlining username
> and, optionally, password.
> Add a description of its usage in the man page.

Please reference Github #370 which is the same topic.

> Change-Id: I7a1765661f7676eeba8016024080fd1026220ced
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Does this have to go through gerrit?
> 
>  doc/man-sections/client-options.rst | 11 +++++++++++
>  doc/man-sections/inline-files.rst   |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index b92b1a46..b75fe5bd 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -73,6 +73,17 @@ configuration.
>    If ``up`` is omitted, username/password will be prompted from the
>    console.
>  
> +  This option can also be inlined
> +  ::
> +
> +    <auth-user-pass>
> +    username
> +    [password]
> +    </auth-user-pass>
> +
> +  where password is optional, and will be prompted from the console if
> +  missing.
> +
>    The server configuration must specify an ``--auth-user-pass-verify``
>    script to verify the username/password provided by the client.
>  
> diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files.rst
> index f46301e8..ad02c855 100644
> --- a/doc/man-sections/inline-files.rst
> +++ b/doc/man-sections/inline-files.rst
> @@ -5,7 +5,7 @@ OpenVPN allows including files in the main configuration for the ``--ca``,
>  ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
>  ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
>  ``--auth-gen-token-secret``, ``--peer-fingerprint``, ``--tls-crypt``,
> -``--tls-crypt-v2`` and ``--verify-hash`` options.
> +``--tls-crypt-v2``, ``--verify-hash`` and ``auth-user-pass`` options.

--auth-user-pass for consistency.

Regards,
-- 
  Frank Lichtenheld

