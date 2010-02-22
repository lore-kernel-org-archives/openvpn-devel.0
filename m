Message-ID: <4B8247D0.6040602@...1114...>
Date: Mon, 22 Feb 2010 10:01:04 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266515908-24807-1-git-send-email-kop@...1304...>
In-Reply-To: <1266515908-24807-1-git-send-email-kop@...1304...>
Subject: Re: [Openvpn-devel] Make sample-scripts/verify-cn dynamic
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/10 18:58, Karl O. Pinc wrote:
> 
> Hi,
> 
> Re: [PATCH] Change verify-cn so cn is no longer hardcoded in openvpn's config file
> 
> This patch should be easy to process.
> A resubmission of the patch sent to this list on 04/23/2009.
> 
> The patch changes the verify-cn script sample
> to be used with --tls-verify so that instead of having
> to hardcode a cn to verify in the OpenVPN configuration file
> the allowed cns may be written into a separate file.
> 
> This makes the process of verifying cns a whole
> lot more dynamic, to the point where it is useful
> in the real world.
> 
> One problem with this patch is that it is backwards
> incompatible.  I did not bother keeping the original
> calling interface as A) it's a sample script, and B) the
> original's functionality seems useless
> and equalivant functionality is easily available
> with the new script.
> 
> The problem with the original is that there seems
> little point in verifying a client's cn when all
> the clients share one cn, as would have to be
> the case when the cn is hardcoded into the openvpn
> config file.
> 
> This patch applies against the testing allmiscs branch,
> and should apply against any of the other testing
> branches as well.
> 
> It works for me.  I've tested it throughly but not
> used it extensively in production.
> 
> Regards,
> 
> Karl <kop@...1206...>

I forgot to mention this is pulled in.  This is applied to the bugfix2.1
branch and merged into the allmerged branch.

commit 22b055eb0888cefa86e0a6d4a34da6066873be45


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuCR88ACgkQDC186MBRfrqwhQCfUP3Encehmnmu5y+37H/4K7XR
HT0AnRUXdGT0XlQ35iQrekxdhat9wk9O
=bhPs
-----END PGP SIGNATURE-----

