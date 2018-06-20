Date: Wed, 20 Jun 2018 14:52:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180620125229.GW57262@...1296...>
References: <20180620044650.18041-1-rosenp@...277...>
 <20180620050012.GR57262@...1296...>
 <CAKh=nwE8OzcA1e7et3Xc=MtdanG4SBc7vAFaFGC=7T4_CmsP9w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hlLYEVRsvGBW9AqF"
Content-Disposition: inline
In-Reply-To: <CAKh=nwE8OzcA1e7et3Xc=MtdanG4SBc7vAFaFGC=7T4_CmsP9w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with
 deprecated APIs disabled on 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: Gert Doering <gert@...1296...>, rosenp@...277..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hlLYEVRsvGBW9AqF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 20, 2018 at 02:40:43PM +0200, Emmanuel Deloget wrote:
> Can you give a better explanation of the issue ? (I'm sorry, I try to
> follow the discussions on the ML, but I'm kind of slow (and busy,
> which does not help)).

If I understood the discussion right, you can compile OpenSSL 1.1
with flags that remove APIs that are considered "legacy, deprecated" -=20
and if you do so, OpenVPN won't build anymore.

I have not looked into details - I saw "20 extra #ifdef" and decided
"this is not how we (well, Emmanuel ;-) ) do things".  And thanks again
for doing the 1.1 support in a way that results in clean code without
#ifdefs ;-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hlLYEVRsvGBW9AqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKk4MAAoJEB2Cnv7KVigS9rcL/jMYlsLPNATXIlzuUsnSXXhW
/gHJAH+gi0W7m16rrHmwG4rH8+/PDOOWGcEOsCawz4AFSDwNgWcDyu8HufjGOjJq
V3uD2WuyujOiqfVpeidXk1bdmFiYr9sJn2AJM4YUkYdX/xks4BkWjctX5nL9S7Kc
dIwT3kHq0429doNeROUb7BTsTh+3y9Iz3PkbOPiqDhNiLvsLSBjSEDHg+P2fn/Ck
DrZE5OeiZAVPzdALfxzLZt4z2eBjnLju5OkFtoCtpr5ox0zd1lJCWf4ftFtgWvem
K6pn+fFa/YmLqaesAtIjf0MtR3RaFmN6yhH14VR5RFr8eP2PmLhi2aOHL6q4+pKp
Am4FapOVJ/K6LRmCb078Ic7yZpCk2bvQruXlxgGQtCiterbnLc0W1U2yhoHklKvF
ZrPk9YBP+i5l+xAOaduLsPNkrkWRT8eSVaabE4ii9VzQcbpzdotgrJUZew4AZTPz
C+5XQTlLpVs/1dv55aKIFQxdMMrFoiSmIuiqWZWP5Q==
=jtP7
-----END PGP SIGNATURE-----

--hlLYEVRsvGBW9AqF--

