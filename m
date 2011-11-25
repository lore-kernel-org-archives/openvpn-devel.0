Message-ID: <4ECF988E.10309@...1114...>
Date: Fri, 25 Nov 2011 14:30:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1322172626-18434-1-git-send-email-davids@...1347...>
	<1322172626-18434-2-git-send-email-davids@...1347...>
In-Reply-To: <1322172626-18434-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Do some file/directory tests before
 really starting openvpn
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

On 24/11/11 23:10, David Sommerseth wrote:
> OpenVPN can handle over 30 different files and directories, and it is 
> easy to misconfigure some of them.  In many situations OpenVPN will 
> even start running, even with a wrong file path or without the proper 
> permissions, and then it will complain much later on.  In some cases 
> the error being seen at this late point might even be difficult to 
> relate to a configuration option.
> 
> This patch tries to catch as many of these files as soon as possible, 
> kind of to "smoke-test" the files and directories to avoid the most 
> likely errors.
> 
> Trac-ticket: 73 Signed-off-by: David Sommerseth <davids@...1347...> 
> --- options.c |  151 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 files 
> changed, 151 insertions(+), 0 deletions(-)
> 

Applied to -testing and -stable master branches.
commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1

    Trac-ticket: 73
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7PmIwACgkQDC186MBRfrrKSQCfae50lVKb++D4IKgKm8XYwlTo
V1kAn3pCg2G5YdsNH4ce8vszngOdKMBp
=3dLY
-----END PGP SIGNATURE-----

