Message-ID: <4B97C16B.5090402@...1114...>
Date: Wed, 10 Mar 2010 16:57:31 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267394867-2823-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1267394867-2823-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Implement --passtos for tagged ethernet
 frames
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
To: Davide Guerri <dguerri@...384...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 23:07, David Sommerseth wrote:
> From: Davide Guerri <dguerri@...384...>
> 
> This patch makes it possible to use the --passtos option with 802.1Q tagged
> ethernet frames.
> 
> sf.net tracker:
> <https://sourceforge.net/tracker/?func=detail&aid=2829878&group_id=48978&atid=454721>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  proto.c |   14 +++++++++++---
>  proto.h |   12 ++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 

Patch accepted for testing before getting merged into allmerged.  The
patch is available in the feat_passtos branch in the openvpn-testing.git
tree.

Web view:
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=shortlog;h=refs/heads/feat_passtos>

Snapshot for testing:
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=snapshot;h=64ce035b40298e4d00a3e4767ce5386a2f937d9e;sf=tgz>

To use this snapshot, unpack it and run:

  autoreconf -vi
  ./configure
  make


** NOTE ** NOTE ** NOTE ** NOTE ** NOTE ** NOTE ** NOTE ** NOTE **

It is crucially important that this patch is tested by people who need
this feature.  This patch will be dropped if there are no response from
testers.


kind regards,

David Sommerseth





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuXwWsACgkQDC186MBRfrp2fgCfcb8hIfy1hGqquF3+VJ377DOU
iqMAn2wrqg9iO+yYeYlV0hutooEtNe/4
=ECQJ
-----END PGP SIGNATURE-----

