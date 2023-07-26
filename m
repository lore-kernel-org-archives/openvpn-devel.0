Date: Wed, 26 Jul 2023 11:02:30 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZMDhJgP8ijDjiIn+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20230128215901.2207208-1-selva.nair@...277...>
 <20230128215901.2207208-2-selva.nair@...277...>
 <ZL+hg0TQn5X0AAiZ@...2685...>
 <CAKuzo_i-DaAL93QaFBPggTGVn--VNxGhN4_fDC1qwoTVXTSP=A@...278...>
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i-DaAL93QaFBPggTGVn--VNxGhN4_fDC1qwoTVXTSP=A@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] signal_reset(): combine check and
 reset operations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jul 25, 2023 at 01:42:41PM -0400, Selva Nair wrote:
> On Tue, Jul 25, 2023 at 6:18 AM Frank Lichtenheld <frank@...2641...>
> wrote:
> 
> > On Sat, Jan 28, 2023 at 04:59:01PM -0500, selva.nair@...277... wrote:
> > > From: Selva Nair <selva.nair@...277...>
> > >
> > > - "if (sig == X) signal_reset(sig)" now becomes
> > >   "signal_reset(sig, X)" so that the check and assignment
> > >   can be done in one place where signals are masked.
> > >   This is required to avoid change of signal state between
> > >   check and reset operations.
> > >
> > > - Avoid resetting the signal except when absolutely necessary
> > >   (resetting has the potential of losing signals)
> > >
> > > - In 'pre_init_signal_catch()', when certain low priority signals
> > >   are set to SIG_IGN, clear any pending signals of the same
> > >   type. Also, reset signal at the end of the SIGUSR1 and
> > >   SIGHUP loops where their values are checked instead of later. This
> > >   avoids the need for 'signal_reset()' after SIGHUP or in
> > 'init_instance()'
> > >   which could cause a signal like SIGTERM to be lost.
> > >
> > [...]
> > > diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> > > index cba58276..ad0aa8a2 100644
> > > --- a/src/openvpn/openvpn.c
> > > +++ b/src/openvpn/openvpn.c
> > > @@ -194,7 +194,6 @@ openvpn_main(int argc, char *argv[])
> > >              context_clear_all_except_first_time(&c);
> > >
> > >              /* static signal info object */
> > > -            CLEAR(siginfo_static);
> > >              c.sig = &siginfo_static;
> >
> > Is that actually save? Doesn't that mean that siginfo_static might be
> > used uninitialized?
> >
> 
> siginfo_static is a global variable with no explicit initialization, so it
> is guaranteed to
> get initialized to {0} at start up.

Right.

Stared at code, all makes sense to me. Didn't do any testing specific to the
changes.

Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

