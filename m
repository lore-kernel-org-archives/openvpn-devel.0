Message-ID: <4E6A033E.1060907@...1114...>
Date: Fri, 09 Sep 2011 14:14:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E69DDAB.2040104@...515...>
In-Reply-To: <4E69DDAB.2040104@...515...>
Subject: Re: [Openvpn-devel] First Windows snapshot installer of "master"
 branch	now available
Reply-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/09/11 11:34, Samuli Sepp=E4nen wrote:
> Hi all,
>=20
> The first Windows snapshot installer based on current "master" branch is
> now available:
>=20
> <http://build.openvpn.net/downloads/snapshots/openvpn-2.x-20110909-master=
-install.exe>
>=20
> There are lots of changes compared to OpenVPN 2.2.1, including IPv6
> support and a new GUI. Perhaps somebody else could provide a more
> through list of changes using some Git magic?

The development we're doing on the master branch is what will come in the
future v2.3 release.  Complete IPv6 support is definitely the biggest
change since v2.2.  However, there are more things added as well:

* Getting up-to-sync with the latest OpenVPN AS
The OpenVPN version in OpenVPN AS has diverged a bit from the community
version, and new features have been added to the AS version.  We should now
be synced with all the features James Yonan have put into AS.  Some key
points from this merge are:

  - Added "management-external-key" option.
  - Added --x509-track option.
  - Added --management-up-down option
  - Added "client-nat" option for stateless, one-to-one NAT
  - Extended "client-kill" management interface command (server-side)
  - Added "auth-token" client directive
  - Added 'dir' flag to "crl-verify"
  - Added new "extra-certs" and "verify-hash" options
  - Added --enable-lzo-stub ./configure option
  - Added optional journal directory argument to "port-share" directive
  - Added redirect-gateway block-local flag
  - Added "management-query-remote" directive (client)
  - Added username to "status" management interface command

* A new plug-in API
This is the v3 API, which provides a more dynamic approach for plug-ins.
The new function API is designed so that the function calls should not need
to change much more from now on.  This API passes over structs which
contains the same information as the former APIs, but will in addition
during TLS certificate authentications provide a pointer to the complete
X509 based SSL certificate.

* Add extv3 X509 field support to --x509-username-field

* Provide 'dev_type' environment variable to plug-ins and script hooks

* common_name passing in auth_pam plugin

* Several build issues have been fixed

* Plenty of bug fixes

* Several man page updates, adding missing information or fixing errors

* Most of the source code is now document, using Doxygen

And there's probably more things I've forgotten, deliberately ignored or
simply overlooked when looking through the commit history.

What we're putting effort to now is to modularise the SSL layer and add a
compile-time switch to use PolarSSL as a replacement to OpenSSL.  OpenSSL
will be the default.  Hopefully this will make it easier for others wanting
to use other SSL implementations than OpenSSL or PolarSSL, as crypto and
SSL is now more clearly separated.

There are also more patches in the queue, but that is less visible changes
than what's listed here.

Even though we have achieved a lot, and 17 different people (if I've
counted correctly) have gotten their patches applied - we still have a lot
more to do.  So if you want to get involved, changing OpenVPN, please get
in touch!  If you don't know where to start, please have a look at our bug
tracker:

   <https://community.openvpn.net/openvpn/report/3>

And if you don't feel like writing docs or code, please test our snapshots
as much as possible and please provide feedback - good or bad.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5qAzsACgkQDC186MBRfrrBIgCfcBc/EvGQm3XJqc6983Y9MrUK
P5cAnRT6TZQhuYLgUGqK0ZCbVY6EB+KE
=3D/7a5
-----END PGP SIGNATURE-----

