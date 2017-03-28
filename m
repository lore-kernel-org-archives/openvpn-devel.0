References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
	<20170328124704.GW93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c00a64c9-1bc8-966e-6cf1-e05537b69021@...2080...>
Date: Tue, 28 Mar 2017 19:46:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170328124704.GW93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uFN0C7nJQEuHpq6O6UbWDaLXiS6bLCxDK"
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uFN0C7nJQEuHpq6O6UbWDaLXiS6bLCxDK
Content-Type: multipart/mixed; boundary="SK6AtdgnpNLRq8wRNdKuh5hHJPL6iDrml";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c00a64c9-1bc8-966e-6cf1-e05537b69021@...2080...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
	"crypto.c:823:32: error: invalid application of ???sizeof??? to
	incomplete type ???cipher_ctx_t"
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
	<20170328124704.GW93896@...1296...>
In-Reply-To: <20170328124704.GW93896@...1296...>

--SK6AtdgnpNLRq8wRNdKuh5hHJPL6iDrml
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 14:47, Gert Doering wrote:
> Hi,
>=20
> On Tue, Mar 28, 2017 at 02:35:59PM +0200, David Sommerseth wrote:
>> On 28/03/17 14:21, Gert Doering wrote:
>>> On Tue, Mar 28, 2017 at 02:11:26PM +0200, David Sommerseth wrote:
>>>>> That's great!  This way, 2.4 does not have to change it's behaviour.
>>>>> Still, I think it makes sense to deprecate --ns-cert-type, and remove=
 it
>>>>> in favour or --remote-cert-tls in openvpn 2.5.
>>>>
>>>> Based on the feedback and discussions in Fedora regarding to us removi=
ng
>>>> --tls-remote .... I actually think 2.5 is too early.=20=20
>>>
>>> Nobody suggested removing --remote-cert-tls.
>>
>> I don't think I tried to say that :)  I mentioned --tls-remote in v2.4
>> as that caused quite some noise.  I actually had to add a patch in the
>> EPEL packages for EL6+EL7 bringing it back again, to ease these complain=
ts.
>=20
> Ah, *that* one.  I see.  So "the last time we deprecated and removed=20
> one of our zillion stale options, people complained, so we're not going
> to do it again"?

Nope.  We will deprecate features in the future too.  But we should be
far more careful and not even expect users to turn around as quick as we
really want.

> We need to communicate better what might affect users in new versions, so
> they can test and complain/adjust in time (like, the stricter CRL handling
> in 2.4, and - obviously - the --tls-remote bit)

Absolutely!  The --tls-remote feature was deprecated for 3(!) years, and
still people didn't catch it.  In fact NetworkManager guys implemented
the initial fix for it sometime in late last autumn, iirc.  But we only
listed it as deprecated in the man-page, no log warnings.  And we added
a note about it in Changes.rst, which also arrived fairly late in the
2.4 cycle.

I have a *hope* that annoying users with M_WARN in the log files will
help a bit.  As well as stating it clearly in the man pages, wiki pages,
Changes.rst.

<sarcasm>
If the log part is not enough as it is today, we might need to consider
a new M_DEPRECATED which makes it even more obvious ... like this:

   DEPRECATED: ******************************************
   DEPRECATED: *** Option --x-y is deprecated
   DEPRECATED: *** This option will be removed in v2.z
   DEPRECATED: ******************************************

Perhaps with a 1 minute start-up delay.

If someone is not able to catch that one ... then I have no don't know
what else can work.
</sarcasm>

>>>> and get in touch
>>>> with at least NetworkManager guys to ensure they have time to implement
>>>> a solution when this goes away.  So I think 2.6 is more realistic.
>>>
>>> Shouldn't be so hard to do a string-substitution in NM...   with
>>> 60b23236329e6921729f51e7689042a29c794a6b, this is really straightforward
>>
>> If the behaviour is really close by doing a substitution, this should be
>> good enough.  --tls-remote to --verify-x509-name is more complicated,
>> due to character remapping and such ugly details.
>=20
> Indeed.
>=20
> So - this is something people need to test on their client/server certs.=
=20=20
>=20
> Initially, it broke for ours (because the CA sets "more bits than needed",
> and that confused the ku test on equality), but with the new check=20
> "at least these bits, more are OK" all is fine.
>=20
>>> (unless your certs are really, *really* weird, providing a proper=20
>>> nsCert extention, but no proper keyUsage/extKeyUsage extentions).
>>
>> Well, despite weirdness occurring (Way too) often, I think we can live
>> with that noise if we have given enough time to adopt.  As long as we
>> have a real and solid argument they have been doing things wrong in the
>> beginning.
>=20
> Indeed, again ;-)

:)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--SK6AtdgnpNLRq8wRNdKuh5hHJPL6iDrml--

--uFN0C7nJQEuHpq6O6UbWDaLXiS6bLCxDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2qF/AAoJEIbPlEyWcf3yVpEP/26cqq8YYsHl19/c14EvnhD3
/1j8ULA0+mmtTy2oG4EpNzjxUKLxvMn1hYFMXRgWMXFG94X+JVAfxR2tM4QGPBjx
zFZUJNBW6D96A4K+1rmuRGpGhNFSujbyF+4H+x1bi7B98DSlwQZABJZQyh/N9LNE
HGSNTxZkSHAFlNL0YCk4AB/H/tmssXgCq6a80zQnO4DtO7qnn9GpfQJzwgY7E1BX
dWDp6Vep/NHJlGmkbyCw0mu2ynzwPo+F7lBtV5cDQLmczY4HnoHbM2GtCCftINP9
UvEPNDHcrykYIzmC3g+CYZ01UuJA+pRihwhwW4Ao3QM9yekQs6hdH0jcKV4jKHWV
zEkvwxa9rXd/XUObyuvdb1o4x9Y98JeEeSxn3SqtItTWcbKgq2UhMAKszCw0iHfY
9fJvKCtJ8XhVfFYvUM/AFgcTGuWovVE8uxkPZ42keeysl5KStcMZy+i/qKz8BMuB
1VmQoHfIB936CBK6hzDjl5HfBzuHAWfAITgKs/cNsmAy7VGHjgEQAYsLtQnc/oSi
8gsXC+HPnc/xg0J3ZyYYgKsQteDnp5rHEH02lSUqcM5z3JlU3snrmn98kH1p8adr
FQfwUg/liloS5WBnh1Nr2YKSxPZwT6pt0RsEgNbxBfG4hT5pwAmxBRFB35C7KbKk
iNSoDqG5O5734lDcxNGm
=kPls
-----END PGP SIGNATURE-----

--uFN0C7nJQEuHpq6O6UbWDaLXiS6bLCxDK--

