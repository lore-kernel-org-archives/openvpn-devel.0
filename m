Date: Sun, 23 Jun 2019 20:54:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190623185408.GQ1097@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aRzsUE0Mp86t8N62"
Content-Disposition: inline
Subject: [Openvpn-devel] [builds@...2512...: Still Failing:
 OpenVPN/openvpn#874 (master - 7473f32)]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--aRzsUE0Mp86t8N62
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

travis CI builds for MacOS fail (and have failed for quite some time,
it seems) because LZO is not installed as pre-requisite - the configure
run in the log below ends in line 632 with

 configure: error: lzo enabled but missing

... but it *should* be built by ".travis/build-deps.sh" - so it seems
that script is failing.  In any case it is not communicating errors
back to the caller, because otherwise we'd see the output in the
main travis build log...

Not sure what is needed to fix these two issues

 - get output from build-deps.sh in case of failure
 - make the failure go away


A naive reading of build-deps.sh seems to suggest that "build_lzo"
is only ever called on MinGW cross-builds and not on MacOS - so, that
would explain why it's not failing.  But then, how to teach Travis=20
that we want LZO?

Anyway, I leave this for somebody who understands Travis-CI better than
I do to fix and send a patch.

gert


----- Forwarded message from Travis CI <builds@...2512...> -----

Date: Sun, 23 Jun 2019 18:44:30 +0000
From: Travis CI <builds@...2512...>
To: gert@...1296..., steffan@...1856...
Subject: Still Failing: OpenVPN/openvpn#874 (master - 7473f32)

Build Update for OpenVPN/openvpn
-------------------------------------

Build: #874
Status: Still Failing

Duration: 20 mins and 54 secs
Commit: 7473f32 (master)
Author: Steffan Karger
Message: configure.ac: add lzo CFLAGS/LIBS to the test flags

This fixes "make check" builds on systems with lzo on a non-standard
location.

Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: David Sommerseth <davids@...515...>
Message-Id: <20190602101831.21216-1-steffan@...1856...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18=
482.html
Signed-off-by: Gert Doering <gert@...1296...>

View the changeset: https://github.com/OpenVPN/openvpn/compare/06f65a0cbfcb=
...7473f326366f

View the full build log and details: https://travis-ci.org/OpenVPN/openvpn/=
builds/549429549?utm_medium=3Dnotification&utm_source=3Demail

--

You can unsubscribe from build emails from the OpenVPN/openvpn repository g=
oing to https://travis-ci.org/account/preferences/unsubscribe?repository=3D=
6518989&utm_medium=3Dnotification&utm_source=3Demail.
Or unsubscribe from *all* email updating your settings at https://travis-ci=
.org/account/preferences/unsubscribe?utm_medium=3Dnotification&utm_source=
=3Demail.
Or configure specific recipients for build notifications in your .travis.ym=
l file. See https://docs.travis-ci.com/user/notifications.


----- End forwarded message -----

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aRzsUE0Mp86t8N62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdD8rPAAoJEB2Cnv7KVigSc/EL/ivzasB1PdONK401arn7rNkv
iR0tDICD9WrrFmPhYoMagqxuwUPYW9h/rDM+jEMlRaHy37JAyDD3HznsN5ySZ5/Q
R1OTu9A85YPG+uQ/X+Tme0vjGYUfAERsVU51plKdi3tP/ozaAndy6aB/Iwdtzz1s
5Q/lytH1iUJmnrhfe/oSKxfFE/FKgvelyTkFh624s58lKJMeYw0UYLwM0pV1ylj5
CWoApWCmNKreDiHwA8sclhvL3ywbysArn9nOyglVFhbJJqpcI0iKXsHiQKPpa2ED
TBP7jQKWXkqVzPXlng5UlA32OWARL9Ey75jTxyhUGVKDMmQapzvrQWdQkE+cNv7j
RxsCDhQNQRLFXP//DBGSN7JFjdDpGq3a6oRJStXRYnswmPNMa6qHvCTz2TSkUL+8
NadvT4f+/XHF2F+C2jloV2VxLwdgv5rRi9lxr6KBmfJUpRThVHlYj7VFZXsgBJb9
z0LDXetlUcFEuo4dbUO21506esj/4agVA7OFp6iX7w==
=85OP
-----END PGP SIGNATURE-----

--aRzsUE0Mp86t8N62--

