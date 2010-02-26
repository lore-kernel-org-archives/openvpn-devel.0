Message-ID: <4B88110D.3020501@...1114...>
Date: Fri, 26 Feb 2010 19:21:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
	(second round)
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
To: Stefan Monnier <monnier@...1268...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(resent - to get it into the mailing list)

Hi Stefan!

I believe you've noticed we've included a patch which aims to remove the
randomisation I found when reviewing your patch.

- From the following review discussion, a few other things needs to be
changed and I hope you are willing to look into adopting your patch to
those guidelines.  This is also to follow the standards [1] we try to
introduce as well.

So, to give a summary to what needs to be done:

* This feature should be #ifdef'ed, so that it can be disabled for those
not wanting this feature.

* MAX_IPS_PER_HOSTNAME should be set via ./configure.  I'd probably
recommend that if this value is 0 the feature is not enabled (covers the
first point automatically and simplifies ./configure)  If f.ex. only
- --enable-resolve-all-ips (probably need a better targeted name) is given
without a number, the default should be 20.

* Implement this patch on top of the frp branch, and make sure you add
the possibility to disable the randomisation of resolving.

I hope I haven't forgotten or overseen anything now.

Would you be willing to do this job?  When these things are covered, I
believe the patch has reached a state where it is suitable for inclusion.


kind regards,

David Sommerseth



[1]
<http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentation>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuIEQsACgkQDC186MBRfroqKQCfZGkkMtIUDkIIkXYXXLirOlts
nBcAn2nIn+xsVu/9Fz7AOlzEgQPohETw
=SE/7
-----END PGP SIGNATURE-----

