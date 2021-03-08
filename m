References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
 <20210307212830.GT976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7af7e1bd-d49f-35c3-3044-44852f4be4c5@...2080...>
Date: Mon, 8 Mar 2021 20:47:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210307212830.GT976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L9Ca6h6Uu21aM0XbhzwAuu5O3yMZnvoYT"
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L9Ca6h6Uu21aM0XbhzwAuu5O3yMZnvoYT
Content-Type: multipart/mixed; boundary="n4MVRT4sfDW32eZPE9ltgBqw3hEQGUUrC";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <7af7e1bd-d49f-35c3-3044-44852f4be4c5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
 <20210307212830.GT976@...1296...>
In-Reply-To: <20210307212830.GT976@...1296...>

--n4MVRT4sfDW32eZPE9ltgBqw3hEQGUUrC
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/03/2021 22:28, Gert Doering wrote:
> Hi,
>=20
> On Sun, Mar 07, 2021 at 02:20:32PM -0500, Selva Nair wrote:
>>> That's another possible angle... just up soft+hard to "something"
>>> (how much would that be? :-) ) and log the fact.
>>
>> Rereading my comment on Trac #1059 I recall testing this and concluding
>> 100MB enough for clients. On modern machines that's a low amount of memo=
ry
>> --- not allowing swapout of 100MB should be acceptable.  For servers, I
>> think there is no reliable limit that we could come up with.
>=20
> This is interesting.  My machines, including servers, have a way lower
> memory usage - but I'm not using EC.
>=20
> Here's a linux server with 3 peers and a client (arm32):
>=20
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root     14569  0.0  0.5   5704  2980 ?        Ss    2020  12:31 openvpn
> root     21020  0.1  0.5   5568  3040 ?        Ss    2020 454:45 openvpn
>=20
> Here's a FreeBSD server that serves 5 clients right now, but has peaks
> up to 150 concurrent clients (amd64)
>=20
> USER      PID   %CPU %MEM    VSZ    RSS TT  STAT STARTED          TIME CO=
MMAND
> root     5023    0.3  0.1  30924  23172  -  Ss   20Dec20    1945:07.12 /u=
sr/local/sbin/openvpn --cd /usr/local/etc/openvpn --daemon
>=20
> ... and another two Linux server instances...
>=20
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root      1138  2.1  1.3  26732 10628 ?        Ss    2019 21678:18 /usr/s=
bin/openvpn
> root      2897  0.8  0.9  29548  7080 ?        Ss    2019 8596:15 /usr/sb=
in/openvpn
>=20
>=20
> the last 3 see a high number of clients during work time, and quite
> some churn (especially due to iOS/android connecting and disconnecting
> frequently), but long-term memory usage is not high.
>=20
> So there must be some massive transient usage due to EC at reconnection
> time...
>=20

FWIW .... A couple of my CentOS 8.3 servers with 2 client connections
running 24/7.

* Server 1
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
openvpn  3437979  0.0  0.1  76360  2924 ?        Ss   Feb25   2:19 /usr/sbi=
n/openvpn


* Server 2
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
openvpn  2805670  0.0  0.8  76624  6896 ?        Ss   Feb25   7:08 /usr/sbi=
n/openvpn


The start date is from when openvpn-2.5.1 got released and updated.
OpenSSL 1.1.1g-12 is used on both hosts.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--n4MVRT4sfDW32eZPE9ltgBqw3hEQGUUrC--

--L9Ca6h6Uu21aM0XbhzwAuu5O3yMZnvoYT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBGf0sACgkQhs+UTJZx
/fLE3A/9GV/ATvzhEfk/cWUcg851Mu1ZwFSSOve+7VPFNnYdjj8X9bbBSrDiiOB9
la7iGATyHnQXb4kCfvo/vzTCHffUQzag9Sxrt2JJGLNtTnnjYsMiF/k1MjuaM57z
uT+rp9s6CvZyhiYd1QxGrmF+psXYc7Zkv/GfOwUob5/dVRLLGT950NRHr53A6ZSw
GM8UXo9rkZt/zPmO/vpboUE6cIbTPsfQQToVUT0Q3wNStkxs/wZ/VlKpdMIkAfEW
F8RbZvXM8l5t50lHwfNMrqoVZnTm0Z2t7XWU+pM4eXYeZ4ZpCCE1vIYvuR+5LQ1r
FtXqLF7lUd0WzPvzDgvsnJRasJjlMoCXMxYHamu3tyTYzN+xCXxNwh1SNH8U+aKL
88eydu6l7HfGxBcmdjJXpwgCRfXnsC56YdfF2j+ymzQ24/m6fMWArDWZcR7qGJBJ
BRnGNElydlCe5nm7SKrRWKbB7lmHZBOgWNSeMBI34yZhz327a6qqFlJvPt90zg47
0a44E2DJ+CHksiPMgG7Dn+aZ7JlfgBloOiTWZDLj34yMhyG4ZNeqLFuG1iN5qEWx
hsqhoLVpb1JVSmANX4KApecEWVCnCp/NLR8JnZR9MWLg2yTEmftZgHpZx2NOkXYs
RwykN8nTqItsCdx/lS+zhCapVtGUWADiOLTqLe48NiMd8VCDRBM=
=+fjO
-----END PGP SIGNATURE-----

--L9Ca6h6Uu21aM0XbhzwAuu5O3yMZnvoYT--

