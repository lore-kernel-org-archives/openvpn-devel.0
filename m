References: <20161209181303.20267-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
Date: Fri, 9 Dec 2016 20:42:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161209181303.20267-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JcoW9GTBOWmefD54dxnQN7gTuNHvT7efu"
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JcoW9GTBOWmefD54dxnQN7gTuNHvT7efu
Content-Type: multipart/mixed; boundary="paXLHjgxptnEf53oEJC2XKM2rgwNwg0fU";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>
Message-ID: <98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
	systemd units
References: <20161209181303.20267-1-list@...1798...>
In-Reply-To: <20161209181303.20267-1-list@...1798...>

--paXLHjgxptnEf53oEJC2XKM2rgwNwg0fU
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09/12/16 19:13, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> ProtectSystem=3Dstrict mounts the entire file system hierarchy read-only,
> except for the API file system subtrees /dev, /proc and /sys (which can
> be protected using PrivateDevices=3D, ProtectKernelTunables=3D,
> ProtectControlGroups=3D).
>=20
> ProtectHome=3Dtrue makes the directories /home, /root and /run/user
> inaccessible and empty for the process.

Currently I don't think we can use ProtectedHome=3D .... as it is fully
possible to save certificates and keys under $HOME/.cert on Fedora/RHEL
(and clones).  There is even a specific SELinux label for files in that
path, home_cert_t.

For the others, I think they are more reasonable ... But I need to dig
into the more murky details to be 100% they are safe for us.  This is
anyhow something we need to postpone until after 2.4.0 ... I don't dare
adding more things which may backfire in rc2, as we're on a strict
schedule to manage the next Debian release.

Once rc2 settles, I will start playing with this patch.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--paXLHjgxptnEf53oEJC2XKM2rgwNwg0fU--

--JcoW9GTBOWmefD54dxnQN7gTuNHvT7efu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSwkKAAoJEIbPlEyWcf3ynDIQALlXWbhFMSrUiqBven3jHapj
0CEms2Y9n+fYiZ8lUAzuRyjz8uPfU1p9LRv6b78kWTGZzTKtgb0FBaD3blpAIZhV
N/3+BbvQ9ZxneBK4IAAu1mT8J0SFCX3SyS9e3qQhULV25Yhizq0MDm7HydugGPZY
XGiGkJquoyQeTRtwjoQPY+jjf/iM/e2AJmWWrJiqLOOF1I1P87E03zuzw2YbHfa0
oPv8iPHDD0MUdlgnnWsLE5enqX4ZdxoqVtW+Oi2mj0UlzPA4U5YCk/MppghSBVuW
rFD8dErR5E+s2mqox4C68LRzQfuWypIOKmYd1O+chKU/doxMz8goKkwAzXhVc2Ct
z3AExHmYvJfyr/HcmRvLww5h/WYTpOHMSb95jRlmQaGTMK4BprcKdOyWM57ksduf
x6m4JQZmAYCHLrZ0hFvc//fs8iAEw1Kry63vaOikn3nDpSAZgwABJ7WN9j5NF2hr
Q7xow8LNdNEFQFD4FerHgbjW4vgdZh/x7S8YN+HoCdDsizjVqnN0DlIlI0sxxxpn
HULu5ef2n4ExtMCtoUAhbwsV4VIbOBWuoTEXkrjkiM40Re3+stF3bZhHbUFbyyKt
iclwXE2IKNiO7/F1tslNPRDf1gUmRzFRNDgOvMV/bgo2X6QbyLmSjNvxVVTw4Oxo
aJ7TipjpwLYJPvJNGXYv
=xQrY
-----END PGP SIGNATURE-----

--JcoW9GTBOWmefD54dxnQN7gTuNHvT7efu--

