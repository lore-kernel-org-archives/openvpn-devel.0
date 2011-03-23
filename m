Message-ID: <4D89E62F.2000607@...1114...>
Date: Wed, 23 Mar 2011 13:23:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1300880316-5779-1-git-send-email-samuli@...515...>
	<1300882472-11494-1-git-send-email-samuli@...515...>
In-Reply-To: <1300882472-11494-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes to Makefile.am
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
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/03/11 13:14, Samuli Seppänen wrote:
> Removed reference to config-win32.h, which has been removed. Added
> management-notes.txt to dist_doc_DATA.

ACK.  Applied to the beta2.2 branch.

commit ef2cbc771a6cf95868f2bb1c692e3cc9e2be5280
Author: Samuli Seppänen <samuli@...515...>
Date:   Wed Mar 23 14:14:32 2011 +0200

    Fixes to Makefile.am

    Removed reference to config-win32.h, which has been removed. Added
    management-notes.txt to dist_doc_DATA.

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2J5i0ACgkQDC186MBRfrr6wgCgnEgYgTiUT/doQ3oQJSlKHt3p
xjwAnRmf+1lJybbUuA47v+DzY36k5VOc
=1+9q
-----END PGP SIGNATURE-----

