Message-ID: <4F72D51D.4030104@...1114...>
Date: Wed, 28 Mar 2012 11:08:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120222200301.586867ce@...1661...>
In-Reply-To: <20120222200301.586867ce@...1661...>
Subject: Re: [Openvpn-devel] Log level of management interface: patch from
 2009
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
To: Michael Kress <m-kress@...1660...>
Cc: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/12 20:03, Michael Kress wrote:
> Hello,
> 
> in May 2009 James committed in 
> 423037e9fbdff7209ca6f305b812a9908a0f4d13
> 
> "Reduce the debug level (--verb) at which received management 
> interface commands are echoed from 7 to 3."
> 
> A search for comments or a reason did not reveal more informarion. I
> use the management extensively and these regular management commands
> bloat the log at the default --verb 3 with at least 3 lines
> (enter/command/exit).
> 
> I do not wish to start a debate if this is reasonable or not. The
> fact, that this #define is still amongst verb 7 defines in the code
> raises the feeling, that this has simply been forgotten.
> 
> If this is true, you can use the attached patch, that tosses this 
> single (!) bit. :-)

As that commit from James is explicitly changing only this value, with a
commit message which is quite descriptive - I'm not convinced it's right
of us to revert this patch.  When James makes such explicit changes, it
mostly is for a good reason - we just might not know exactly why.

James, would you have the chance to comment on this request?  Michael
Kress' patch basically reverts your commit (r4413).


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9y1RsACgkQDC186MBRfrpLYgCdHtJZ598Sn17590IYWTWXcHDc
C7IAnjEciz/nc7M0Zlm4Et6/fbhC/IJx
=FnVj
-----END PGP SIGNATURE-----

