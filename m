From: Josh Cepek <josh.cepek@...1085...>
Date: Tue, 17 Dec 2013 20:05:21 -0600
Message-ID: <l8qvsn$jif$1@...1062...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Easy-RSA v3 release planning
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's an update about Easy-RSA v3 in case there were any lingering
contributions or ideas.

As of Dec 01, info & downloads have been available on the users list for
v3.0.0-rc1. No replies have been sent to that thread, though a few
improvements have been made following the release; these are slated for
an -rc2 to be release shortly, quickly followed by an official 3.0.0
release if there are no known issues or other hold-ups. I plan to add a
Win32 integration-branch for openvpn-build at that point.

The notable fix since -rc1 has been support for OpenSSL-0.9.8 (commit
8b1fe01.) While I hope this isn't a common need, the fix was simple
enough, and this is still a supported OpenSSL version.

Additional feature improvements include PKCS#7 support, some minor
fixes, code style, and updated docs. I also plan to add in a passphrase
change command for -rc2 so private keys can be re/un-encrypted.

At this point, the notable thing missing compared to the 2.x-series is
PKCS#11 support. My thought here is that it should either have universal
support for both Windows and *nix platforms or be exposed as
distro-centric additions. I'd rather see a pkcs11 frontend script that
is targeted to each platform, and envision this as a 3.1 release target
feature.

- --
Josh Cepek

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSsQLhAAoJENcx2Xpgb9RjbF4MAKTomgBgRwJ/2WZ8h+PuHlPj
Us+aZMfqvsCKcuMK2wG0qy7RawnCQAzp6eTa43XJG8/lInatAFVBJJVC4TvlxQxR
e9/tytzhFlzP43wc/CE04y1Hh/cL97YzXEBJNQZvpW0Ztqu3Q8zvjFMXpdPl8exN
z2ByFG9tW2lKL+HcjsL2kruTDvUK10FsuV8Fa51V8CrMwdDwzvAht0WiU9dSIKob
pA2dupUGe26z1o7Y00CG7uXh65y380XHEy2hqgM+hIG9x0MIVDyqm2MBGMZseYhn
440vLQPbe8CKE/lu0Vm+dl0Nep0+LaxLTipNwZS6d+KCxpyp0hnZhEB8h2wlK5Cz
G1wPZTG3SYrZuL9E38M0hWlyDZzqTgkTMHivX3k+LXCsrQmWl+Albirvl5HR0TVF
JCVNxOReumT0kn2sm76rqA5To7+3EfBma5AjaHR2YLnrTcSu1NRmZxHh7+UOsDmT
HMIuLngW7PZPT1b8BPgw1DoLb5jvPD8/NHng+PQgCQ==
=7GLZ
-----END PGP SIGNATURE-----


