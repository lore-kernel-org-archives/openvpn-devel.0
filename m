Message-ID: <4BB45E4B.1000106@...1114...>
Date: Thu, 01 Apr 2010 10:50:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<4BB3D6A3.7020207@...1114...>
	<4BB45A07.5060300@...1338...>
In-Reply-To: <4BB45A07.5060300@...1338...>
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
To: openvpn-devel@lists.sourceforge.net

On 01/04/10 10:32, Fabian Knittel wrote:
> Hi David,
> 
> David Sommerseth schrieb:
>> Thank you very much for your patches!  I'll look into them soon.
> 
> Thanks!
> 
>> The
>> patches seems to apply nicely against the feat_passtos branch.  I was
>> worried about a conflict here, until I noticed where you had your roots :)
> 
> Actually, I was lucky to notice the openvpn-unstable.git repo before
> submission.  My original patch-set was based on the subversion repo
> branch beta21 and would have conflicted with feat_passtos.  I didn't
> notice the git repo and the Wiki on secure-computing.net until I
> happened to look at some openvpn-devel mails in the archive.  Does
> openvpn.net link to them from somewhere?

No, I don't think so yet.  This git tree got publicly available just a
few months ago, and things have gone in quite a quick tempo since then.
 We have not discussed this much at all, as far as I remember.

Samuli: Can you look into this?  To get some links to the developers doc
and the git tree on the official web site?

>> If you could do a bit more testing, also some stress/performance testing
>> with several VLAN's being tested in parallel, that would be beneficial.
> 
> We'll definitely be doing that over here.  My main concern was whether
> we would have to patch OpenVPN indefinitely with local enhancements or
> whether there was a chance to include it upstream.  And now that things
> look quite positive, we can go forward with the chosen approach. :)

Thanks a lot!  This really will help us a lot.  If you even dare to try
a local merge against the 'allmerged' branch when you do some bigger
tests, that would also be very much appreciated.

Btw!  How is it with IPv6 and your patches?  We have quite some patches
for that in the tree already.  And as I see you patch in the [PATCH 1/9]
the is_ipv4() function, you might want to be sure this will also work in
the IPv6 world as well.

Gert: is this something you could double check as too?

>> Having all this said, the feature itself seems reasonable for me to
>> include into OpenVPN, so the missing step is just to mature the code to
>> be sure we don't cause any regression.  And here some stress/performance
>> testing will be helpful.  You scare at least me when stating that this
>> code "was originally only intended as a proof of concept", which is why
>> I'm not signing off these patches immediately and giving you a feature
>> branch.  But I'm open for full inclusion!
> 
> Sounds great!  I'll definitely continue polishing the patch-set and
> continue hitting the vlan code with more tests.

Cool!  Please let me know if you patches will go on top of the current
patch-set you sent, or if you come with a new patch-set based upon the
feat_passtos branch.


Looking forward to more patches!


Kind regards,

David Sommerseth

