Reply-To: openvpn-devel@lists.sourceforge.net
References: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>
Date: Fri, 5 Jan 2018 20:48:32 +0100
MIME-Version: 1.0
In-Reply-To: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AfzZLk9tOSS0milmeQovw6oAPSQAnK9OL"
Subject: Re: [Openvpn-devel] [PATCH] Check for more data in control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AfzZLk9tOSS0milmeQovw6oAPSQAnK9OL
Content-Type: multipart/mixed; boundary="hpamaavcgqGvLYqbgnxBEkl7xOwCasHCV";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Check for more data in control channel
References: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>

--hpamaavcgqGvLYqbgnxBEkl7xOwCasHCV
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/01/18 13:07, Steffan Karger wrote:
> If control channel packets arrive quickly after each other, or out of
> order, there might be more data available than we can read in one
> tls_process() call.  If that happened, and no further control channel
> packet arrived (e.g. because the last two packets arrived out-of-order),
> we would wait for 16 second ("coarse timer") before we would read the
> remaining data.  To avoid that, always schedule ourself again if there
> was control channel data, to check whether more data is available.
>=20
> For mbedtls, we could implement a slightly more elegant "is there more
> data?" function, instead of blindly rescheduling.  But I can't find a way
> to implement that for OpenSSL, and the current solution is very simple and
> still has quite low overhead.

I haven't looked at the code paths yet (except of the patch itself) ... but
how will this affect a server config with a bit of load?  Like some hundred
connected clients or more?  Will these other clients notice that a client g=
ets
rescheduled instantly?  And as well, what if more clients trigger this
behaviour approximately in the same time window?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--hpamaavcgqGvLYqbgnxBEkl7xOwCasHCV--

--AfzZLk9tOSS0milmeQovw6oAPSQAnK9OL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaT9aYAAoJEIbPlEyWcf3ywO0P/2zZXmVnsVjTXg2cn6LSYctK
5/8p8/AadR9R5QESbYp8MEUF7Uiq8h8CnDZF/Ix6e9tqR0QARcecdCgrynPgK8Qc
762c9zr4YRGqYbZPdKiLfM9EofhTf0bhlnEMzzt6sYFcZmyoPM4XlOpQoq/xgjlQ
S8jbxZ+1TEpr2LnZliaeZtmWeku67vsAN1kg0zPnHmBy0CRrm3tDpijjv+0IIxi7
tIAdOD7QyrGjGl/wYsl93C3tVDyuCMoOv+7lR+l1puB6Iyq8AVoJPGJZj84klYNf
CtV6EUcMJHhb7s8od2iPdRN3At6rMrmW+4XezhrOlYbCFx5Uf7SA7KriBadHwFpu
gwuhQ7SaGI2M45/q2RlcdgVffEnKEWZ+0wjbSSm3RqwYqmYCsMUGDjmlKkoGPnRm
dSgf1jISYEGfgFXPjDc1D0UyF1h5kUJ0swaFJFucL2BkSxjuLU82DJjLwBw7hipf
DvE2YaSnsoqJqJTMVIFpziHs1snZA/njvhjVLnHYk1AUWpJ6LQ6x77M08Nj1kJqW
RkJBP9fP8K3sbGwAWvXXBCQxS4/FSQ+ex+xG3y2C9jLWRf/g8CbwMqSxJZ3/9MHJ
+Jthf0vMc/hEHumiq+abOI6kcATIk7kJyanSLateuKgXYnF+wgk0bxXR41cWee41
tTOCslPaWAkmH5qe10uU
=7NEg
-----END PGP SIGNATURE-----

--AfzZLk9tOSS0milmeQovw6oAPSQAnK9OL--

