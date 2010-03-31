Message-ID: <4BB3D6A3.7020207@...1114...>
Date: Thu, 01 Apr 2010 01:11:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: Re: [Openvpn-devel] [RFC][PATCH 0/9] VLAN tagging on TAP devices
 in	OpenVPN server mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/03/10 23:58, Fabian Knittel wrote:
> Hi,
> 
> The patch-set is now based on Davide Guerri's --passtos patch, as it directly
> falls with-in the functionality of my original version and looked like a
> candidate for integration.
> 
> The patches are also available directly via git, see our gitweb at
> 
>   http://opensource.fsmi.uni-karlsruhe.de/cgi-bin/gitweb.cgi?p=openvpn.git;a=shortlog;h=refs/heads/feat_vlan_on_feat_passtos
> 
> The last two patches (add debug logging ...) aren't really intended for
> inclusion.  I haven't looked into proper log levels, so currently the debug
> messages flood at notice priority.  I'm not sure whether the messages should
> be included at all.

Hi!

Thank you very much for your patches!  I'll look into them soon.  The
patches seems to apply nicely against the feat_passtos branch.  I was
worried about a conflict here, until I noticed where you had your roots :)

Those two last debug info patches, I'll skip as you seem not to be
completely ready with them.  So, please clean them up or mark them as
"good" for inclusion when you're confident in them.

One thing, it would be good if you would do your commit with -s
(--signoff).  We've not been strict about this so far, but I would like
to see those sign-off messages.  (I'll make sure the developers
documentation is 'up-to-date' in this matter, as I don't think that's
mentioned now).

> Another question would be whether I should turn the feature into a compile-time
> selectable option.

It's been several discussions about if such features should be #ifdef'ed
or not.  The general consensus of the discussions is that it will most
probably be accepted into a stable tree in the future quicker if it is a
compile-time enablement.

The main argument which I find acceptable, is that if a stability and/or
security issue is found, it would be possible to easily disable all
features and disable them one-by-one to find the offending feature.

> The patch-set has only received light testing up to now, as it was originally
> only intended as a proof of concept.  At this point I'm very interested in
> all kinds of feed-back and would like to determine whether you might be
> interested in integrating something like this in an official OpenVPN release
> at some point.

I'll admit I don't understand too much how the VLAN's really work in
core network code.  But I understand the concept though.  From what I
can judge based on a quick first look, the patches looks fine.  I'll try
to find some time to read through the patches once more.

[* Other reviewers are most welcome to have a look as well! *]

If you could do a bit more testing, also some stress/performance testing
with several VLAN's being tested in parallel, that would be beneficial.

Having all this said, the feature itself seems reasonable for me to
include into OpenVPN, so the missing step is just to mature the code to
be sure we don't cause any regression.  And here some stress/performance
testing will be helpful.  You scare at least me when stating that this
code "was originally only intended as a proof of concept", which is why
I'm not signing off these patches immediately and giving you a feature
branch.  But I'm open for full inclusion!

Again, thanks you very much for your patches and I hope we will get
these them reviewed properly and soon.  And keep us updated on the
progress with your patches!


kind regards,

David Sommerseth


> Fabian Knittel (9):
>   is_ipv4(): add packet length check for 802.1Q packets
>   vlan: Add global --vlan-tagging option
>   vlan: Add per-client --vlan-tag option
>   vlan: Prepend and remove VLAN identifiers on outgoing and incoming
>     frames
>   vlan: Add VLAN identifier to mroute_addr for ethernet addresses
>   vlan: Restrict broadcasts to the sender's VLAN.
>   vlan: Slightly enhance PF's protocol inspection of 802.1Q packets
>   vlan: add debug logging to tagging / untagging
>   vlan: add debug logging to broadcast filter
> 
>  mroute.c  |   20 ++++++++--
>  mroute.h  |    8 +++--
>  multi.c   |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  multi.h   |    5 +++
>  options.c |   34 +++++++++++++++++
>  options.h |    3 ++
>  proto.c   |    3 ++
>  proto.h   |   36 ++++++++++++++++--
>  8 files changed, 210 insertions(+), 20 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuz1qIACgkQDC186MBRfrr+IwCgrG/o46LEEpH9oNOJ9IxTz8Nf
kPoAn0T7k5DnJUNyYOneH0hkdUy/7RyR
=EEbK
-----END PGP SIGNATURE-----

