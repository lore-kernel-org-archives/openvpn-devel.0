Date: Mon, 28 Apr 2025 14:38:38 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aA92znR5RjV5Pe5f@...2685...>
References: <20250426121903.67930-1-kn@...2273...>
MIME-Version: 1.0
In-Reply-To: <20250426121903.67930-1-kn@...2273...>
Subject: Re: [Openvpn-devel] [PATCH] Fix tmp-dir documentation
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
To: Klemens Nanni <kn@...2273...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Apr 26, 2025 at 03:19:03PM +0300, Klemens Nanni wrote:
> Mention its default (on non-Windows systems), rephrase for brevity, fix
> grammar, correct the module environment variable name and remove a wrong
> default mentioned in a related option.
> ---
>  doc/man-sections/generic-options.rst | 11 +++++------
>  doc/man-sections/script-options.rst  |  8 +++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)

Acked-by: Frank Lichtenheld <frank@...2641...>

Comparing to the source code this looks correct to me.

Regards,
-- 
  Frank Lichtenheld

