Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
	startup on Linux
From: Paul Iadonisi <pri.openvpn@...317...>
In-Reply-To: <Pine.LNX.4.58.0411180452440.6370@...41...>
References: <1100737211.8135.32.camel@...318...>
	 <Pine.LNX.4.61.0411180705550.7280@...210...>
	 <1100764891.19571.15.camel@...318...>
	 <Pine.LNX.4.58.0411180452440.6370@...41...>
Message-Id: <1100803143.19571.48.camel@...318...>
Mime-Version: 1.0
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
Date: Thu Nov 18 10:40:04 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 2004-11-18 at 05:55 -0700, James Yonan wrote:

> The main problem I have with this approach is that it creates a new
> configuration interface for OpenVPN which must be documented and
> maintained.  It also creates problems for people who want to migrate to
> and from the distribution where the alternative interface is supported.

  True, but I wasn't planning on just throwing this over the wall and
abandoning it.  I do plan on documenting this and the making clear that
it is not the stock OpenVPN way of doing things, but Fedora specific.

> Now having said that, I do appreciate that distribution developers want to
> provide a consistent interface to daemon configuration.  But I've also
> observed that most distributions have a line they will not cross as far as
> redefining the details of a particular daemon's configuration format.

  Sometimes true, sometimes not.  Take a gander under the covers at the
(native) configuration for the IPsec (not Openswan) racoon files and how
it's integrated into Fedora Core 2 and 3 for an example of a native
config file that, IMO, is much more complex than OpenVPN's.  Red Hat's
approach actually simplifies it in my mind.  OpenVPN is a bit different
in that the *format* of the config file is actually quite simple and
easy to convert to the ifcfg-* format (well, with the exception of the
'zero or more args' problem that I haven't figured out yet).  So I don't
think it's really at matter of how complex a daemon is, but rather what
it does.  OpenVPN is no different than IPsec with respect to it's
intended purpose (though it does the job much better, IMO :-))
  My approach does (as well as Red Hat's and some others), however,
complicate matters for me if I want to migrate to another distribution.
It does create a sort of lock-in, though clearly not as bad as a
proprietary lock-in (since I can pick apart what Red Hat's done and
figure out the 'native' way of doing things for each app).  Personally,
I don't mind that.  I prefer the consistency within the distribution
that it creates for me.  I don't mind when each OS works differently.  I
actually prefer it when the apps plug-in to the existing architecture of
each OS.

> I think the bottom line is that the portability and stability of the
> configuration spec matters.  In my view one of the largest hurdles that
> open source projects need to overcome in order to become viable is
> achieving a critical mass of documentation.  Now that the OpenVPN project
> has largely attained this, I'm going to be extremely hesistant in
> embracing any kind of config file spec refactoring that would render this
> documentation obsolete.

  But I wouldn't think that the bulk of the documentation is dependent
the actual format of the config file, but rather the description of what
each option does.  That said, I wouldn't expect that this documentation
be changed, anyhow.  Just as I (or Red Hat) wouldn't expect the
documentation for Linux 2.6 IPsec to be modified to accommodate the way
Red Hat has integrated it into its release.
  And that's why in my response to Mathias Sundman, I pretty much
conceded that the OpenVPN tarball is not the place for these scripts,
unless you want to drop them in the contrib dir.  They are probably more
suited for the initscripts package, since that's where all the others
are.
  But I'm not going to tackle trying to get these scripts into
initscripts just yet.  I posted them here to get feedback, which I've
gotten.  I'll spend time on improving the implementation a bit and then
maybe bring it up on fedora-devel-list.  If you have objections to even
that approach, let me know and I'll reconsider.
  I *really* appreciate the contribution you've made with OpenVPN and
wouldn't want to create support headaches for you.  I would hope that
people who use software built into a distribution rely on the
distribution vendor for their first line of support (albeit, only
through the mailing list for Fedora Core since 'this is not a supported
product of Red Hat' ;-)).  I have a looming thought that if I proceed
with and succeed at getting this stuff integrated into initscripts, that
*I'm* going to be that first line of support.  Ugh.  What am I getting
myself into?!

-- 
-Paul Iadonisi
 Senior System Administrator
 Red Hat Certified Engineer / Local Linux Lobbyist
 Ever see a penguin fly?  --  Try Linux.
 GPL all the way: Sell services, don't lease secrets


