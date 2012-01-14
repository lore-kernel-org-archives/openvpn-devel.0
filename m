Message-ID: <4F116B5F.1070100@...1114...>
Date: Sat, 14 Jan 2012 12:47:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix pool logging when IPv6 is not enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

I'm running the master branch (commit 330baf2aee70b35) on a site where IPv6
tunnelling is not enabled.  I found some odd IPv6 addresses in the log file
when clients connected.  Attached is a patch solving this issue.  It's
basically a bogus message, and nothing seems to be pushed to the client.

This site is now running with this patch applied, and it behaves better.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk8Ra18ACgkQDC186MBRfrqEEgCghBVhGlZdYNtejPP8Gx3A9gXL
IEUAn35XkgcXuWmnjvAokf6NivrdtIma
=tG4S
-----END PGP SIGNATURE-----

