Message-ID: <4B7E57DE.3090400@...1114...>
Date: Fri, 19 Feb 2010 10:20:30 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <6E54510B-874A-4A7A-AFCD-A1C218467E40@...1286...>
In-Reply-To: <6E54510B-874A-4A7A-AFCD-A1C218467E40@...1286...>
Subject: Re: [Openvpn-devel] -devel version numbering
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
To: Eric F Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/10 23:23, Eric F Crist wrote:
> How is -devel being numbered, and how are we handling snapshots for propagation of -devel versions?  I've spoken with Matthias Andree, the FreeBSD port maintainer, and he'll be handing maintainership to me for openvpn-devel (possibly openvpn, later) after the ports freeze.  

First of all, it's not a incremental numeric version number.  But you
can either choose to use a timestamp based on when you pull the tree, or
more preferably - you can use the commit ID of the last commit.

An easy way to do this, would be to use some git commands.  Presuming
you already have a local git clone, it's just a few steps:

- ----------------------------------------------------------------------
# update the local clone
git fetch origin

# fetct last commit ID in allmerged and make "short version"
LASTCOMMITID=$(cat .git/refs/heads/allmerged | cut -b-12)

# create snapshot
git archive -prefix openvpn-testing-snapshot-${LASTCOMMITID}/ \
	origin/allmerged | \
	gzip -9c > openvpn-testing-snapshot-${LASTCOMMITID}.tar.gz

- ----------------------------------------------------------------------

That's basically it.  I believe there are som better ways to catch the
last commit ID, I'll more into the porcelain git commands to discover that.

You could also do a check if that last commit ID has changed or not
since last time.  If it has not changed, there are no changes to the git
tree and no need for a new snapshot.

> Should I be taking my own weekly snapshot on Monday, and pushing that up the tree, or is someone else (dazo?) going to do a global development snapshot and make that available.  I'm OK either way, just want to know what the 'norm' is going to be.

I would not mind if you have some kind of script which does all the
snapshot work automagically.  I probably indicated that above :-P  If
these snapshots are uploaded to a community webserver, then we basically
have all we need.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+V94ACgkQDC186MBRfroxRQCZAYsRlYiZhi2pK1RDe+LBebtk
9wkAoImlu+dET4v9p8xrza9+NzeKQ1QA
=Ju+u
-----END PGP SIGNATURE-----

