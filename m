Message-ID: <4B8C30A2.5020200@...1114...>
Date: Mon, 01 Mar 2010 22:24:50 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>	<4B8A8DC9.3020502@...1114...>	<20100228221425.GT9556@...1296...>	<4B8AF4AD.8060402@...1114...>
	<hmhae1$p5k$1@...1312...>
In-Reply-To: <hmhae1$p5k$1@...1312...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
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
To: Bernhard Schmidt <berni@...376...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 22:09, Bernhard Schmidt wrote:
> David Sommerseth <openvpn.list@...1114...> wrote:
> 
> Hi David,
> 
>>> David, could you please pull my branch from Berni, and move that patch
>>> to wherever bugfixes/code cleanups go?  It should merge easily into 
>>> all branches.
>>
>> Pushed and pulled.  I've only put your extra commit into the bugfix2.1
>> branch (as a cherry-pick), and merged it into allmerged.
>>
>> At some point, you might consider to pull in the bugfix2.1 branch into
>> your feat_ipv6_payload branch, just to get in those bug fixes.
> 
> Hm, I thought we (Gert :-) ) were supposed to develop on top of master?
> I don't have any preference either way, but as soon as we merge
> bugfix2.1 into feat_ipv6_payload all those commits are there.

Yes, true.

> It doesn't make a difference at the moment (since the patch came from
> feat_ipv6_payload in the first place), but what's the general wish for
> the future? What to rebase on?

To be very honest, I'm very uncertain about what's best.  Because it
will a lot of changes in multiple branches.  But as I'm able now to keep
the bugfix2.1 branch pretty clean with only bugfixes, I begin to lean
towards that you should consider to rebase on that branch.

The master branch should only contain James stuff (plus some files
useful for my SVN pulls), while merging in bugfix2.1 may help avoid
merge conflicts.  As Gerts commit in regards to the bug fix he sent in
was in the middle of his ipv6 commits, I had to cherry-pick it to get it
into a proper branch.  This causes the commit history to be kind of
interesting, but messy.  I want to try to avoid this, to be honest.

Anyway, if you merge in bugfix2.1 on the way, that would potentially
remove possible conflicts in future merges when I merge all branches
into allmerged.  And bugfix2.1 will contain more or less important
fixes, and fixes only, which really should be considered to go into
James stable tree.  I will consequently merge master and bugfix2.1 first
into allmerged, then the feature branches with changes in random order.
 So in that perspective, all feature branches will start on the
bugfix2.1 code.

I don't want to see feature branches getting merged without agreeing on
closing one of them down for good, though.

I am not sure what is the best approach in the very end, and I am open
for advices and others experiences as well.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuMMKEACgkQDC186MBRfrrN3ACeOik4kFVc25Rku2VV+ukJpiD6
ItAAn07VIXG4U3MDjQult33YqKRrSlyC
=N6X0
-----END PGP SIGNATURE-----

