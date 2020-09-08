References: <20200908111511.9271-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8f5ce86d-f11c-4858-26c6-abc21200368c@...2080...>
Date: Tue, 8 Sep 2020 15:11:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200908111511.9271-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YP79IiLEqiqELhMa1L7zJmEY8n8TEC353"
Subject: Re: [Openvpn-devel] [PATCH] Document that --push-remove is
 generally more suitable than --push-reset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YP79IiLEqiqELhMa1L7zJmEY8n8TEC353
Content-Type: multipart/mixed; boundary="lSCKDpjzSkT8s0LwAoVejAjVxFQVCdbDV";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8f5ce86d-f11c-4858-26c6-abc21200368c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Document that --push-remove is generally
 more suitable than --push-reset
References: <20200908111511.9271-1-gert@...1296...>
In-Reply-To: <20200908111511.9271-1-gert@...1296...>

--lSCKDpjzSkT8s0LwAoVejAjVxFQVCdbDV
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/09/2020 13:15, Gert Doering wrote:
> It's a long-standing and well-known problem that --push-reset removes
> "critical" options from the push list (like "topology subnet") which
> will then lead to non-working client configs.  This can not be
> reasonably fixed, because the list of "critical" options depends on
> overall server config.
>=20
> So just document the fact, and point people towards --push-remove as
> a more selective tool.
>=20
> Trac: #29
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/man-sections/server-options.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-By: David Sommerseth <davids@...515...>

It would be good if --push-reset would actually not remove certain critical
options, but this is anyhow a good heads-up for our users.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--lSCKDpjzSkT8s0LwAoVejAjVxFQVCdbDV--

--YP79IiLEqiqELhMa1L7zJmEY8n8TEC353
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfV4MMAAoJEIbPlEyWcf3yWfMQAMervUjZjRgc3WeUYWaah8X5
pzKisIz0tIuxa4fVGSd5oXZWGJYGrpvuPcSmyYbE5RC5BPxTohi0mDZOA0dJLSaT
94rXT5Er5FIy4sk350sidi793R2ce5gMe41Km2HhxLSGg4uzibjUNcWohDjycSA1
4zAX1Sf4lCrmPHZWCes2qXXq3CKvcyC2pgyOntkUtOgbKwpCBRHLR19yGxXMXy1H
ql3RDhF0Dj8AMz+zNy5vf0WLQjKMMtrDxcYf6xLzE/dbB4v04zwV3cMeLnEvHxZ7
FuPnzp/96kxVKvkQ/1g9ZHNZhFBumxeS4MHn6SttiO1L2B1TPKTkDzCIDSmZbmLh
ekcQ/K+Kpm5Xy3/+RubZzbQTfkKxFiILj8t0KHJRy6WlYeQaSZ3bsrxBAO5498pv
qIX2ccE+Zzb+f7Kz5tdqhoPOZ4GKAAQbw9pAnPUTRXLy3n1gorYgmGeCddnlh299
DSxDigLcyK9DR8TvnAIObgcgHs+Ah/IEdFGuBVQ+VNXPqX8r+dXgFe/pBgkJnyVj
2FCOnMcJ+FtBYBxZO+MTWlJiNXxnM4Ptg+T5lYc3TcK3jTyg/IHpJ/Qnp0mmuM6N
G8rNn4A2QY2ysy7MschJHbHTyKOr2y1bUzubIEnqK6NXqgYmQJv8MSOjBjyWoCDH
f/znqMynGQ6qrVBi3jPC
=teLx
-----END PGP SIGNATURE-----

--YP79IiLEqiqELhMa1L7zJmEY8n8TEC353--

