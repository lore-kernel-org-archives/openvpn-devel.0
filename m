Date: Mon, 11 Sep 2023 13:14:45 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZP72pSVMq0+JhKoO@...2685...>
References: <20230728124005.177414-1-frank@...2641...>
 <ZNZP1EQIjFmgTqX1@...1296...>
 <8cbced43-54e2-3f0d-c607-dea2f3def3ae@...1227...>
MIME-Version: 1.0
In-Reply-To: <8cbced43-54e2-3f0d-c607-dea2f3def3ae@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: new workflow to submit scan to
 Coverity Scan service
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
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On Fri, Aug 11, 2023 at 05:35:03PM +0200, Arne Schwabe wrote:
> Am 11.08.23 um 17:12 schrieb Gert Doering:
> > Hi,
> > 
> > generally good, but...
> > 
> > On Fri, Jul 28, 2023 at 02:40:05PM +0200, Frank Lichtenheld wrote:
> > > index 00000000..0620f638
> > > --- /dev/null
> > > +++ b/.github/workflows/coverity-scan.yml
> > > @@ -0,0 +1,45 @@
> > > +name: coverity-scan
> > > +on:
> > > +  schedule:
> > > +    - cron: '0 20 * * *' # Daily at 20:00 UTC
> > > +  workflow_dispatch:
> > 
> > ... not sure this is the best way to approach the run limit, as
> > we can have many days with no commits at all, so we'd waste credits.
> > 
> > Maybe cache the last commit ID and only run coverity if this has
> > changed?  Or run it "on commit", but cache the current day, and only
> > run it again on the next commit that's not on the same day?
> > 
> > (My typical workflow is "you folks queue up patches, and then I find
> > half a day of free time, and go merge&push as many as I can make sense of")
> 
> You can get that behaviour but it is tricky. You have to resort tricks like
> this: https://github.com/orgs/community/discussions/26519 of saving
> something to a cache and then reading the cache on the next run and check if
> something changed. We can probably implement like that and then trigger on
> push too?

I've basically implemented this now in v2 of the patch (just updated to v3 of
cache action). This should address the resource waste concern and also remove
unnecessary noise.

I've still left the action to trigger on schedule instead of push.
I think implementing rate limiting based on push is not worth the effort.
Especially since it would often mean that if you have multiple pushes per
day the end-result is actually likely to be scanned later since the first
pushes eat your rate limit.

If some changes should be scanned immediately you can always trigger the
workflow manually. Otherwise once per day should be fine.

Regards,
-- 
  Frank Lichtenheld

