Message-ID: <4C2E25B1.7040302@...1114...>
Date: Fri, 02 Jul 2010 19:45:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C298338.2050003@...1114...>
In-Reply-To: <4C298338.2050003@...1114...>
Subject: Re: [Openvpn-devel] Beta 2.2 branch pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <james@...515...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all!

I've just pushed out a brand new beta2.2 branch on git.  The previous
attempt is renamed svn-beta2.2, and will most probably be deleted in the
near future.

The background for this is the discussion on #openvpn-devel meeting
yesterday.  As there are uncertainties regarding if the SVN push was
correct, it's better to start from scratch again as soon as possible and
work against the git branch for now.

The reason for this is that all commits, from the very beginning of the
SVN BETA2.1 branch, got rewritten and put me as the commiter of the
whole history.  It also meant that the complete history got duplicated
in the SVN history, one with the right commiter (James) and the
duplicate with my name on it.  In the meeting yesterday, we felt that
this was probably not correct and feared it might cause further merge
problems later on for James.

So it was considered better if a new SVN branch for the beta2.2 would be
created, branched out from r5701 (the latest SVN change).  All community
patches will then come on top of that new branch.  When I will do the
next SVN push, only those changes will be pushed (~50 commits) and not
the complete OpenVPN history once again.

Until these SVN push issues have been solved and James have had time to
review and comment the current SVN push, we will stay on git only for
the beta development.

> * What does the beta2.2 branch contain?
> As agreed to in the developers meeting June 10, OpenVPN 2.2 will contain:
> 
> - bugfix2.1 branch (lots of bugfixes)
> - feat_misc branch (several minor feature additions)
> - frp branch (https://community.openvpn.net/openvpn/wiki/FRP)
> - feat_eurephia branch (http://www.eurephia.net)
> - feat_ipv6_wintap (IPv6-enabled TAP driver for Windows)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwuJawACgkQDC186MBRfrrk9QCgrhUKNI+eZSjW5E5f/KnGIW62
9bsAn0VE1T3CAzs4mqIYKL1VO9cmNtZG
=v0g+
-----END PGP SIGNATURE-----

