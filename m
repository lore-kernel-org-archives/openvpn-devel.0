Date: Mon, 27 Mar 2023 14:09:36 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZCGHgCdMAsIN7BOQ@...2685...>
References: <20230327114937.28246-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230327114937.28246-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
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

On Mon, Mar 27, 2023 at 07:49:37AM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Do not use non-literal initializers for static objects
> - Replace empty initializer {} by {0}
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> To be applied after the test-pkcs11 patch set

Tested MSVC build (in my cmake branch) and verified that this is a
suitable replacement for my earlier attempt to fix same issue.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

