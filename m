References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
	<ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
	<20161210130837.49dd32b5@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e59af82a-9bdd-f4ef-bc49-261be6542742@...2080...>
Date: Sat, 10 Dec 2016 19:43:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161210130837.49dd32b5@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Alsi78PIbEK76nUW3iX48uouheE6tVeLU"
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
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Alsi78PIbEK76nUW3iX48uouheE6tVeLU
Content-Type: multipart/mixed; boundary="pkr7BoK3OITVSJlg7Jnd51L9bcQDxff1x";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <e59af82a-9bdd-f4ef-bc49-261be6542742@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
	socket into chroot
References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
	<ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
	<20161210130837.49dd32b5@...1799...>
In-Reply-To: <20161210130837.49dd32b5@...1799...>

--pkr7BoK3OITVSJlg7Jnd51L9bcQDxff1x
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/12/16 13:08, Christian Hesse wrote:
> David Sommerseth <openvpn@...2080...> on Sat, 2016/12/10 01:03:
>> On 10/12/16 00:19, Christian Hesse wrote:
>>> From: Christian Hesse <mail@...1798...>
>>>
>>> sd_notify() uses a socket to communicate with systemd. Communication
>>> fails if the socket is not available within the chroot. So bind mount
>>> the socket into the chroot when startet from systemd.
>>>
>>> Unsharing namespace and mounting requires extra capability
>>> CAP_SYS_ADMIN.=20=20
>>
>> I will pick up this one after 2.4.0 has been released.  This is a very
>> promising approach.  However, I'm not too happy about CAP_SYS_ADMIN
>> though, that grants quite some privileges.  Can we look at dropping this
>> capability once we know we won't need it any more?  Perhaps when we send
>> READY=3D1?
>=20
> Never tried to drop capabilities... Have to look into that.
> We do no longer need CAP_SYS_ADMIN after the bind mount. (Or not at all
> without chrooting.)

Sounds reasonable.  Since we need to take CAP_SYS_ADMIN out of the unit
file regardless, we need to drop the CAP_SYS_ADMIN capability inside
OpenVPN anyhow.  Just need to figure out the best place for it.

As a pointer for managing capabilities, have a look at the capsetp(3)
man page.

>>> +              char * chroot_notify =3D NULL;
>>> +
>>> +              if (sd_notify(0, "READY=3D0") > 0)
>>> +                {
>>> +                  asprintf(&chroot_notify, "%s/notify",
>>> c->options.chroot_dir);=20=20
>>
>> Here we should use the buffer/string functions, based on the gc_arena
>> implementation.  Unfortunately we do not have a direct equivalent to
>> asprintf().  A starting point would be to for example look at the string
>> handling in print_sockaddr_ex() [socket.c:2386] or x_msg_va()
>> [error.c:251] ... there might be better examples too, I'm just not able
>> to remember them now :)  .... buffer.[ch] keeps most of these functions.
>>
>> The reason for this is basically to use the same well tested
>> infrastructure.  And with gc_arena, only a single gc_free() is required,
>> regardless of how many buffers you allocate to that arena.
>=20
> I do not like this myself. The patch is just a proof of concept... So this
> should be polished before committing. ;)
>=20
> Thanks for the hints, I will have a look.

It's a great PoC!  And good to see that we might find a solution for
this.  Will look forward to dig deeper into this in the coming weeks too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--pkr7BoK3OITVSJlg7Jnd51L9bcQDxff1x--

--Alsi78PIbEK76nUW3iX48uouheE6tVeLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYTEy2AAoJEIbPlEyWcf3yKi8QAKLfKiTQN6T0QFx0jttLqX9M
Ao9fNVQPnRVI2/fI98WavfVQyZytBG8SRYj8Rh7wRybMsPGKvYrb3tlIi8yVBh0L
KO3M08FyR8s0afKyFkj00UZP89frs2WeImYARl4HtJNuio9aCvukaDf1oRkC2UP+
j/3Tqd2Op57lw+ID9J5KmagcM3lUEjyRpytbktsHfF/ReZ+fv5lwxGlxVrDSQgv/
QRrFZm3AaEgVuZffSjlvp/NwheK5bo0eW7ukAXLoKOHPGVQl5q3mIsIJCbdmr3Rg
K8teuRll30NAKS9D6daNgeJeBAsw5GjHLsVEZxTRw0OZKN9BIrhlzUFHWqnsP4Zf
ZgTIo9nwHqjPEkvx/+TSfKasO7vm3MFjWJQ0ZhoWDJtgJ9+aZUtHY5eSKDmrrFOd
EH74wL5uzo57gYIR+hodMAKMhEln6fz9MV9TaGIorWKSsHL+nDqgIxJDA3qB4hfK
NkHhZUumHQk+gM6CYMTHdf6ixGWRwtyE9KuTqQ0F7OkS94lHJFcwDw/KPabWGapN
YFZ0zMrA9mEBAqPr/4bpcldSAFA0ug3Tf6CcOc2FlpIsadSu6sgESMU1j2LiQhiQ
6TObQwZCQiW5XkN+HtW6YJqbQWgGs7uLlFn1UV1dNMNVEFHZ5YEaa+XivtLPOz2x
VYe7YKqY/Cs+qfdwCfar
=0sKg
-----END PGP SIGNATURE-----

--Alsi78PIbEK76nUW3iX48uouheE6tVeLU--

