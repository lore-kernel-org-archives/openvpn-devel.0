Message-ID: <4B8C38AD.8030607@...1114...>
Date: Mon, 01 Mar 2010 22:59:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>	<4B8A8DC9.3020502@...1114...>	<20100228221425.GT9556@...1296...>	<4B8AF4AD.8060402@...1114...>
	<hmhae1$p5k$1@...1312...> <4B8C30A2.5020200@...1114...>
	<4B8C3496.6000206@...376...>
In-Reply-To: <4B8C3496.6000206@...376...>
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
To: Bernhard Schmidt <berni@...376...>, Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 22:41, Bernhard Schmidt wrote:
> Hi David,
> 
>>> It doesn't make a difference at the moment (since the patch came from
>>> feat_ipv6_payload in the first place), but what's the general wish for
>>> the future? What to rebase on?
>>
>> To be very honest, I'm very uncertain about what's best.  Because it
>> will a lot of changes in multiple branches.  But as I'm able now to keep
>> the bugfix2.1 branch pretty clean with only bugfixes, I begin to lean
>> towards that you should consider to rebase on that branch.
> 
> Could you please have a look at git://git.birkenwald.de/openvpn.git
> test-rebase branch? The history of gert-ipv6 was starting to look a bit
> weird (duplicate commits with the same content), to I rebased it on your
> bugfix2.1 branch (and dropped the duplicate commits in the process). No
> difference in the content whatsoever and the history looks much better,
> but I'm not exactly sure whether this is the right thing to do.
> 

I tried to both merge and rebase both your gert-ipv6 branch and the
test-rebase branch from the allmerged branch.  That was quite an
interesting experience.

The test-rebase branch gave most problems.  Both rebase and merge got
painful.  While with the gert-ipv6 gave only (expected, though) issues
with rebase.  Merging in gert-ipv6 was more or less painless.

The only conflict was the title string in options.c, which will always
be a conflict area when merging in multiple feature branches.  But this
conflict is really trivial, and I'm not worried about that one.

I will try to ask some kernel guys about such situation what they would
recommend.

Regarding to the "duplicated commits", I believe that's what's happens
especially when cherry-picks are involved.  Not sure how bad Gerts
history was though.  But you might get an idea when using git log
- --graph ... then you see better which branch each commits belongs to.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuMOK0ACgkQDC186MBRfrqiXACfVUnAITzSpEJCM74dgrVfCQPY
PJ8An0NbhiMdxIUkZCrmRr7+SlLlN3Rs
=d7ys
-----END PGP SIGNATURE-----

