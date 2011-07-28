Message-ID: <4E31DEAF.8080202@...1114...>
Date: Fri, 29 Jul 2011 00:11:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 0/8] OpenVPN Doxygen patches
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/06/11 08:51, Adriaan de Jong wrote:
> Hi everyone,
> 
> Here's the first series of promised patches, many others will follow in the next few weeks. Although these are meant to be ready for the master branch, the actual process of generating patches with git is new to me, so please forgive any errors :).
> 
> This first series adds Doxygen documentation to OpenVPN, which can be generated using 'doxygen openvpn.doxyfile'. The graphviz and doxygen packages must be installed on your system to do so.
> 
> Regards,
> 
> Adriaan de Jong
> Fox-IT

All doxygen patches have now been accepted into the git tree.  Most of them
have been reviewed by James Yonan, and I've made sure there is no feature
changes in the code.

I realised after the git push that I've done a mistake.  When applying
these patches, I fixed a lot of whitespace errors which git complained
about (mostly trailing spaces, before newline).  In this process, I didn't
notice that the patch author got changed in the git commit.  So it now
might look like I'm the author.  However, the Signed-off-by: lines are
intact, and all have the proper credit to Adriaan de Jong.

So unless there are any objections or Adriaan insists on having his name as
the patch authors, I will leave it how it is now.  Otherwise, I'll need to
reset the git tree and push out a new one.  But I'm willing to do that if
people wants it like that.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4x3qoACgkQDC186MBRfrqF1gCeKIFsTK5WwyDZ8XKzvdMtNuP9
vlAAn0Nl5nPWsRJS2l6ScGVEZPLetP0S
=h05L
-----END PGP SIGNATURE-----

