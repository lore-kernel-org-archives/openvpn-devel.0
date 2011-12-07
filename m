Message-ID: <4EDF8C17.8030703@...1114...>
Date: Wed, 07 Dec 2011 16:53:59 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [Windows] Malware and OpenVPN GUI installer from
 CNET's download.com service
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
To: Openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

This is a sad mail to write, as it has come to our attention that CNET's
download service seems to have added some malware to the OpenVPN GUI
installer for Windows.

There are more issues here.  First of all, the 2.1_beta7 release which is
available on that site *should not* be used.  That version is very old,
and the latest release at the current point is version 2.2.1.

Then there is an issue with CNET wrapping the 2.1_beta7 release into
their own installer.  This "new" installer will install malware on your
computer.  It might even change your default home page, add toolbars to
Internet Explorer (which is claimed hard to get rid of), change your
search engine to Bing, and so on.  And this is something other open
source projects have noticed as well, such as NMAP and VLC.

If you see something like the following screenshots, don't trust the
installer!

<http://images.sjau.ch/img/26237c40.png>
<http://images.sjau.ch/img/a20598a6.png>

Another indication of a non-trustworthy installer is if the downloaded
file name starts with 'cnet'.

For more information, see this web site:
<http://insecure.org/news/download-com-fiasco.html>

And to be sure you get a proper installer, download it from:
<http://openvpn.net/index.php/open-source/downloads.html>

Here you may also download the GnuPG (PGP) signature of the installer
which should give a confirmation like this:

$ gpg --verify openvpn-2.2.1-install.exe.asc
gpg: Signature made Tue 05 Jul 2011 09:16:13 CEST using DSA key ID 1FBF51F3
gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:  12  signed:   5  trust: 0-, 0q, 0n, 0m, 0f, 12u
gpg: depth: 1  valid:   5  signed:  33  trust: 5-, 0q, 0n, 0m, 0f, 0u
gpg: next trustdb check due at 2012-02-02
gpg: Good signature from "James Yonan <jim@...41...>"

This requires that openvpn-2.2.1-install.exe is in the same directory as
openvpn-2.2.1-install.exe.asc.

There are probably similar ways how to verify signatures via PGP or GnuPG
in Windows as well.

Thanks goes to hyper_ch on #openvpn at FreeNode (IRC) for notifying us
about this issue.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7fjBUACgkQDC186MBRfrp6zQCgkLktdBUJ7/zlovPCnDkt4pqv
1ngAn0KEZ8QRv3sZa7D1NOj8PFQ7B/8F
=nLpm
-----END PGP SIGNATURE-----

