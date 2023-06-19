Date: Mon, 19 Jun 2023 14:47:07 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJBOS3MkHFEXahtv@...2685...>
References: <20230614102115.138724-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20230614102115.138724-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] dist: add more missing files only
 used in the MSVC build
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
To: openvpn-devel@lists.sourceforge.net

On Wed, Jun 14, 2023 at 12:21:14PM +0200, Frank Lichtenheld wrote:
> So it is possible to build with MSVC from the release
> tarballs.
> 
> Fixes #344.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  build/msvc/msvc-generate/Makefile.am | 1 +
>  src/openvpn/Makefile.am              | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

NAK. More files are missing.

Regards,
-- 
  Frank Lichtenheld

