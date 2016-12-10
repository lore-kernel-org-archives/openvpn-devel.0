References: <20161209181303.20267-1-list@...1798...>
	<98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
	<20161209224646.1bc65baf@...1799...> <1481339215.461706744@...2211...>
	<20161210125742.101acc79@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ef735c39-ebde-2464-24d0-c26ef10fd39b@...2080...>
Date: Sat, 10 Dec 2016 19:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161210125742.101acc79@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8qGG4rxEeC8OuGCtwUd61LhssDh4Agrna"
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qGG4rxEeC8OuGCtwUd61LhssDh4Agrna
Content-Type: multipart/mixed; boundary="ag91PRrSH2oIm4QAPm49FCcxMPOkXv3qN";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <ef735c39-ebde-2464-24d0-c26ef10fd39b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
	systemd units
References: <20161209181303.20267-1-list@...1798...>
	<98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
	<20161209224646.1bc65baf@...1799...> <1481339215.461706744@...2211...>
	<20161210125742.101acc79@...1799...>
In-Reply-To: <20161210125742.101acc79@...1799...>

--ag91PRrSH2oIm4QAPm49FCcxMPOkXv3qN
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/12/16 12:57, Christian Hesse wrote:
> SviMik <svimik@...450...> on Sat, 2016/12/10 06:06:
>>> You can break this with something like:
>>>
>>> status /etc/openvpn/client/status.log
>>>
>>> in your configuration. Writing a status file
>>> to /run/openvpn-{client,server}/status.log works, though. So the default
>>> setups should be fine. Do we have any more cases where openvpn wants wr=
ite
>>> access for whatever?=20=20
>>
>> From my configuration:
>> 1) status
>=20
> That is fine if it is written to /run/openvpn-{client,server}/. It breaks
> with the status file in /etc/openvpn/{client,server}/ or example.

FWIW, the default SELinux policies actually denies any openvpn_exec_t
process to write to /etc ... I believe that is independent of Linux
distros, as long as SELinux have been enabled and the system is Enforced
mode.

>> 2) ifconfig-pool-persist
>=20
> That is a problem... As the name suggests this should be persistent. :-/

Same SELinux issue here too.  IIRC, these files needs to be located
under /var/lib/openvpn or /var/run/openvpn.  But I do see there is one
exception ... /etc/openvpn/ipp\.txt will be labelled openvpn_etc_rw_t,
which is OpenVPN is allowed to write to.

>> 3) tmp-dir (for storing openvpn_pf_*.tmp files)
>=20
> Never used this. What is it for?
> Anyway, I think this is not persistent stuff? Writing to /tmp/
> or /run/openvpn-{client,server}/ should be fine.

The openvpn_pf_*.tmp files are just one thing.  If you use
--auth-user-pass-verify script hooks or perhaps even --plugin for
authentication, other temp files are generated in the default tmp-dir.
See commit 4e1cc5f6dda22e9ff12 for more info.

>> 4) client-connect script may want to write something
>=20
> My scripts do some configuration and dbus-stuff, but do not write anythin=
g...
> Writing to read-only path would fail, of course.

Again, SELinux can again block this already ... unless you write in the
properly labelled directories for OpenVPN.

>> 5) a plugin may want to write something
>=20
> Same here... /run/ and /tmp/ is fine, other paths fail.

The same as 4)

>> For me even the read-only option will break nearly *everything*. And for
>> user it will be completely not obvious why his scripts doesn't work, why
>> his status file is not updated, and what's wrong with ifconfig-pool-pers=
ist.
>=20
> Well, the error message should include something like: "cannot open file
> 'file': Read-only file system".
>=20
> But this is more problematic than I thought initially.

If we have some directories which complies with the SELinux policies in
regards to read/write privileges, we should be fine.  And restricting
which directories OpenVPN can write to is quite sane.  All those plenty
of blogs putting runtime status files into /etc/openvpn have
misunderstood quite some of the concept of the Unix file system layout.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--ag91PRrSH2oIm4QAPm49FCcxMPOkXv3qN--

--8qGG4rxEeC8OuGCtwUd61LhssDh4Agrna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYTFByAAoJEIbPlEyWcf3yJkMP/2M8AvGyKhXky8Lrd362NphD
aZe6R77Y7MS9nFGw1GUSNnWxItw2qe1Cpst4eqZ9xQEWiZr7OLp9nmvcCpAOuv4+
C8T6DJgt56e6qlgmjt5PWino6E9nsRY7NX5RSXq0sJe08jcfgA3SPVXJCcQiMWre
/Vr9FCFVMu0YNaJOGuGtJ+QuZj2WZzwNGQ1h1t6uJGoKuVUPioMIB0J/115yjVGl
kLOXQc91GWKLVZlBa2Xe6zU7UBPKXTr5IFpCwV0yCERhBt9cMP4YYSuKX4Bgi48L
2YFMqNoejKqttdEw2Dt41kOaz3kosMxOs9eSoesr+UNMiSUD5cAesFvaujkt1ZlE
LEH6DrxMeZzxD1RktYzIChLOwn/ub2XJfQ29VQYRgM2/8fkgmDgRvEgw+cQs9LHt
tz2E/WjpA/pSHlURCBqoOswj/rl763CNxN0+nSm5SIB6KAoV7FKOjBdJIy+Q+nli
6+CwwjMhf70AsPW5B/QIRB5TwxKWj+Ph8swmzoh9iWqLBUNZBSTtZj5E4lhNaCq2
ZY9TYF4UZ+dNo/7ChsB2yv0rhcX7fydlqgCcmt1S+5Rn+/l/L+QjeZI/0cuOWvzd
XTjz9pPt8zUxw+bmA7yL4K/cz0pAqPHeO7GxGG2QMl1mM0gF5Jn6gyrVbVwirN2Z
8ZvuFMrXeAHeJoaBxS+d
=xn5u
-----END PGP SIGNATURE-----

--8qGG4rxEeC8OuGCtwUd61LhssDh4Agrna--

