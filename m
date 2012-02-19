Message-ID: <4F403CA0.80903@...1114...>
Date: Sun, 19 Feb 2012 01:04:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
	<CAJKrh+Ujepn465ebS2yHThjZMqDRKA7+qWvHF1XNAjpVches1A@...278...>
In-Reply-To: <CAJKrh+Ujepn465ebS2yHThjZMqDRKA7+qWvHF1XNAjpVches1A@...278...>
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
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
To: Scott Zeid <s@...1497...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/12 23:53, Scott Zeid wrote:
> 
> On Feb 18, 2012 9:05 AM, "Alon Bar-Lev" <alon.barlev@...277... 
> <mailto:alon.barlev@...277...>> wrote:
>> 9. Output of build system would be [at least] (msi, tarball) for 
>> (win32, win64). Why tarball? To enable people to fetch files
>> without hacking the msi (example: cross compile).
> 
> It should probably be a zip file since Windows doesn't support
> tarballs out of the box.

Right now, debating tarball/zipball formats is a bit premature.  There
are 8 challenging steps to solve before this.  Even though Windows
doesn't support tarballs natively, LGPL tools like 7-Zip exists which
will make that job easier.  And those needing to extract these pieces are
not necessarily end-users, so we should expect people to know how to
solve these things.

But for now, I'd like to see more focus on the steps before the packaging
method.  We first need to have something to package.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9APJ4ACgkQDC186MBRfrpdvgCgleyQ6VldHLmpj0FR/TO5RQ8l
CSAAnAmbJCFoCgon5QOFcfAupTZdOMZY
=9nxF
-----END PGP SIGNATURE-----

