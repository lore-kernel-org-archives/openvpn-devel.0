Message-ID: <4F43BEB5.6050404@...1114...>
Date: Tue, 21 Feb 2012 16:56:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
In-Reply-To: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 16:15, Alon Bar-Lev wrote:
> Hello,
> 
> OpenVPN supports minimum openssl version of 0.9.6, while this version 
> is unsupported by upstream and probably a security risk.
> 
> What would be a suitable minimum version to support?
> 
> I think that 0.9.8 is the one.
> 

Agreed.

The oldest Linux release James has been concerned about has been RHEL4.
That version ships an openssl based on 0.9.7a.  However, RHEL4 is
reaching EOL by the end of this month [1].  So I'd say RHEL5 should be
the natural oldest release to care about, which ships 0.9.8e.

Beware that even though those version numbers are looking old, there are
a lot of backports from newer versions.  The version number provided here
is the "base version" where fixes are applied on-top.

There might be similar restrictions related to autoconf/automake tools
too.  As James has some automation for the Access Server builds for those
supported platforms, we must be sure we don't break that for him.  From
what I see, on a recent 5.7 box ...

automake-1.9.6-2.3.el5
autoconf-2.59-12

We should probably try to get some RHEL5 based build slaves running too.
 We have CentOS6 which should be good enough for the RHEL6 base.

Otherwise, I presume most of the *BSD versions have more recent versions.


kind regards,

David Sommerseth



[1] <https://access.redhat.com/support/policy/updates/errata/>

(Side note:  RHEL4 does have an extended life cycle for customers who
really cannot upgrade yet.  In my point of view, this makes no sense to
support for OpenVPN, as those users will most likely never touch OpenVPN
related stuff which is not shipped by Red Hat.  Thus, if some customers
wants a newer OpenVPN and are willing to pay for it, Red Hat will have to
solve this issue for RHEL4 explicitly.  This is an add-on mostly for
bigger enterprises which are willing to pay for such support ... and if
not, there's always possibility to do a 'make dist' from the git tree on
a supported box and copy the tarball to the RHEL4 box)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9DvrMACgkQDC186MBRfrq3vwCfX05HK5MTNkC28F99/qxvXQVx
zVIAn3bm8XzuCED+jKNRUeKdE3J5Cyy7
=pyvY
-----END PGP SIGNATURE-----

