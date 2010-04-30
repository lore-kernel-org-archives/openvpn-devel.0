Message-ID: <4BDB4F03.6090409@...1114...>
Date: Fri, 30 Apr 2010 23:43:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BDAC9DC.8040505@...515...>
In-Reply-To: <4BDAC9DC.8040505@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (29th Apr 2010)
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
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/04/10 14:15, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Here's the summary of the previous community meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-devel on irc.freenode.net
> Date: Thursday, 29th March 2010
> Time: 18:00 UTC
>=20
> Planned meeting topics for this meeting were on this page:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2010-04-29>
[...snip...]
> Discussed the "Revamped the script-security warning logging (version 2)"
>  issue:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/3587>
>=20
> James will give the above patch an ACK once it's changed to use the
> openvpn_snprintf function. Dazo will take care of this small modification.

Just one correction.  It was not lack of usage of openvpn_snprintf(),
but rather make use of sizeof(msg) instead of a fixed value as the
second parameter.

The initial patch was:

  openvpn_snprintf(msg, 255,
	"WARNING: Failed running command (%s)", hook);

James suggested to change 255 to sizeof(msg).  This was done before
adding the patch.  This is now available as commit 339f2a4d4b487afa53fa99d.


kind regards,

David Sommerseth.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvbTwMACgkQDC186MBRfrpFxACbBhB1cl9ofy1mbaTWk4SsDm5+
T1UAoJVQ0vfw6ibaOa1ZIxq14gk3Kaha
=3D2KUb
-----END PGP SIGNATURE-----

