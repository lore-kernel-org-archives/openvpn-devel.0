Message-ID: <4DA8523E.5080608@...1114...>
Date: Fri, 15 Apr 2011 16:12:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1302872235-22152-1-git-send-email-samuli@...515...>
	<1302873917-22599-1-git-send-email-samuli@...515...>
In-Reply-To: <1302873917-22599-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCHv2] Fixed a bug with GUI icon deletion
 on	upgrade from 2.2-RC or earlier
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

On 15/04/11 15:25, Samuli Seppänen wrote:
> This bug was introduced in commit 110e42d199e735ab1a31388c5678f59d0fa9510c.
> 
> Trac-ticket: 120
> Signed-off-by: Samuli Seppänen <samuli@...515...>

ACK.  Applied to master and beta2.2

commit 1cc2b62d97d651ce9b05466928faba3b463838b7
Author: Samuli Seppänen <samuli@...515...>
Date:   Fri Apr 15 16:25:17 2011 +0300

    Fixed a bug with GUI icon deletion on upgrade from 2.2-RC or earlier

    This bug was introduced in commit 110e42d199e735ab1a31388c5678f59d0fa9

    Trac-ticket: 120
    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    (cherry picked from commit 6d1d08f6792109a4a4cdd9cd0936fd4338c76fa1)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2oUj4ACgkQDC186MBRfrpNtACfVtuKzYJ36/gx/irIYtFfruPb
kVgAn2v3v3N/aJJDOj2crbwH3+mbF5UN
=/qmi
-----END PGP SIGNATURE-----

