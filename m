Message-ID: <4BBE2E30.2060308@...1114...>
Date: Thu, 08 Apr 2010 21:27:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BBA5672.3090503@...1338...>
In-Reply-To: <4BBA5672.3090503@...1338...>
Subject: Re: [Openvpn-devel] [PATCH-SET v2] VLAN-tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/04/10 23:30, Fabian Knittel wrote:
> Hi,
> 
> I didn't have much time the last few days, but as I'll be without
> Internet access Tuesday through Friday I wanted to push out what I've
> come up with so far.  I've attached the diff between my first
> patch-series and this posting.  If people would prefer to see the
> individual patches in their reworked form, just say so and I'll post
> those in the future.  For now, they're available on the feat_vlan/r12 tag at
> 
> git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git
> 
> or
>   http://opensource.fsmi.uni-karlsruhe.de/cgi-bin/gitweb.cgi?p=openvpn.git
> 
> The changes:
> 
>  * Fixed the valid VID range to be from 1-0xFFFE to 1-4094 (0xFFE).
>    Changed the VID field mask to 0x0FFF. (If someone can explain a
>    use-case for VID=0 to me, I might allow that too.)
> 
>  * "--vlan-tag" was renamed to "--vlan-pvid" and is now also valid in
>    global context (where it configures the PVID for the tap device).
> 
>  * The boolean "--vlan-tagging" option was replaced by
>    "--vlan-accept raw | tagged | untagged | all". "raw" corresponds to
>    the old "no --vlan-tagging" and "tagged" corresponds to the old
>    "--vlan-tagging". "untagged" accepts only untagged (or priority
>    tagged) packets on the tap device. It assumes they belong to the VID
>    set by the global "--vlan-pvid". "all" accepts VLAN-tagged and
>    untagged packets and handles them the way the "tagged" and "untagged"
>    modes would.
> 
>    I'm planning to reintroduce the previous on/off switch and just
>    supplement that with the new "--vlan-accept mode" (which would
>    then only allow you to choose between 'tagged | untagged | all'.
>    The thinking behind the two separate switches would be, that
>    "raw" mode makes OpenVPN behave different on a global level, while
>    "tagged", "untagged" and "all" only change the behaviour regarding
>    the tap device. (In theory, "--vlan-accept" could be made into an
>    instance option, allowing clients to send tagged packets, etc..)
> 
>  * Compile-time switch ("--disable-vlan-tagging" /
>    "--enable-vlan-tagging") to enable/disable the VLAN-tagging feature
>    Default is enabled. When disabled, OpenVPN should behave the same way
>    as in "--vlan-accept raw" mode.
> 
>  * Added a first attempt at documentation to openvpn.8
> 
>  * VLAN-tagged packets coming in via the client links are dropped
>    if "--vlan-accept" is in non-"raw" mode. (Priority-tagged packets
>    aren't affected.)
> 
>  * VLAN-tagged packets coming in through tap, that contain priority
>    information have their priority information preserved and get sent
>    on as priority-tagged packets.  I'm not sure whether this is a good
>    idea though.  The decision is based on whether the PCP-field is
>    non-zero.  I haven't been able to find out what the standard has
>    to say on the matter or what switches typically do in that situation.
> 
>    Linux allows you to do fixed egress and ingress priority tagging
>    (or more precise: mapping from the TOS field), so that would imply
>    changing the IP-header's TOS field.
> 
> 
> Again, the patches have only received light testing so far.  I've tested
> all accept modes though, so there hopefully shouldn't be any obvious
> brown-paper bag bugs.  More thorough testing will hopefully start next week.
> 
> BTW, I'll add Signed-Off-By-lines as soon as I'm a bit more confident in
> the patches. (And ... assuming I don't forget adding the flag, like I
> did this time. :) )
> 
> If you haven't had a thorough look at my previous patch-set yet, I
> strongly suggest you go through my individual patches from my git tree,
> as they're IMHO easier to understand one by one.
> 

I've pulled down your git tree (feat_vlan branch), and published it as
feat_vlan_tagging in the openvpn-testing.git tree.  Currently it has not
been merged into allmerged, before it gets a better review of the latest
changes.  But I'll pull in changes from your tree on request.  Please
provide such a summary as above on pull requests, to get more
information about what's being pulled in.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku+LjAACgkQDC186MBRfrr6TgCeJAVtNUUG88PpW9MHoN0D6kSU
u88AoJSTDabXdSJz6cr5nT0eJk9uht+M
=81KC
-----END PGP SIGNATURE-----

