Date: Wed, 10 May 2023 14:39:31 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZFuQg4R7zhyfOYZp@...2685...>
References: <20230510112236.248026-1-frank@...2641...>
 <20230510112236.248026-3-frank@...2641...>
 <ZFuGjLXBS9MTpVdl@...1296...>
MIME-Version: 1.0
In-Reply-To: <ZFuGjLXBS9MTpVdl@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Change type of frame.mss_fix to
 uint16_t
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, May 10, 2023 at 01:57:00PM +0200, Gert Doering wrote:
> Hi,
> 
> On Wed, May 10, 2023 at 01:22:35PM +0200, Frank Lichtenheld wrote:
> >                  }
> > -                mssval = (opt[2]<<8)+opt[3];
> > +                mssval = opt[2] << 8;
> > +                mssval += opt[3];
> 
> Is this an intentional change, or just a side effect of "something
> intermediate"?

This fixes a conversion warning:
../../../src/openvpn/mss.c:196:26: warning:
conversion from ‘int’ to ‘uint16_t’ {aka ‘short unsigned int’} may change value [-Wconversion]
  196 |                 mssval = (opt[2] << 8) + opt[3];
      |                          ^

So basically the compiler goes up to int and then realises it needs
to go back down to uint16_t. By splitting the statement this is avoided.

One could also fix that with casts, but that would be much uglier, IMHO.

> 
> > @@ -7260,6 +7260,7 @@ add_option(struct options *options,
> >              /* value specified, assume encapsulation is not
> >               * included unless "mtu" follows later */
> >              options->ce.mssfix = positive_atoi(p[1]);
> > +            ASSERT(options->ce.mssfix <= UINT16_MAX);
> >              options->ce.mssfix_encap = false;
> >              options->ce.mssfix_default = false;
> 
> This part of the patch is making me unhappy, thus, NAK.  We do have
> a way to signal option errors, and ASSERT() is not...  your code
> would make a client ASSERT() if a server pushes "mssfix 70000".

Okay, will change.

Regards,
-- 
  Frank Lichtenheld

