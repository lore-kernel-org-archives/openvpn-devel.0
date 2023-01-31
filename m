Date: Tue, 31 Jan 2023 11:48:27 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9jx+xrcrids9fgk@...2685...>
References: <20230128215901.2207208-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230128215901.2207208-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Improve signal handling using POSIX
 sigaction
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

On Sat, Jan 28, 2023 at 04:59:00PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Currently we use the old signal API which follows system-V or
> BSD semantics depending on the platform and/or feature-set macros.
> Further, signal has many weaknesses which makes proper masking
> (deferring) of signals during update not possible.
> 
> Improve this:
> 
> - Use sigaction to properly mask signals when modifying.
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

Stared at code intensively. AFAICT this should not change the
general behavior except to be more generally safe.

Only compile+t_client tested.

Regards,
-- 
  Frank Lichtenheld

