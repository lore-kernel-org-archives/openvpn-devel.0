Message-ID: <4E01A5DB.4050808@...1114...>
Date: Wed, 22 Jun 2011 10:20:43 +0200
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
> Here's the first series of promised patches, many others will follow in
> the next few weeks. Although these are meant to be ready for the master
> branch, the actual process of generating patches with git is new to me, so
> please forgive any errors :).
> 
> This first series adds Doxygen documentation to OpenVPN, which can be
> generated using 'doxygen openvpn.doxyfile'. The graphviz and doxygen
> packages must be installed on your system to do so.
> 

First of all, thanks a lot for this effort!  This is really valuable!
You seem to have managed to tackle this git patch submission just perfect,
btw.  I'll try to apply them soonish too, to test their integrity.

One immediate comment, though.  Is there a reason the doc_*.[ch] files are
not in a separate sub-directory?  Would it be possible to move all the new
doxygen related files into, say, a ./doxygen directory?  This is just to
isolate all which is purely doxygen stuff in one place.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4BpdsACgkQDC186MBRfroObgCfbi3kwos10xOYTSVh1UueB4SQ
cLQAmwSWREU18R0QYn3pfZgmkkhcRhZ+
=q5UP
-----END PGP SIGNATURE-----

