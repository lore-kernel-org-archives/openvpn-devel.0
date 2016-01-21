Date: Thu, 21 Jan 2016 23:03:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160121220336.GT24952@...1296...>
References: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
	<1439311312-2682-5-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="07zPMZD+trRqpJXy"
Content-Disposition: inline
In-Reply-To: <1439311312-2682-5-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v3 4/4] systemd: Do not mask usernames
 when querying for it via systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--07zPMZD+trRqpJXy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 06:41:52PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> In systemd after version 216, systemd-ask-password will support --echo wh=
ich
> will avoid masking the user input.  As OpenVPN uses this mechanism collec=
ting
> usernames when systemd is available, this will avoid the input of usernam=
es to
> be masked.

Well, this one is easy :-) - "ACK!"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--07zPMZD+trRqpJXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqFVt6kuBuNlUUl1AQJe4AP9EWk1s8wjQ+ayWnZD6m5kZPDdvezAxDMQ
Jfe2rPByEKVNGp6yyuRFLlqE2Bgt0XQSBcyXMTyIDDhvNAHyqCF6/YmE4riEhtiX
WHIM1GKCOMQuTXawyUtoeztdHaZ+NQVH5YkknE8fZvaFobs3qeCBJpA7/KMk5qF2
UkUtpsQcHKk=
=/XFI
-----END PGP SIGNATURE-----

--07zPMZD+trRqpJXy--

