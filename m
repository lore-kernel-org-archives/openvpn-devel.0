Message-ID: <508EDC68.3040707@...1114...>
Date: Mon, 29 Oct 2012 20:43:36 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <507E7822.1070006@...1114...>
In-Reply-To: <507E7822.1070006@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig60DD6BF392A286DCE9949E80"
Subject: Re: [Openvpn-devel] RFC - Usage of --script-security with the
 'system' flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60DD6BF392A286DCE9949E80
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/10/12 11:19, David Sommerseth wrote:
>=20
> Hi all,
>=20
> I've been reviewing a bug reported to the v2.3 code base.  We're in the=20
> beta phase currently, and this is a bug I'd like to get fixed before=20
> we're moving on further.  The bug is related to the use of the 'system'=20
> flag in --script-security.
>=20
> <https://community.openvpn.net/openvpn/ticket/228>
>=20
> The use of the 'system' flag has been deprecated for a long time.  And=20
> it is really a potential security issue to use it, due to shell=20
> expansions which might happen.  The preferred (and default way) is to=20
> use execve(), which is far safer and does not do the shell expansions=20
> while executing the script or binary.
>=20
> The fix I'm currently considering is to remove support for the system()=20
> call completely.  This support was introduced in 2.1_rc9 (Nov 17, 2008).
>=20
> Does anyone depend on --script-security where the 'system' flag is=20
> required?  If you need this feature, can you please elaborate why this=20
> support is needed and why you cannot use the preferred default with=20
> execve?

[...snip...]

Based on the input I've received both on the OpenVPN mailing lists and
on IRC discussions, I have not been convinced that we should still have
the system() call support.  Yes, there is an issue on Windows where you
need to provide full path to the script interpreter for non-executable
files (such as .vbs scripts).  However, I consider that more a security
enhancement, as you earlier had to provide either the full path (which
is now a strict requirement) or use the 'system' flag with the
--script-security option.  In both cases, a configuration file change
would be needed.

The patch, which hopefully also updates the man page properly, is sent
for review to the developers mailing list:

<http://thread.gmane.org/gmane.network.openvpn.devel/7114>

Thank you to all who did provide some feedback.


kind regards,

David Sommerseth


--------------enig60DD6BF392A286DCE9949E80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCO3GgACgkQDC186MBRfron1wCaAijet7uwxGCBSlfDhtfcYpe+
2BsAn2ZIYeXjf6kmBcpd9CBxKU42VD7R
=uHL0
-----END PGP SIGNATURE-----

--------------enig60DD6BF392A286DCE9949E80--

