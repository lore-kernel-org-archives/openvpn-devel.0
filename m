Date: Tue, 29 Mar 2022 14:23:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkL6OdKnIofef0vr@...1296...>
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
 <YkLn9u3YVo5cuiVn@...1296...>
 <43eeed40-b1e6-798b-038c-d69febfbd77e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5ZBdkZ3EK1foY1Gg"
Content-Disposition: inline
In-Reply-To: <43eeed40-b1e6-798b-038c-d69febfbd77e@...2181...>
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Timo Rothenpieler <timo@...2669...>, openvpn-devel@lists.sourceforge.net

--5ZBdkZ3EK1foY1Gg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 29, 2022 at 01:50:33PM +0200, Antonio Quartulli wrote:
> On 29/03/2022 13:05, Gert Doering wrote:
> > @Antonio, we should really investigate that capability stuff :-)
>=20
> I think this was already discussed somewhere else in the past. To talk=20
> to the netlink API the NET_ADMIN capability is required - no need to be=20
> root.
>=20
> Therefore, just grant this capability to the binary with:
>=20
>   setcap cap_net_admin+eip /usr/sbin/openvpn
>=20
> and then launch it with any user you want (no need to launch as root and=
=20
> then drop to user nobody, unless there are other reasons for doing so).

This is indeed nice.

What I was looking for was more the "if we start as root, assign=20
NET_ADMIN to ourself, and then drop user privs" option.

So, no need to fiddle with system install - which is a bit risky because
that way, anyone on the system can run openvpn with NET_ADMIN privs, not
only those users that have sudo rights.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5ZBdkZ3EK1foY1Gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiQvo5AAoJEB2Cnv7KVigSV14MAJ542Gjj18LTjFwUnOo1m9jK
KXEwrcsjkKtNzyHqc470sk3Xt15shKQwRb2lVV+LrmW6WlPKe/Am+KEhowVBZMvU
7tj8AMQsqyJNe/F8YZIwxKJKioc/C6ED9sQoYQY4+m968aTLkbLzM/n+2bZu917A
J7dn56ZNCNevHyDGHGwWQvjLjTsYMFkKtetjq0xlpwun0kmGoUSaaA5r9CNtF7pO
2ZmCJZx6PKIpztu5tfekiBEd5CoLVJ7LAVar4oyXlDy53kgsfq4zfSf0Q3HhxSLl
hvmApj3oN5W7ciPmedwzrCa4H9a27GTMgncB5d37qwxgPICeE6SnnLH13znMB6+A
QmraSjvAHDZa6GZLJaiLfKe9M3IIAcG/fnZcOFMt9uoVsYJ46WEFlGVJUQwzihEU
zo9VFEj16aC0u6G20e3y36TANjpds6u5W6wwV0eKBhg5vykyfY/sb/UrAs+2IYVZ
mR9nEAqUOki1Ed7iOPyGpp7FHewu0LM4z2v33ZxN8A==
=GsNi
-----END PGP SIGNATURE-----

--5ZBdkZ3EK1foY1Gg--

