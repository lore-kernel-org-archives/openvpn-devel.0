Date: Tue, 18 Apr 2023 16:21:55 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZD6ng5HDMRbQQR0n@...2685...>
References: <20230418134011.1752777-1-selva.nair@...277...>
 <20230418141446.1755363-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230418141446.1755363-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Format Windows error message in
 Unicode
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

On Tue, Apr 18, 2023 at 10:14:46AM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - We assume that all text passed to the management interface
>   and written to log file are in Unicode (UTF-8). This is broken by
>   the use of the ANSI version of FormatMessage() for Windows error
>   messages. Fix by using FormatMessageW() and converting the UTF-16
>   result to UTF-8.
> 
> v2: assign return value of FormatMessageW() to DWORD, not int
> 
> Github: fixes OpenVPN/openvpn#319
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/error.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Looks good to me.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

