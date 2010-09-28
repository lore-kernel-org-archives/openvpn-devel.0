Message-ID: <4CA19146.7040508@...1114...>
Date: Tue, 28 Sep 2010 08:55:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTinJNNoewiqB2BzM6F_iwK=xctA72B2bUJpvnvUp@...278...>
In-Reply-To: <AANLkTinJNNoewiqB2BzM6F_iwK=xctA72B2bUJpvnvUp@...278...>
Subject: Re: [Openvpn-devel] Multihomed Openvpn server setup question.
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
To: Praetorian <praetoriancode@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/09/10 02:04, Praetorian wrote:
> I am settting up some servers to test the beta debian packages and
> wanted to try a multihomed server.  I have two isp's coming into the
> building and wish to make one the primarly connection side and then
> one be the backup (ie because it is the slower of the two).  I looked
> through the man page for 2.3 and did not see any settings in the
> <connection> area to do like preferences to a group of  connections
> (other than going in the order they are located in the file).  Also
> once connected to the backup is there a way for it to probe when the
> other route/connection comes back online to change back over from the
> fall back to the prefered connection?
> 

Hi,

We have a report [1] that the multihome feature in OpenVPN 2.1.x on
Debian (and most probably Gentoo) and openvpn-testing.git is broken.  It
is most probably caused by a bug in the IPv6 transport patch which is
added on Debian.

I'm working on applying a fix from the developer to the
openvpn-testing.git tree, so I hope I can manage to solve within this
week.  So if you're willing to test out the 'allmerged' branch, that
should soon fix this issue completely.


kind regards,

David Sommerseth


[1] <https://community.openvpn.net/openvpn/ticket/28>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyhkUYACgkQDC186MBRfroMFACeMh8jt1Y3PnQCHGviknEEyVxJ
66oAoJSYY1cGLa9kxxLWjModbyVevqNE
=KRnF
-----END PGP SIGNATURE-----

