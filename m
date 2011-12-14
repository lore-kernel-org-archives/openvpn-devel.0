Message-ID: <4EE88321.9030104@...1114...>
Date: Wed, 14 Dec 2011 12:06:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323851782-27037-1-git-send-email-samuli@...515...>
In-Reply-To: <1323851782-27037-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Backported pkcs11-related parts of
 7a8d707237bb18 to 2.2 branch
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
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/12/11 09:36, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>
> 
> Fixes https://community.openvpn.net/openvpn/ticket/145 --- 
> win/config.h.in |    4 +++- win/msvc.mak.in |   11 ++++++++--- 
> win/settings.in |    4 ++++ 3 files changed, 15 insertions(+), 4
> deletions(-)
> 

Applied to the release/2.2 branch on stable.

commit 81ce1d45f88bec701fd477fa061acd0f0033fdf9


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7ogx8ACgkQDC186MBRfroIfwCdGQ1w7X/4XYY4ERAOMCEK8rXX
WGEAoI2hOhtdNzGLh5xSQmJZ/648sBjN
=Ese4
-----END PGP SIGNATURE-----

