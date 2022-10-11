Date: Tue, 11 Oct 2022 15:56:45 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y0V2Hbq//IYuUp/z@...2685...>
References: <20220625234150.3398864-1-arne@...1227...>
 <20220625234150.3398864-4-arne@...1227...>
 <Yrlr8uhcV0rUMhT6@...2678...>
 <4195890.Lt9SDvczpP@...2664...>
MIME-Version: 1.0
In-Reply-To: <4195890.Lt9SDvczpP@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v3 4/5] Implement a function to
 calculate the default MTU
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Oct 11, 2022 at 03:07:04PM +0200, Heiko Hund wrote:
> On Montag, 27. Juni 2022 10:36:02 CEST Frank Lichtenheld wrote:
> > As mentioned this is true for the specific options configured above.
> > But you can easily also get different values out of this function by
> > changing the options because frame_calculate_payload overhead does
> > not always return the same value.
> 
> I don't get it. It produces the same output for the same input reliably. Do 
> you want to see a test which forces something different to 1420 by modifying 
> the inputs accordingly?

Yes, I would like to know (i.e. having the correct behavior being documented
by a test) what should happen if options->ce.fragment is set, or options->comp.alg.

Because in the code comments it sounds like this will *always* produce 1420, and I don't
actually believed that that is true (although I do not remember whether I actually
tested this or just read the code).

Regards,
-- 
  Frank Lichtenheld

