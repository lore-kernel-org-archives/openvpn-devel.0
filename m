Date: Tue, 29 Nov 2022 11:07:16 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4XZ1OBeIwmuC1dN@...2685...>
References: <20221128164932.14252-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221128164932.14252-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] rework INSTALL and README to prepare
 for 2.6 release
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Nov 28, 2022 at 05:49:32PM +0100, Gert Doering wrote:
> Update URLs in README
> 
> Rip out information in INSTALL that is already in PORTS, or is
> printed by "./configure --help"
> 
> Update tun/tap driver information where outdated or incomplete.
> 
> Update build prerequisites, add new linux libraries, add git and
> libtool to developer tools needed, etc.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  INSTALL | 207 ++++++++++++++------------------------------------------
>  README  |   8 +--
>  2 files changed, 56 insertions(+), 159 deletions(-)
> 
> diff --git a/INSTALL b/INSTALL
> index 9db5b645..a899b148 100644
> --- a/INSTALL
> +++ b/INSTALL
[...]
> @@ -303,12 +216,12 @@ For more details:
>    https://packages.ubuntu.com/search?keywords=openvpn
>  
>  In addition, the OpenVPN community provides a best-effort APT repository

If you want to include Fedora here, then need to change "APT repository"
to "package repositories" (and remove "a").

Acked-By: Frank Lichtenheld <frank@...2641...>
if this is fixed.

> -for Debian and Ubuntu:
> +for CentOS/Fedora, Debian and Ubuntu:
>  https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
>  
>  *************************************************************************
>  
> -TUN/TAP Driver Configuration:
> +TUN/TAP Driver References:
>  
>  * Linux 2.6 or higher (with integrated TUN/TAP driver):
>  

Regards,
-- 
  Frank Lichtenheld

