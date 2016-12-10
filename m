References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
	<20161210122923.GF78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a0e3d808-acf8-8e29-d0b8-d528aaa769db@...2080...>
Date: Sat, 10 Dec 2016 19:37:18 +0100
MIME-Version: 1.0
In-Reply-To: <20161210122923.GF78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="E0qGSLQMGudsf3uqUq8IjVLmwiOLvMuIL"
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
 socket into chroot
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E0qGSLQMGudsf3uqUq8IjVLmwiOLvMuIL
Content-Type: multipart/mixed; boundary="7TUouw1OOaF4xqpjtd6gArUvpwG2geiaI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>,
	David Sommerseth <davids@...515...>
Message-ID: <a0e3d808-acf8-8e29-d0b8-d528aaa769db@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
	socket into chroot
References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
	<20161210122923.GF78624@...1296...>
In-Reply-To: <20161210122923.GF78624@...1296...>

--7TUouw1OOaF4xqpjtd6gArUvpwG2geiaI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/12/16 13:29, Gert Doering wrote:
> Hi,
>=20
> On Sat, Dec 10, 2016 at 12:19:07AM +0100, Christian Hesse wrote:
>> +              int fd;
>> +              char * chroot_notify =3D NULL;
>> +
>> +              if (sd_notify(0, "READY=3D0") > 0)
>> +                {
>> +                  asprintf(&chroot_notify, "%s/notify", c->options.chro=
ot_dir);
>> +
>> +                  if (unshare(CLONE_NEWNS) !=3D 0)
>> +                    msg (M_ERR, "unshare failed");
>> +                  if ((fd =3D open(chroot_notify, O_WRONLY | O_CREAT | =
O_TRUNC, 0644)) < 0)
>> +                    msg (M_ERR, "touch failed");
>> +                  close(fd);
>> +                  if (mount(getenv("NOTIFY_SOCKET"), chroot_notify, NUL=
L, MS_BIND, NULL) !=3D 0)
>> +                    msg (M_ERR, "bind mounting notification socket fail=
ed");
>> +
>=20
> This is WAY over the top of what should go into OpenVPN code.  Really.
>=20
> NAK on approach, NAK on code.
>=20
>=20
> Is there a way make sd_notify() behave like syslog()?  That is, you call
> something like "openlog()" which will acquire the necessary file descript=
or
> and then you can afterwards chroot() to your heart's content and do not
> need access to the actual socket file anymore (because openlog() will
> keep it around for syslog() to use).

First of all, bind mounts are fairly common in Linux these days -
especially when you start to try to chroot/containerize (including
docker)/"jail" and otherwise isolate applications.  Chroots in general
are considered a bit too easy to escape from, unless privileges are
dropped at the right point.  Namespaces and other container techniques
are often somewhat better, but still does not yet provide the full
isolation many expects.  In this context bind mounts are often
considered simpler and to some degree safer than a full mount of /dev,
/proc, /sys, /run and so on.

Unfortunately, there exists no "openlog()" equivalent to my knowledge
for sd_notify() and other functions depending on the /run/systemd
directory.  But it's a good idea, and in fact such a "prepare for
chroot" in libsystemd could probably do such a bind mount for the
caller.  I have a good contact with one of the upstream systemd
developers and will discuss this with him ... so with time, we might
have something better.

Well, there is one feature systemd guys might throw at us instantly when
we open this topic ... PrivateNetwork=3Dtrue in the unit file.  But that
is useless for OpenVPN as then we will only have access to the lo
network device, all other network devices are unavailable.

> If sd_notify() cannot be taught to do that, either do what David proposed
> (disable chroot if running under systemd), or at least move that code=20
> out of init.c into something like platform.c.

That's a fair argument.  As long as thelibsystemd shipped in RHEL7 does
not, to our knowledge, carry such a feature which we need; implementing
this functionality inside platform.c is reasonable.

What I am wondering then is if we should implement platform_chroot()
which is called from init.c.  Where it will just call chroot() on
non-systemd and non-Windows systems.  When systemd is enabled and
detected detected it will prepare the bind mount, drop capabilities and
then call chroot().

Is that a reasonable approach?  Or would you prefer to have just the
bind mount stuff isolated into platform.c?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7TUouw1OOaF4xqpjtd6gArUvpwG2geiaI--

--E0qGSLQMGudsf3uqUq8IjVLmwiOLvMuIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYTEteAAoJEIbPlEyWcf3yNZ8P/jchztcSUKoEmrWjzj75iY3e
SMIak2Hc/OL0cmzVamj5We5hHcFNtuP8xF2uYNtrYvuXiai8jVdSe+QogU0OM5k4
9iJgySLuITD++g/tvq9r6xuAFg0ts46p65c4aMTcZkEHxjBqe0Apupz39O4yplYj
iBCnpd16P7XgjCRECkVu+vRZu5RYcqOsDYJjXRZHlngwiFrvBM68pz7yrn1eUI54
Oo7Hg0ryBqRsX6T4fw20VcRDLJJzwfVxfLQuLmrpgJiSItV7fR7xWC8M4wgisdcv
yI2QULRgVMsGm/3aude8KasD0C97pDeiIXRjbazfpWfnlz/NsEtKPfn78IH0LwUu
8fL7/qiDnZyZ+b+45oJN29+bi2Mz2LhWBHC9CxKzU+L+hU2Sk4p2D1Hn54L2WwpT
Wc+AMMN0U11QZnoMhiF0DunfVlrebiF2lYJsrxh/C/h3kyGugUjNK0xqbKYQHj8F
GvMGG8UqFqS4VBGFtjZY8PJ3VczrkIYRF1L6c5Ezw6vdwO1QNC6KHQ5/yGH/0DdO
s3HMfGv52RqcIg7B7M/bXh+8OTVCO0SeWpGJojNXO1bNhKS/1tix6w52fd06oFRZ
KdmQJ6AL15STAATS6Hk0kT37m7uAQmzX8uvwaHy7Wwg5AZyZNa0bPKrCBgyWFH5Q
2C9pWDF6bjomwIbiT8Hk
=if39
-----END PGP SIGNATURE-----

--E0qGSLQMGudsf3uqUq8IjVLmwiOLvMuIL--

