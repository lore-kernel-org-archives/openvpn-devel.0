From: David Sommerseth <davids@...515...>
Date: Fri,  5 May 2017 22:34:05 +0200
Message-Id: <20170505203405.20865-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Don't run packet_id unit tests
	for --disable-crypto builds
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
To: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan.karger@...1435...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

So I pushed the commit too early, as mail-archive.com's Message-ID isn't
up-to-date yet.  The proper URL is:
  <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14550.html>

Eventually the URL in the commit will be correct.


Your patch has been applied to the following branches

commit dcfcc594759b3a768cd4d40508cbacae114c274b  (master)
commit 4aaa29dabda6513329fbff778828797f19c5b4ea  (release/2.4)
Author: Steffan Karger <steffan.karger@...1435...>
Date:   Fri May 5 22:07:28 2017 +0200

     Don't run packet_id unit tests for --disable-crypto builds

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494014848-20099-1-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494014848-20099-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZDOFwAAoJEIbPlEyWcf3yfyYP/00NWMv0OXGq3uBrb5t4CKFN
xoRf35KlbKyPOcZYn0VK9BjS70DfJuZ7wSxICMCi9fgMeOp4xmrgKDfkMRy3rlCo
GzVOJZ/rTiVgTFBNvuR919lC0o/JeEhyzUQjvJ3ZIiVcTQFsZKkB+cllHZquhxWo
zvwjQAhHQ/6lmfYTbQRf3yBg7pxSaoAJs9EdJzMoeRtbNJeow+SCyv51CxnBAQh3
zEydJPh9hLkzVm3/4FDCLkG3nEoOOCPdyPLYOfX3Voyqi3gT17AMd/EovX0CoG/Z
FO6wDgeZJoMyK0bT7JvjT9+pkEklWO7IyKkKh1KE1gLAJ6C6/IHgJkwWX7GWj05W
v83AthUNZPaNBh2EY3aQFoDAwV1OvUMZPQ9n2quMfiPKinpYwhJuiyv3WtH9HQVg
RtGbFpRALzniXAlDeMmpWVyCrYeX3AniMCNa+L7YYKlgFsfD9dXfW/ZNBQqZnM0U
uWYPTlHzoFmESDfH+F3aYOpGbLDHefcdbjP0S60SVUHWI8tkvc58awyBf5yMjNHE
IDjlInZ782y2ufRLzE9u/59RqQwFWaNHSGTDsJAoFoWBUTQ1iixJkbzoRmQ93PyR
8hofxA73MtmWGhE84icczIGAm2bZvJ8X8lKeuzD1K0GVZIqCbM0HYwfRsiCMGsz7
MrCrSXTqEHcielmIXcR/
=H/Jd
-----END PGP SIGNATURE-----

