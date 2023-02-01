Date: Wed, 1 Feb 2023 12:56:38 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9pTdgI+T90r6PBz@...2685...>
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230128223421.2207802-5-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] cryptoapi.c: simplify parsing of
 thumbprint hex string
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

On Sat, Jan 28, 2023 at 05:34:21PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/cryptoapi.c | 44 +++++++++++------------------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 6ff4fcb5..9fd5aea9 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -210,49 +210,29 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)

This seems to ask for a unittest.

Regards,
-- 
  Frank Lichtenheld

