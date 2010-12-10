Message-ID: <4D01DD1C.5010506@...1114...>
Date: Fri, 10 Dec 2010 08:56:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>	<20101210062512.17827.qmail@...1287...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Peter Stuge <peter@...1287...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/12/10 08:38, Adriaan de Jong wrote:
> About the whitespace: it's a tad difficult to split the patches now. Are you sure it wouldn't be acceptable this way?


If I'm not entirely mistaken, these patches are based against a 2.1.x
release and not the git tree at all.  Considering that we're in the
midst of getting the official 2.2 release out-the-door in about a month
or so, I'd suggest that we primarily do code review now.

Adriaan can then rebase these patches against the git tree when I get
the beta2.2 branch stabilised as a release branch.  In this process, I'd
expect Adriaan to also implement our review comments as well.  I've
discussed this with Adriaan on IRC already, and this seemed to me that
this is what he would prefer.

Since this is a big round of patches, I do expect merge conflicts
applying these patches unto the beta2.2 branch.  Which means, Adriaan
needs to rebase his patches anyway.

So, please high-light coding style issues so that he can fix that for
the final round for the final inclusion into our git tree.  But lets
first of all this be a code review round so that Adriaan got something
to work to get the final inclusion go smoother in the end.

Adriaan, will this work for you?  Any other comments or thoughts?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0B3RoACgkQDC186MBRfrp/nACglVEbUxG9n0Bp3Ttz2BDWgxkL
ywoAnj6uCCeTMKLZ5vfAknS1M7HUWqjI
=d4Sp
-----END PGP SIGNATURE-----

