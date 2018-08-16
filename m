Date: Thu, 16 Aug 2018 23:33:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180816213346.GW74536@...1296...>
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
 <20180816113743.GV74536@...1296...>
 <1ae7f2ea-acf6-39ed-db8a-bc4c7d8c943b@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/d7X7C0hV/blnKmH"
Content-Disposition: inline
In-Reply-To: <1ae7f2ea-acf6-39ed-db8a-bc4c7d8c943b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>

--/d7X7C0hV/blnKmH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for your thoughts so far, so it seems we just want to get rid
of these conditionals for 2.5 :-)

One thing, though:

On Thu, Aug 16, 2018 at 10:28:05PM +0200, David Sommerseth wrote:
> There is also a related ./configure option: --enable-async-push.  This ad=
ds
> inotify support, which reworks the polling model to be a notification bas=
ed
> push model instead (iirc).  But this I think makes sense to have as it is
> today for the time being.  We might want to consider flipping it to be en=
abled
> by default, though.

This carries along some platform dependencies, as "inotify" is not
unversally available (I was about to write "Linux only", but I bet=20
one of the BSDs has it, too, by now :-) - but definitely not all=20
supported platforms).

Google points to "fswatch", which is

 "A cross-platform file change monitor with multiple backends: Apple OS X=20
  File System Events, *BSD kqueue, Solaris/Illumos File Events Notification=
,=20
  Linux inotify, ..."

so yeah - this has to stay an #ifdef for a while (and more esoteric
platforms like *cough* Windows or AIX might not have anything reasonably
compatible at all)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/d7X7C0hV/blnKmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbde26AAoJEB2Cnv7KVigSoJML/1qWTL0keDvN9TNjdDANmz+c
OOJLIXPPCvWa7vB/fzx/3exa2wp30GQJWDtFnejKA1//w4L1lxxdL78vwGDhdn4h
wNM1/wXA/0oSJpKzNhjK7MwVREZi96Wov/KKEsOeyEQvMAFNfX15aBqj77naoLdG
6xj6H1poXB79KZrhYKSNvLDr0aRH584GSr28LP4PcTA7qiRL1LYq9YEp5u1UzprE
W06ISr67psZ7YdngL/ROAYEElGbZcQ4pvSvr7Vn2fR/7Akx0f5D8MLptZTCesV0B
J8I445XQbkp3xIOdHjL1lUh4Hm9TMzad9bQqFvci+XB7d0FR4j9tL79lwz5AYyYS
9tFOjb+jZ1Topo1xZXo9a8QoaB/UOxH+GVaim+70ZfypliEPciLDvRb1irAuHyG3
GAK2Rub371xEHCUrFbX7wZWLvgA6wjCwPmevS+fSy8ca/JdlGJwB796l28TL4NVU
8jFYp3rFzw71Xf8P4dfgkpGboV746w4Y46XjqzSOoA==
=wGs9
-----END PGP SIGNATURE-----

--/d7X7C0hV/blnKmH--

