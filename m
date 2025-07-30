Date: Wed, 30 Jul 2025 11:30:40 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aInmQC2YTsMbCunU@...2685...>
References: <20250729180014.11550-2-sourceforge@...2900...>
MIME-Version: 1.0
In-Reply-To: <20250729180014.11550-2-sourceforge@...2900...>
Subject: Re: [Openvpn-devel] [PATCH] Update systemd service name param to
 match command
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
To: Terrance <sourceforge@...2900...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jul 29, 2025 at 07:00:05PM +0100, Terrance via Openvpn-devel wrote:
> From: Terrance <git@...2900...>
> 
> The service name displays `%I` which invokes systemd's path mangling
> (notably, converting `-` to `/`), suggesting you need to provide an
> encoded parameter (via e.g. `systemd-escape`), but the start command
> itself uses `%i` which doesn't do the conversion.
> 
> This updates the service name to match the start command.

Change makes sense to me. I haven't specifically tested it but it only
changes the description so I don't see how it could break anything.

Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

