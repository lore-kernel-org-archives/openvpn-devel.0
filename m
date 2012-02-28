Message-ID: <4F4CE5E1.1050904@...1114...>
Date: Tue, 28 Feb 2012 15:34:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Temporarily delaying patch acceptances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

As you all probably know, Alon Bar-Lev is doing a revolution to our build
system.  The more I look at these changes, the more I like them, and it
shows how overdue this process was.

Alon's patches changes so much inside the source tree, that applying
patches to the current master branch (which does not have Alon's stuff in
yet) will make it very hard to pull in Alon's changes afterwards.

However, patches made on the current master should be fairly easier to
integrate when Alon's work is done.  The patches mostly just needs to be
applied in other directories than at the root source tree.

So I'm having my focus on Alon's changes right now.  And patches which
will come until his stuff has reached the master branch.  If you want to
make this happen faster, please test, test, test, test and test Alon's
working branch - and report issues.  But beware, Alon's tree is moving
very fast forward.

In the meantime, I'm very much thankful for the time and energy Alon has
put into this.  He is surely has proven to know a lot about autotools and
build chains.  And I'm looking forward to get his stuff upstream.

I'll follow up on this mail when things starts to get moving forward.  If
you notice that some of your patches have not been applied at that point,
you may poke me about it.  But until Alon's work is completed, they will
be in my little patch queue.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9M5d8ACgkQDC186MBRfrqu+gCfZCPpFi0bpt7mqgiTrde8rQZV
UUAAnRzMdRm6necdZn9vtVLzH8IsOul8
=o92D
-----END PGP SIGNATURE-----

