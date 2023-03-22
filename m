Date: Wed, 22 Mar 2023 08:14:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBqqwXLhDCN9RCfH@...1296...>
References: <20230321231003.3582-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C5sD9SQ3yxN9JrSk"
Content-Disposition: inline
In-Reply-To: <20230321231003.3582-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco_freebsd: use m->instances[] instead
 of m->hash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Kristof Provost <kp@...1249...>

--C5sD9SQ3yxN9JrSk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 22, 2023 at 12:10:03AM +0100, Antonio Quartulli wrote:
> +    struct multi_instance *mi =3D m->instances[peer_id];
> +    if (!mi)
>      {

This (and undoubtedly the same code in dco_linux.c) is trusting the
kernel to never return peer_id values that are outside the array=20
boundaries.

Is this what we want?

I'd strongly prefer to have a check like this here

    if ((peer_id < m->max_clients) && (m->instances[peer_id]))
    {
...
    }

(which is what we do in multi_process_incoming_dco(), for example)


Note: in p2p mode, peer-id is something random, usually much bigger
than max_clients - now this *should* never be called in p2p mode, but
I still do not have a good feeling without the bounds check.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--C5sD9SQ3yxN9JrSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkGqrBAAoJEB2Cnv7KVigSs4kMALRL4pzYK2Q85ART7tttJh36
09gWRF+UnrYWe4vcw33ScOQHsPGgN0uYB+e4wwB+LzBXA3qDSRQ+cnmPYRnMEqut
IeaCYgOdvFVb3TiIWX05sCFcU/ZE4N3yQzi2mxRIRuEccd9rlm58gJgNQ0XS6Ccs
/I2RA/U3ucUYTP+0yJx3u7mqQz85HfGtq5ubrOrsbDgk9tzOg0YlR7xd2KcGtZOo
79B6LJJ+6w9zPl6VkRzBYuhLPr9qQ8GrT4sUUH56OHSzMH/UomwvIunP/ccsTqM5
9VlQFC763ixIEiIp82LKX/ZJEQIH4CnuHmasIByc+KX4TZtkiK5eaT9kcIMrB1FO
J9ODKhyriZn0z+Y0Gp0EidKug+HHGtscL5eeZJsSvhAWIUqcnl1H3YTB9btCb7C3
uTjxk0YEWUtcFRsxR3NsW46ihS7IzgvMZYUvDZ1vBEib909CLVR8MUC/nVRuk0uU
U6BKcrm31NbFQSHfgnkGKtguveHm5cR85ChBdkhnaA==
=vrnf
-----END PGP SIGNATURE-----

--C5sD9SQ3yxN9JrSk--

