MIME-Version: 1.0
References: <1551240310-11735-1-git-send-email-selva.nair@...277...>
 <1564346061-5683-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1564346061-5683-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 23 Sep 2019 09:10:48 -0400
Message-ID: <CAKuzo_iD6qT6FnsmK5nDfu0gjvDdtjty6pY4+uddXkGWLMPD+A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 for 2.4] Handle PSS padding in
 cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jul 28, 2019 at 4:34 PM <selva.nair@...277...> wrote:
>
> From: Selva Nair <selva.nair@...277...>
>
> For PSS padding, CNG requires the digest to be signed
> and the digest algorithm in use, which are not accessible
> via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
> This patch uses the EVP_KEY interface to hook to
> evp_pkey_sign callback if OpenSSL version is > 1.1.0.
>
> Mapping of OpenSSL hash algorithm types to CNG is moved
> to a function for code-reuse.
>
> To test, both the server and client should be built with
> OpenSSL 1.1.1 and use TLS version >= 1.2
>
> Tested on Windows 7 client against a Linux server.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> v2: rebased to release/2.4 after siglen -> *siglen change

As this is required for cryptoapicert +  OpenSSL 1.1.1,
nudging for a review and have it included in the next release.

We have already merged this into git master, but the patch here
is slightly different because of context differences and code
refactorings in 2.5.

Thanks,

Selva

