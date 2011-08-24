Message-ID: <4E54F6D6.6060600@...1114...>
Date: Wed, 24 Aug 2011 15:04:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E1F78E8.4050203@...515...>
	<1313078457-6512-1-git-send-email-samuli@...515...>
In-Reply-To: <1313078457-6512-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Merged TODO.IPv6 with TODO.ipv6
 and	README.IPv6 with README.ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/11 18:00, samuli@...515... wrote:
| From: Samuli Seppänen<samuli@...515...>
|
| Prior to this patch were two sets of IPv6 README/TODO files: one from payload
| and one from transport patchset. Unfortunately Git on Windows gets very confused
| of these files, as they only differ in case. This patch merges these sets into
| one.
|
| Signed-off-by: Samuli Seppänen<samuli@...515...>
| ---
|   README.IPv6 |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
|   README.ipv6 |   81 --------------------------------------------------
|   TODO.IPv6   |   41 ++++++++++++++++++++++++-
|   TODO.ipv6   |   30 ------------------
|   4 files changed, 131 insertions(+), 116 deletions(-)
|   delete mode 100644 README.ipv6
|   delete mode 100644 TODO.ipv6
|

ACK.  Applied to testing and stable master branches.
Commit c1f25b6644efaa74c069c20d9a008e1786209a88


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5U9tYACgkQDC186MBRfroYugCfbQMcBOsAYfotc/Q6JHSTYTv4
aioAnR6WSmAN1uLURUeLIyOww7FOAcm5
=wyA+
-----END PGP SIGNATURE-----

