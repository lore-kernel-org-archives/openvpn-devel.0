Date: Mon, 10 Oct 2022 18:29:26 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y0RIZsRmGXPN6+Zd@...2685...>
References: <20221010154116.1685877-1-arne@...1227...>
 <20221010155515.1687151-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221010155515.1687151-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Ensure only CBC, CFB,
 OFB and AEAD ciphers are considered valid data ciphers
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

On Mon, Oct 10, 2022 at 05:55:15PM +0200, Arne Schwabe wrote:
> Make sure cipher_valid only considered these four operations as valid.

"considers"

> This fixes that somjething like --data-ciphers  AES-256-GCM:AES-128-CCM

"something"

> will start but later fail when trying to use the CCM cipher.
> 
> We say "a supported AEAD" mode in our error since CCM is also an AEAD mode
> but one we support like GCM.

"but not one we support, like GCM" or
"but one we don't support, unlike GCM"

Actual code looks good to me, so
Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

