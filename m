Message-ID: <4D944A73.6030308@...1114...>
Date: Thu, 31 Mar 2011 11:33:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1301487818-4450-1-git-send-email-davids@...1347...>
In-Reply-To: <1301487818-4450-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix the --client-cert-not-required
	feature
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

On 30/03/11 14:23, David Sommerseth wrote:
> Commit 2e8337de248ef0b5b48cbb2964da0d5c3f28b15b introduced a new
> feature for using other SSL certificate fields for authentication
> than then CN field.
>
> This commit introduced a bug, which made the verify_callback()
> function getting called even if --client-cert-not-required was
> enabled in the config.
>
> The reason for this was that an 'else' statement was lacking a
> couple of curly braces.  The offending commit in reality moved
> the setup the verify_callback() function out of the 'else'
> statement.

Applied to the git tree.

commit 008a18e772bf1854f9a2102bef4b3d5b0a08a66b (master)
commit 272aef2f0fd6b8c81c397fc32a503776e2b4bef1 (beta2.2)
Author: David Sommerseth <davids@...1347...>
Date:   Wed Mar 30 14:14:21 2011 +0200

    Fix the --client-cert-not-required feature
    Report-URL: https://community.openvpn.net/openvpn/ticket/108
    Report-URL: https://forums.openvpn.net/topic7751.html
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Jan Just Keijser <janjust@...1147...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2USnMACgkQDC186MBRfrqxygCcDCPh+AAA7Zo7Letkd78yO3pJ
IAQAn3Jdm7Yt7uGWZSeW4r6dOPNKSO9U
=qe/M
-----END PGP SIGNATURE-----

