Date: Tue, 22 Nov 2022 19:32:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y30VvTxrLTceAGrU@...1296...>
References: <024a01d72508$551785d0$ff469170$@yandex-team.ru>
 <20210507135022.20382-1-themiron@...2010...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="69m/pqXgmdPsjxPr"
Content-Disposition: inline
In-Reply-To: <20210507135022.20382-1-themiron@...2010...>
Subject: Re: [Openvpn-devel] [PATCH v12] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

--69m/pqXgmdPsjxPr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 07, 2021 at 06:50:22PM +0500, Vladislav Grishenko wrote:
> DNS SRV remote host discovery allows to have multiple OpenVPN servers for
> a single domain w/o explicit profile enumeration, to move services from
> host to host with little fuss, and to designate hosts as primary servers
> for a service and others as backups.
> Feature has been asked several times already, should be useful in case of
> substantial number of clients & servers deployed.
[..]
> v12:
>     add get_cached_srv_entry() for servinfo vs addrinfo cache split
>     add check for mixed --remote and --remote-srv
>     add doxygen dns srv functions comments
>     use query_servinfo() for both unix and windows
>     fix undefined NS_MAXMSG issue on macOS
>     fix undefined EAI_NODATA issue on FreeBSD
>     fix man and msg() indents
>     rebase against master

It has taken us way too long to properly look into this patch, and with
2.6_alpha looming, it's "now or 2.7".

As expected, this no longer applies due to conflicts all over the place -
this is easily fixed, and I've done so (and will send a v13 based on
current master in the next mail).

There are other changes related to intermediate commits, like the
removal of "--explicit-exit-notify & TCP is not allowed" check, also
adjusted, extra projects in openvpn.vcproj, etc. - I think I have covered
all of them.

The crucial issue right now is that the whole resolver stuff does not
build on OpenBSD, because there is no ns_initparse() and friends -
but there *is* an getrrsetbyname(), which seems to do the same thing,
except "not available on Linux".  There are various posts online that
describe the problem, and the possible solution space - like this one

  https://fossil-users.fossil-scm.narkive.com/wEIH279H/smtp-c-build-failures

so you could basically do

  - add private ns_initparse() function, as they do in "vlmcsd" (whatever
    that is) - https://github.com/sunflyer/vlmcsd/blob/master/dns_srv.c

  - use getrrsetbyname(), and add that via "compat" source if a target
    platform does not have it - this is what OpenSSH does

  - add #ifdefs to disable --srv functionality on OpenBSD
    (which is not really where we want to go)

  - require libbind on OpenBSD, and ensure includes & libraries are
    handled in the proper order (<arpa/nameser.h> etc. needs to be
    pulled from /usr/local/include/bind/ etc.)
    (this is also not really what we want, adding extra prerequisites)


Unfortunately, without someone actually doing this work, this patch can
not be applied - it will break a fully supported platform.

I'm sorry that it took me over a year to get to the "fix this or it can't
go in" point - I thought that this was all sorted out already in the
EAI_NODATA round, and all I had to do was "come up with some test
scenario and then merge".

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--69m/pqXgmdPsjxPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjfRW9AAoJEB2Cnv7KVigSQXIL/RF91ihc024hSRe7VmzXmQmA
zrfJ7EXztbF+nC7SzGOixrV85Oqq42dGPUxRhEAdT7t/jUb5nWGY9vKxJshXZOni
8HwcM6z13At+nN3c0trA3kUi06c7wFXYGjQqQZRhiP1SMIiLHQ3vPe+vaP8qCN43
stDRVwEjHSUg810W66Of0dOZnQuSd4y6twIV+8WSc45NRBs48l49AIgsmTcgnMSX
ouYf9LAlnrLPMm2YZ2SaLSAxYAXnxkNJ58QuD7Zg3KXG5e1i5+dRIGpUQK5xSANJ
5d4kzb32t7smO2b4E9Cky/mH5dkX2RSmWpeoVt9SaHBmBujAmz6StTH67AdchvTR
PKamMcx1mrZZItpARu+BoTxMwKZYxvpUlHMackX80dv/lKuPRF16BxMjzb6XUJti
MhzXJ4XbOfup1cB+oXMbdWpZL8o52QyxHiDLzQVUWKxuWeu7Uw/ZBMzlQtpnlKMb
udI5aCKMenpA9vCQ189tkhaH+GEOZWgREOZvY4OK1A==
=ppM2
-----END PGP SIGNATURE-----

--69m/pqXgmdPsjxPr--

