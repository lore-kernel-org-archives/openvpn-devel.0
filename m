Message-ID: <4BB48E1B.9080303@...1114...>
Date: Thu, 01 Apr 2010 14:14:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<4BB3D6A3.7020207@...1114...>	<4BB45A07.5060300@...1338...>	<4BB45E4B.1000106@...1114...>
	<4BB48A89.3090608@...1338...>
In-Reply-To: <4BB48A89.3090608@...1338...>
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

On 01/04/10 13:59, Fabian Knittel wrote:
> David Sommerseth schrieb:
>> On 01/04/10 10:32, Fabian Knittel wrote:
>>> We'll definitely be doing that over here.  My main concern was whether
>>> we would have to patch OpenVPN indefinitely with local enhancements or
>>> whether there was a chance to include it upstream.  And now that things
>>> look quite positive, we can go forward with the chosen approach. :)
>>
>> Thanks a lot!  This really will help us a lot.  If you even dare to try
>> a local merge against the 'allmerged' branch when you do some bigger
>> tests, that would also be very much appreciated.
>
> OK. I assume feat_passtos isn't merged into allmerged yet, right?  I'll
> probably pluck Davide Guerri's patch from feat_passtos and do the
> testing together with my vlan patches on allmerged. (Assuming things
> don't explode too badly on allmerged :).)

No, the feat_passtos is awaiting testing before getting merged into
allmerged.  So it's just for you to get a glimpse of what I might
complain about when I do the main merges.  I will always be the one
doing the official merges into allmerged, but please test that on your
own work as well - or else I'll haunt you afterwards when conflicts
appears ;-)

>> Btw!  How is it with IPv6 and your patches?  We have quite some patches
>> for that in the tree already.  And as I see you patch in the [PATCH 1/9]
>> the is_ipv4() function, you might want to be sure this will also work in
>> the IPv6 world as well.
>
> AFAICS, IPv6 support for tap should only come into the picture when we
> attempt to inspect the packets for specific purposes, like packet
> filtering or retrieving the packet's priority (TOS in IPv4).  So
> although the patches don't yet explicitly handle IPv6, I don't expect
> them to conflict with it either...

Yeah, I thought so.  As long as your patch-set does treat IPv4 and IPv6
equally and it works as expected, then I'm happy!  If the passtos
feature fails on IPv6, that's the passtos feature which is faulty - and
I won't chase you for those fixes.  Unless you want to fix it, of course :)

> I'll have a look when I merge to allmerged.  And we'll be testing
> autoconfigured IPv6 addresses over tap in our setup, so we'll hopefully
> catch obvious problems.

Perfect!

>>> Sounds great!  I'll definitely continue polishing the patch-set and
>>> continue hitting the vlan code with more tests.
>>
>> Cool!  Please let me know if you patches will go on top of the current
>> patch-set you sent, or if you come with a new patch-set based upon the
>> feat_passtos branch.
>
> I'd be fine with whatever you would prefer ... If you have no
> preferences, I'd probably continue rebasing my internal branch on
> feat_passtos until all comments have been worked in and we've completed
> our basic tests.  But I can also use a more incremental approach, if
> that simplifies your reviewing work or you'd like the existing code to
> be visible on openvpn-testing.git.

I'm also fine with with this approach.  Do what's most easy for you.
I'll be able to grab incremental and the completed patch-set, it's no
big difference for me at all.  Depends if you want to keep the commit
logs and progress in the upstream git tree or not.  If you have a public
git tree available, I could pull that as well.  (I tried the git URL the
webUI gave me yesterday, without luck).

For the moment I'll just sit "on the fence" wait for things to settle,
and I'll grab what you provide me when you're ready.  Then I'll give you
a feat_vlan_tagging branch and pull it in there.


kind regards,

David Sommerseth

