Date: Thu, 31 Jul 2025 14:25:31 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aItguw1MYN+mq+15@...2685...>
References: <20250729180014.11550-2-sourceforge@...2900...>
 <13e422be-28c8-4d4e-b21f-8baa757a6761@...2669...>
MIME-Version: 1.0
In-Reply-To: <13e422be-28c8-4d4e-b21f-8baa757a6761@...2669...>
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Jul 30, 2025 at 02:16:43PM +0200, Timo Rothenpieler wrote:
> On 29/07/2025 20:00, Terrance via Openvpn-devel wrote:
> > From: Terrance <git@...2900...>
> > 
> > The service name displays `%I` which invokes systemd's path mangling
> > (notably, converting `-` to `/`), suggesting you need to provide an
> > encoded parameter (via e.g. `systemd-escape`), but the start command
> > itself uses `%i` which doesn't do the conversion.
> > 
> > This updates the service name to match the start command.
> 
> This makes me wonder if it isn't the one passed to the start command that's
> actually not what it was intended to be.
> 
> Cause using %I there would enable to put configs in subdirs. With %i that's
> impossible, since it can't contain slashes.

Yes, I agree. I think %I would have been better to use exactly for the reason
you mention. But I think it is too late now. If we would switch to %I now it
would break existing configs.

Regards,
-- 
  Frank Lichtenheld

