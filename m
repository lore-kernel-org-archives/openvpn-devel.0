References: <20190613134834.5709-1-arne@...1227...>
 <20190613134834.5709-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4d209552-ca50-974f-6991-92ae1db8fe11@...2080...>
Date: Tue, 25 Jun 2019 22:08:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 3/7] Add generate_ephemeral_key that
 allows a random ephermal key
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
Cc: Arne Schwabe <arne@...515...>

On 13/06/2019 15:48, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This is useful for features that can use enither a persistent
> or an ephemeral key.
> 
> Patch V2: Move the functionality of generating a random key into a
>           separate function that acts as wrapper for pem_read_key_file
> Patch V4: Move wrapper functionality to caller and leave only generate
>           epehermal key functionality in the new function
> ---
>  src/openvpn/crypto.c | 14 ++++++++++++++
>  src/openvpn/crypto.h | 12 +++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)

This looks good ... but one nit-pick, but can be fixed during commit:

> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index c5947483..72244997 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -428,7 +428,17 @@ unsigned int crypto_max_overhead(void);
[....]> +/**
> + * Generate ephermal key material  into the key structure or if
                                                             ^^^^^
This comment don't need those two last words, but that can be fixed during
commit time.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


