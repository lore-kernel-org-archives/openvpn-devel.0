Date: Thu, 23 Mar 2023 09:50:44 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZBwS5HanJe1AEgY/@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20230322221456.1660425-1-selva.nair@...277...>
 <20230322221456.1660425-3-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230322221456.1660425-3-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Enable pkcs11 an dtest_pkcs11 in
 github actions
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

On Wed, Mar 22, 2023 at 06:14:56PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Enabled for the Ubuntu 22.04 build (OpenSSL 3) and one of the
>   Ubuntu 20.04 builds (OpenSSL 1.1.1).
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  .github/workflows/build.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Worked in the PR, so
Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

