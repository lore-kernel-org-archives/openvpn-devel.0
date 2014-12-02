From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  2 Dec 2014 21:45:41 +0100
Message-Id: <1417553141-24466-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1417548862-24990-1-git-send-email-floppym@...594...>
References: <1417548862-24990-1-git-send-email-floppym@...594...>
Subject: Re: [Openvpn-devel] [PATCH applied] Include systemd units in the
	source tarball (make dist)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, Mike Gilbert <floppym@...594...>

From: David Sommerseth <davids@...1347...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ACK.  Tested with 'make dist' and the systemd unit files are included in the 
resulting tarball.

Your patch has been applied to the master and release/2.3 branches.

commit 6ece60c6dc7a3cda58f4dfea4e6cd3016023234f (master)
commit d9953bde8e5ce55550aabdeaf0893e2115919fc6 (release/2.3)
Author: Mike Gilbert
Date:   Tue Dec 2 14:34:22 2014 -0500

     Include systemd units in the source tarball (make dist)

     Acked-by: David Sommerseth <davids@...1347...>
     Message-Id: 1417548862-24990-1-git-send-email-floppym@...594...
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9299
     Signed-off-by: David Sommerseth <davids@...1347...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlR+JFUACgkQDC186MBRfrpSwwCfQBbGbyppwR1h11SBsHXFMDts
tS4An0ueWgCsIjm2zKncBSc9dUUJ4Wdw
=eK7S
-----END PGP SIGNATURE-----

