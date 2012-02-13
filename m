Message-ID: <4F396AC5.3090708@...1114...>
Date: Mon, 13 Feb 2012 20:55:49 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1322057700-15531-1-git-send-email-heiko.hund@...1489...>
	<1322071714-17389-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1322071714-17389-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2] Windows UTF-8 input/output
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

On 23/11/11 19:08, Heiko Hund wrote:
> This patch makes openvpn read unicode from the console and convert
> the input to UTF-8. And then display UTF-8 output to the console 
> correctly.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- configure.ac | 1
> + openvpn.c    |    4 ++++ win32.c      |   14 +++++++++++++- 3 files
> changed, 18 insertions(+), 1 deletions(-)
> 

ACKed and applied to master branch on -testing and -stable.

commit 6ba68180b89e0290855f70832243fc9b4370e4d2
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Wed Nov 23 19:08:34 2011 +0100

    Windows UTF-8 input/output

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85asMACgkQDC186MBRfroynACfQNt0I34bvNV6r5VBmqkmFF/k
/LYAniC/Ch7k86CBGPRCRm284oaxuoaA
=qiCa
-----END PGP SIGNATURE-----

