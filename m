Date: Mon, 13 Sep 2021 12:21:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YT8mQDZcS6d+mCX5@...1296...>
References: <20210903161113.30498-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tjCtK+m7LecVNKYc"
Content-Disposition: inline
In-Reply-To: <20210903161113.30498-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] networking: add and implement
 net_addr_ll_set() API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Jan Hugo Prins <jprins@...2634...>

--tjCtK+m7LecVNKYc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Fri, Sep 03, 2021 at 06:11:12PM +0200, Antonio Quartulli wrote:
> Reported-by: Jan Hugo Prins <jprins@...2634...>

Jan Hugo, have you been able to test these two patches?

I could set up a test rig myself, but since I do not experience the issue,
it's always more useful if an affected user reports "yes, it works for
me now" :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tjCtK+m7LecVNKYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhPyZAAAoJEB2Cnv7KVigSN18L/jFhw0q4/9fZnio+N3MEsxqR
LZ091ug+TwYY4mP/pNcHiRO9rOBTTre7EdCQXybZvZOqNv3fO5v+Cw3Q9Nc+uHUv
mUMyh1XfofjaPqUubJrO9IUJf5WdL3K2y1VSfK9/nmGZTvE3sm6L5tQihh4Wp2cW
P8fjiQWYgmXIck1bjMsvAFTDkNyuLemskUkBHXKeWqjnNIB+4MuP9jya7WZy6FRL
xTosP6cAEM6gT09MQ0EaG8PL2+zIfvF1k815g1yIl/jxbc0qzMnqQcB4TQ+GN9bO
yWXjv5Zk4JF5omcMGFIMbXwvdjA/s4T3o5ipJOCjUcUecvRRg7kKReWxwgkZtDjd
RrpkJioLSLwolrCxfS9AVyrGE6dBa/w5GDWD5UDoJFt0gZ33gdtD7V25fSxow1LL
3Sqd2Kaf3ojqeYYuqEHBRVzoxIVaI+c9iWGOmF+Dqp4iUqLUTMyyRiEuRBumObW6
MwaiRy7t1gUFJzbb7PLf33TRP9hhWrW94nMukr2yfg==
=ciUw
-----END PGP SIGNATURE-----

--tjCtK+m7LecVNKYc--

