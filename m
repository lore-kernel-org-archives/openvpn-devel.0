Date: Wed, 19 Dec 2012 23:13:05 +0100
From: Jeremie Le Hen <jeremie@...1793...>
Message-ID: <20121219221305.GS23292@...1794...>
References: <20121217220355.GB23292@...1794...>
	<20121219212619.GN22465@...1296...>
MIME-Version: 1.0
In-Reply-To: <20121219212619.GN22465@...1296...>
Subject: Re: [Openvpn-devel] Fixing "passtos" on !Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

Hi Gert,

On Wed, Dec 19, 2012 at 10:26:20PM +0100, Gert Doering wrote:
> 
> On Mon, Dec 17, 2012 at 11:03:55PM +0100, Jeremie Le Hen wrote:
> > I thereby kindly ask you to bring this patch in the source tree.  I
> > don't know about your release procedure, but it would be really nice if
> > it could hit the tree before 2.3 is released.
> 
> Thanks for the excessive links to documentation - it helps verifying
> things.  I agree that this is a useful last-minute correction and should
> go in (feature-ACK).
> 
> I don't particularily like the way your patch is coded, though, as it's
> "all of them but Linux" that have "int" here (except Windows, which uses
> DWORD, but the docs say "use QoS API instead") - too many #ifdefs.
> 
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms738586(v=vs.85).aspx
> 
> so I'd propose to #ifdef it differently, patch appended.

Your patch looks fine to me.  I went that way because I grep'ed the
source for TARGET_ and saw similar occurences of what I did, though each
part contained more lines :).

Thanks for your review.
Regards,
-- 
Jeremie Le Hen

Scientists say the world is made up of Protons, Neutrons and Electrons.
They forgot to mention Morons.

