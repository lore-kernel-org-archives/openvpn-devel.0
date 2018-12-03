References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
Message-ID: <d00fef38-e26b-6b78-1181-95f24eb37748@...2080...>
Date: Mon, 3 Dec 2018 12:14:07 +0100
MIME-Version: 1.0
In-Reply-To: <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="x16w3X6krDeLqBBHKsQO9ID7MIhKjFTlH"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x16w3X6krDeLqBBHKsQO9ID7MIhKjFTlH
Content-Type: multipart/mixed; boundary="AwymSxCAdRSvyjvc3DC7TQ1PlNjaBiUfL";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d00fef38-e26b-6b78-1181-95f24eb37748@...2080...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed, 28th Nov
 2018)
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
In-Reply-To: <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>

--AwymSxCAdRSvyjvc3DC7TQ1PlNjaBiUfL
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/11/2018 10:49, Jan Just Keijser wrote:
> Hi,
>=20
> On 29/11/18 09:03, Samuli Sepp=E4nen wrote:
>> [...]
>=20
>> Had a discussion about --fragment. Agreed that if we can fix internal
>> fragmentation without needing a change in frame format then we can
>> definitely deprecate --fragment in the long-term. Also noted that lack
>> of tun-mtu support on Windows might be for historic reasons and might
>> not apply to tap-windows6. Also questioned whether the default MTU of
>> 1500 is the best possible choice.
>>
> I wish I'd known about this discussion - I saw the topic list and figured=
 I
> wouldn't be able to contribute much to the discussion.
> Regarding MTU/fragment however.....

Hi Jan,

First of all, I'm terribly sorry I didn't get a chance to update the topics
page in a timely manner.  That should have been done, but we have been
discussing this internally for a little while and I thought it was about ti=
me
to get a bigger audience included in this discussion too.

I brought up this discussion now because we do need to find a better way to
handle --fragment.  I had no goal of ending up with a complete solution in
this meeting, and we didn't really conclude either how to resolve this issu=
e.
 But I felt it was important to at least start this discussion so we can fi=
nd
a better solution for the future, with the community more involved in this
discussion too.

We (OpenVPN Inc) fully understand the usefulness of --fragment, but this is=
 a
very intrusive feature - from a code perspective.  We also want to reduce t=
he
number of options which is needed to manually tweak a setup into a function=
al
or better performing state.

We believe a modern VPN solution should figure this out automatically and it
should just work.  But at the same time, automation in this area is tricky =
and
hard - after all, how do you know if a packet was lost and why?  Sometimes =
the
packet drop is expected while other times it should not have happened.  The=
re
is no quick-fix for this.

So part of what we want (from a high level perspective) is to push lots of
this "tackle fragmentation logic" to be handled by the kernel primarily.  T=
he
kernel network stack (on all platforms) have logic to reassemble fragmented
packets.  But we need to find ways to better facilitate this behaviour in t=
he
kernel scope from OpenVPN.  Which is why we started looking into --mssfix a=
nd
--tun-mtu.

Combine these areas with the ultimate goal of automation ... If the OpenVPN
stack can somehow figure out that "something broke the connection to the
remote side now" and then start trying resolving this automatically can
provide a much better end-user experience.  If that is by dynamically tweak=
ing
the --tun-mtu, --mssfix or whatever else ... that would be good.  But we
generally want to avoid implementing code which needs to keep track of pack=
et
reassembly due to needed fragmentation.  If we really end up needing it, we=
ll,
then we have at least tried resolving it in a simpler way.  Kind of like
trying to make it as simple as possible but no simpler.

At the same time we also don't want to provide a worse end-user experience =
by
today's standards for the vast majority of users by having the wrong default
values.  To exemplify this quite a bit (disregarding other comments related=
 to
--tun-mtu, this is just a stupid and simple example): It is better to start
with --tun-mtu 1500 which works for 90% of our users and breaks 10% of conf=
igs
which will then be automatically resolved after a shorter time (20-60
seconds?), rather than starting with --tun-mtu 1280 which works for 99.9% of
users out-of-the box.  We don't want to punish 90% of the users because 9.9%
of the users would need a lower --tun-mtu to get things working instantly. =
 It
is better then to have code which then saves the solution or provides optio=
ns
for the 9.9% of users to more quickly recover - if the default resolving
method can't be done faster without a pre-save state.

But in the end, it might not be the --tun-mtu option we end up with modifyi=
ng,
it could be something different - or it could be combination of things.  Ri=
ght
now, we just need start on a path figuring out the alternatives to reduce t=
he
need of fragmentation processing inside OpenVPN.

This is basically the more detailed background of why this discussion was
opened.  If we can make OpenVPN even better with lesser configuration
complexity we believe we're providing a better end-user experience.  But
neither I nor OpenVPN Inc says this will be an easy or quick path.

In addition, we need to keep whatever changes compatible between OpenVPN 2 =
and
OpenVPN 3, so we're sure there is a reasonable migration path in the future=
 -
so clients and servers can be upgraded independently without really breaking
anything.


With all that said:  Thank you for valuable feedback regardless.  And your
feedback on changing the "change of MTU" on Windows prior to Vista was gold!
  For the rest of your points, I believe Lev has followed well up on those.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--AwymSxCAdRSvyjvc3DC7TQ1PlNjaBiUfL--

--x16w3X6krDeLqBBHKsQO9ID7MIhKjFTlH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcBRAGAAoJEIbPlEyWcf3yu6UQAMneforsvPDf0VsAzLrHAab/
8up9k66icatUrHnVFaT6U+IY7Vb+sDhi50cTLFoQn1Afn487NL0RfAw+MXwDEPlD
OU5mpYvKAfL5KDZpOddU/QWb6PGUwkxdnYIkKMOq2iMm8aQ7G5onkHU/Nlw63680
tC8I/V5OZjE4d00bFGl01nnn8KCcMSFDQbf6n9raf/Rj0E8il8Hd7Um8wk8iDOgX
BK1PoC1bCQLP5tg1jJgA05CB13MJYEJx2JKuqHYnM/2yYhzjf6bKX4YGATEpeJBa
0uTrbp1PXfF/fJAeNYJgc1D8Qtj2G9M3xvwyvtIYi5X1oYnuvayyAJaxuaeGNYpI
mDo6v57NFvCqubN3dee+nfYuvEdilISdJpBRNzmSJ4nKknx8zea9VEcvqv3zKTpj
Aq3DZ3kWhsMx/GAv6/JVTZPa8zaXczAAekJ4Vrjr7dnpJecLwLnryQfbfyz/9eRU
S2LYWNW+kn+u2A4gGCiQrNiEsGEDAqgKf082fDycZtVo/sH07RO4uzP6TKl1Nv0F
PUlpPzhDRoo8Dvm1kiJyhAON9gSlOcdBQBLxKqqLthv36Nqclk4ktGqY+oj/91JS
vvyW6xMJ6nZea0458eEfDO1lAArCczlB3rYJfrRBnTMhWCsPduTb23PiaFzjTyPm
geuvNm1FexWaq5SINVOn
=IGU1
-----END PGP SIGNATURE-----

--x16w3X6krDeLqBBHKsQO9ID7MIhKjFTlH--

