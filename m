Date: Sun, 4 Mar 2018 10:08:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180304090817.GL69387@...1296...>
References: <20180228231123.27782-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZgGs4xYo94cs2XY/"
Content-Disposition: inline
In-Reply-To: <20180228231123.27782-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--ZgGs4xYo94cs2XY/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 01, 2018 at 12:11:23AM +0100, Steffan Karger wrote:
> As discussed in the community meeting of 13-12-2017, we should warn our
> users that LibreSSL is not officially supported.  We expect that it
> currently works, but it might suddenly break or we might decide to no
> longer build against LibreSSL in the future.

Generally speaking, I agree.

Should we also add a warning (+ sleep 60 to be extra-annoying?) to
configure if LibreSSL is detected?

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--ZgGs4xYo94cs2XY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJam7eBAAoJEB2Cnv7KVigSwRoL/27UyVUSK/8S1y7FtMAr8r+D
A2E4lbBe4cGSmWG7nSwnQtTAsYXEdNyDbRTgtmIEIrbf9TdDM68R5RzdpCzEVsIk
lbq4861iC9hf/4zn4RWEUyGS5wvGpffffnC8Iz49kbOYrFiILWOcDyUw8ioy5lXx
CytqYTsxKXJxbngl211MKHUQEFqyylNpnNGh7XfRlefzeGecpeLmk2NEzMXZoDyQ
PaafBkrWd0pPZP+//041HseHj9rBCpyR8qpOYhBPO79VH8Sy92N0UShG/qHaksp/
VrHBxw0c3wobcKqmcp9/vIViXbhEfutR63grOroWwRJ2WC/I4h14QeEnMxSzY2kR
/kjQzYYl2l1opxKN4DKm8DOOLCzhDmHyiwyTka5UWPygrClPE6lCxUoQtkzQMqDV
H/4U9N2svoDPXPR69lRO5KVL4mi8JSlpIQZ0zkMhAzi0YnD3Fpoo899N3QFua9se
RM2lgqFXJO9KeGiBa+7ZIn1Dl6QBiipVGEV1IX1Jxg==
=HbQS
-----END PGP SIGNATURE-----

--ZgGs4xYo94cs2XY/--

