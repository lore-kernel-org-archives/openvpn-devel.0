Date: Mon, 23 Jan 2023 13:17:15 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y856y+uDbKA5vmAn@...2685...>
References: <20230101215109.1521549-6-selva.nair@...277...>
 <20230102194322.1560285-1-selva.nair@...277...>
 <Y7sZHFdSFS8mY3mi@...1296...>
 <CAKuzo_gBo6aSg0ram+-97Zo-es=Adh67K2xrzoYEGpaxXWYPwA@...278...>
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gBo6aSg0ram+-97Zo-es=Adh67K2xrzoYEGpaxXWYPwA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Improve signal handling using
 POSIX sigaction
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
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On Fri, Jan 20, 2023 at 03:44:21PM -0500, Selva Nair wrote:
> On Sun, Jan 8, 2023 at 2:27 PM Gert Doering <gert@...1296...> wrote:
> 
> > Hi,
> >
> > On Mon, Jan 02, 2023 at 02:43:22PM -0500, selva.nair@...277... wrote:
> > > From: Selva Nair <selva.nair@...277...>
> > >
> > > Currently we use the old signal API which follows system-V or
> > > BSD semantics depending on the platform and/or feature-set macros.
> > > Further, signal has many weaknesses which makes proper masking
> > > (blocking) of signals during update not possible.
> >
> > Just for the record - as discussed before, this is considered too
> > intrusive ("needs more testing") for 2.6.0, and can go in early in
> > the 2.7 phase.
> >
> 
> if no one has started reviewing 5/5,  I would like to split this into two
> 
> 1. signal -> sigaction affecting sig.c only
> 2. changes to the way signal reset is done
> 
> #2 involves some decisions, affects the rest of the code, and may elicit
> more comments.
> 
> Otherwise, will wait and see.

I think it unlikely anyone has invested much time into a patch designated for
2.7 at this point in time. And even if, splitting up patches might still be
worthwile, if it reduces the individual complexity.

So I would say: go ahead.

Regards,
-- 
  Frank Lichtenheld

