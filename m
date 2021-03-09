References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b84e125e-c57f-9b1f-df85-225af72a0a54@...2080...>
Date: Tue, 9 Mar 2021 21:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <20210307184402.GS976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8C2wFrBG20Y3IaC7WKw3AHrpzk77yMKcr"
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
--8C2wFrBG20Y3IaC7WKw3AHrpzk77yMKcr
Content-Type: multipart/mixed; boundary="i83ocU27eUXrDcYbRvaUjjLaplKKuZdhi";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <b84e125e-c57f-9b1f-df85-225af72a0a54@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
In-Reply-To: <20210307184402.GS976@...1296...>

--i83ocU27eUXrDcYbRvaUjjLaplKKuZdhi
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/03/2021 19:44, Gert Doering wrote:
> Hi,
>=20
> On Sun, Mar 07, 2021 at 01:36:03PM -0500, Selva Nair wrote:
>>> "I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
>>> territory for me.
>>>
>>> What I understand is that root can *increment* the rlimit at will, but
>>> I'd assume that the rlimit value "in existance right now" (specifically,
>>> the soft limit) applies to root processes as well.  Sort of a voluntary
>>> protection against processes running away.
>>
>> On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies only=
 to
>> unprivileged processes -- privileged processes allowed to lock "unlimite=
d"
>> amount of memory as documented in man mlock. We updated the man page bas=
ed
>> on that sometime ago.
>=20
> Indeed, "man mlock" says something about "privileged processes" on Linux
> (it doesn't say that on FreeBSD).
>=20
>> We could also consider using setrlimit to increase the limit before
>> dropping privileges.
>=20
> That's another possible angle... just up soft+hard to "something"
> (how much would that be? :-) ) and log the fact.
>=20
> David, Arne, any opinion on this?  Where do we want to go?

I do think mlock serves a purpose in ensuring where memory pages are=20
kept, from a general perspective.  But does it really make sense in=20
today's virtualized world?  Where we're mostly having several GiBs of=20
RAM available.  I'm not sure it matters that much either way.  But for=20
those who care about memory security, it is a useful feature.

Since the code to enable this shouldn't be enormous (since we use=20
mlockall()), I don't see much winning in code complexity by tearing it=20
out when it may provide some security related features.


The unprivileged vs privileged process on Linux kernels change happened=20
in 2.6.9, according to "Linux Programming Interface" (LPI) [Michael=20
Kerrisk, chapter 50)].  I do not consider that an issue at all; I can't=20
think of any still fully supported Linux distributions with such an=20
ancient Linux kernel.  It should really not run security related tasks=20
(from a general perspective).

If I've understood the LPI book correctly, the default (RLIMIT_MEMLOCK)=20
is set to 32KiB for both hard and soft limits.  Clearly not enough for=20
our use case.

setrlimit() by itself isn't really that magical.  Basically you populate=20
struct rlimit with the limits you want and call=20
setrlimit(RLIMIT_MEMLOCK, &new_limits);   Plus error checking and all that.

But we should look into if we should acquire CAP_IPC_LOCK capability as=20
well, otherwise we need to completely ensure that mlockall() is really=20
called before privileges have been dropped.  I know I had to kick out=20
--mlock on a few configs a long while ago, related to lack of privileges=20
- but that could have been SELinux restrictions as well.  Need to=20
revisit this.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--i83ocU27eUXrDcYbRvaUjjLaplKKuZdhi--

--8C2wFrBG20Y3IaC7WKw3AHrpzk77yMKcr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBH2icACgkQhs+UTJZx
/fLpYA/+OJDZ2GPNdY1cfLuJs75DNJlWcN285JfJcn++SHpL55g7iKUdd4r/3DB7
pXEIDlsZzTHEJfgxPIlKjVNBJRYF4mG0hGU4ClgVUba0WW/lIguvbiDWxLEeVJrB
8sn9cPcUWVxC3oxVBHATVL86yxvH8uf/j3yGBUXMe/ncB6uFdIjG48LWKbxA9ah/
TfJsm2T3Qrlzx42vSymteknMy7TJZZSINLmFwFDMx3SAiCwDuCRDdre8JQjxPuAO
gqbyZxMmj46z9cbxMNJnvDrAEGYRDt7UELpRPd+R/jGcCqhSgySRQThGhwH2UOaZ
WU1t+ryH6K9xw7cXUriw1WOkNz2DIjtxH+PBgRZGG5U3/EK80eko0OTp0qAZ27Yp
46fDj6Ij+JhRIfgeq6FRIqQZXEgEbzPiUK5eJjMLO7Pk43fPClUIOORFi1bAmP7D
Nt/tHpl939avhH3tZMPxh1jqDEVEaX9FryJ2XT6574rnFpPCz+tbP+/2VxUxSIeJ
n/oduKF/YTFYfTmeud2Q7WXzHjXM1KdSw0jgvqVusiCLgPU38SPy/BWsTjIKYhIn
TTx4JyXoN8K8+gZeFeALWmdIgYLx1ya0SixQ/9l12maDRMroL9xvlsPeZHRiBC7m
8yoxvT3unCLVxFTeZlE4G7r9Fv5iKNnl91JLK/sKi4+AgVT1Lfg=
=QMeT
-----END PGP SIGNATURE-----

--8C2wFrBG20Y3IaC7WKw3AHrpzk77yMKcr--

