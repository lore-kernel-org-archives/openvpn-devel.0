Date: Wed, 20 Dec 2023 14:38:29 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZYLuVQ8BepVxem62@...2685...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
 <20231220133637.60996-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20231220133637.60996-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v2] tun.c: don't attempt to delete DNS
 and WINS servers if they're not set
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
Cc: Lev Stipakov <lev@...515...>

On Wed, Dec 20, 2023 at 02:36:37PM +0100, Frank Lichtenheld wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Commits
> 
>     1c4a47f7 ("wintun: set adapter properties via interactive service")
>     18826de5 ("Set WINS servers via interactice service")
> 
> added functionality of add/remove DNS/WINS via interactive
> service, which is used mostly by dco-win and wintun (tap-windows6
> normally uses DHCP). There is a check in code - if DNS/WINS addresses
> are not pushed, nothing is added.
> 
> However, due to bug we always attempted to remove DNS/WINS,
> even if nothing was added. Removing WINS, for example, could take
> up to 3 seconds.
> 
> This change fixes this by improving check "has DNS/WINS been pushed?".
> 
> While on it, convert do_XXX_service() functions to "void" from "bool",
> since we never check their return values.
> 
> Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
> Signed-off-by: Lev Stipakov <lev@...515...>
> Acked-by: Frank Lichtenheld <frank@...2641...>
> ---
> 
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.

Should also be merged to release/2.6

Regards,
-- 
  Frank Lichtenheld

