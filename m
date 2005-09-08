From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] New subnet topology feature ready for testing
In-Reply-To: <1e6368e80509081126163dce34@...278...>
Message-ID: <Pine.LNX.4.58.0509081353010.12112@...41...>
References: <Pine.LNX.4.58.0509062125110.12112@...41...> 
 <1e6368e805090804304b1d7ae9@...278...>  <Pine.LNX.4.58.0509081103120.12112@...41...>
 <1e6368e80509081126163dce34@...278...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  8 12:59:10 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Leonard Isham <leonard.isham@...277...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Thu, 8 Sep 2005, Leonard Isham wrote:

> On 9/8/05, James Yonan <jim@...41...> wrote:
> > 
> > On Thu, 8 Sep 2005, Leonard Isham wrote:
> > 
> > > On 9/8/05, James Yonan <jim@...41...> wrote:
> > > >
> > > > OpenVPN Addressing Topology
> > > > ---------------------------
> > > >
> > >
> > > > Merging Schedule
> > > > ----------------
> > > >
> > > > With sufficient testing, this code will be a candidate for inclusion in
> > > > 2.1 or higher, and will be applicable to the 2.0.x branch via manual
> > > > merging.  While this patch is not huge, it's deep enough that I don't plan
> > > > on merging it in 2.0.x anytime soon.
> > > >
> > >
> > > I know that I'm putting the cart in front of the horse, but...
> > >
> > > (BTW I couldn't find this on the web site either searchong for
> > > timeline and roadmap.)
> > >
> > > When will 2.1 development start/become publically available?  This is
> > > a feature that I would love to impliment, but the more the current
> > > implimentation grows the harder it gets to change.
> > 
> > Probably a few months at least, though some of the new features, such as
> > the topology directive can be used right now by patching to the 2.0.x
> > branch.
> > 
> > The 2.x wishlist is already becoming quite large:
> > 
> > http://openvpn.net/wiki/OpenVPN_2.x_wishlist
> > 
> > While a lot of these items are small patches, the "big-ticket" items I'm
> > focussing on for 2.1 include:
> > 
> > * topology directive
> > * groups (discussed previously on the list)
> > * support the ability for one OpenVPN daemon to handle
> >  client connections on multiple TCP or UDP ports
> >  simultaneously.
> > * improved IPv6 support
> > 
> > I'd like to wait until we have these three in the bag before starting a
> > 2.1 beta series.
> > 
> 
> Please bear with a  network geek's rambling for a minute.
> 
> 1. There is a windows install available.

Yes.

> 2. the tar file can become an RPM with RPMBuild, correct?

Yes.

> I'd have to deal with:
> 
> 1. Disabling openvpn updates via yum.
> 2. This is a branch that will not be "merged" back in until 2.1 beta.
> 3. 2.0.3 or other updates will not include this unless I figure out
> how to "merge/diff" the patch in, and that may break it.
> 
> I to go with it, but not being a developer fear that not being able to
> merge patches and even complie for windows...

I plan to treat the "TO" (topology-supporting) branch as a beta series
until the 2.1 beta series formally begins -- that means it will be
updated, changes from the 2.0.x branch will get merged in, and when I make
releases, there will always be a .tar.gz, .zip, and Windows installer
.exe.

James


