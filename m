References: <20200722095446.25141-1-davids@...515...>
 <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2b58ab7d-78c5-5d31-ae3e-5c0c2166e08a@...2080...>
Date: Wed, 22 Jul 2020 16:16:40 +0200
MIME-Version: 1.0
In-Reply-To: <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uL4jOh73Rd682FEDB30yh9qCXrTw4ESAz"
Subject: Re: [Openvpn-devel] [PATCH] options: Remove --udp-mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uL4jOh73Rd682FEDB30yh9qCXrTw4ESAz
Content-Type: multipart/mixed; boundary="IxjTPXviL548NvF4fobN3ngmuOC6Iftht";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2b58ab7d-78c5-5d31-ae3e-5c0c2166e08a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] options: Remove --udp-mtu
References: <20200722095446.25141-1-davids@...515...>
 <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>
In-Reply-To: <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>

--IxjTPXviL548NvF4fobN3ngmuOC6Iftht
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/07/2020 14:01, Arne Schwabe wrote:
> Am 22.07.20 um 11:54 schrieb David Sommerseth:
>> Before --link-mtu, it was --udp-mtu.  This was changed in
>> OpenVPN 1.5_beta1 (release July 2003).  It should be safe now
>> to remove --udp-mtu, the transition period should have been long
>> enough.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/options.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)

[...snip...]

>
> I close to sending a NAK to this. Normally we just don't outright remove
> options but rather warn for a version or two. But adding the warning
> code here and later removing the option just to remove the complexity of
> '|| streq(p[0], "udp-mtu"'?

I don't follow your logic, really.  But I won't fight this much.  My reasons
for removing this so easily are:

 -  This option has not been in any documentation since OpenVPN 2.0_beta,
    released  in November 2004.

 -  It got superseded by --link-mtu in OpenVPN 1.5_beta1 (July 2003)

I would really like to see that configuration file being in active use on a
system today.  OpenVPN 1.x generation was plain P2P mode capable, OpenVPN 2=
.0
was the first release enabling multiple clients to the same server process.

> I don't see a compelling reason to remove alias option. Normally we
> deprecate options because they
>=20
> - are considered harmful in some way (no-iv)
> - complicate the code without a clear gain
> - are replaced by a better mechanism and the old option does not
> trivally translate to the new option.
> - are features that we do no longer want to maintain and to remove them
> to decrease complexity (--enable-client-only)

That is right.  And all of that falls into the category of "code creep", wh=
ere
the code grows and requires maintenance.

But I see this from the angle of "option creep", where we add options and
never really clean up.  Which is why we have started to deprecate options.
Deprecating options due to code creep is one aspect.  But never clean up
options which has been deprecated or superseded in one way or another is, in
my view, equally bad to not removing "code creep".

I do agree we normally would have a deprecation process going for all optio=
ns.
 But the --udp-mtu option falls into a very special category; being depreca=
ted
almost 17 years ago and being removed from the documentation almost 16 years
ago + being superceded in an OpenVPN release generation which introduced TCP
support - all of this more than 16 years ago.

Over the years I have also criticized introduction of new options, trying to
reuse existing options as much as possible and not introduce new ones witho=
ut
a good reason [0].  Our options.c file tackles close to 300 options [1]; wh=
ere
we have documented 275 of them in our man page.  This is also not good, fro=
m a
user's perspective.

We might need a lot of options to handle the flexibility of OpenVPN.  But we
should really strive to not have overlapping options active for too long, as
that is just driving things more complex for the users - without good reaso=
n.
 And we certainly should avoid having multiple options doing exactly the sa=
me
thing; this is acceptable to me only in a transition phase where we move to=
 a
better construct.

[0] For example, I questioned why we needed --tls-crypt-v2 instead of
    reusing --tls-crypt
[1] $ git grep 'streq(p\[0\],' -- src/openvpn/options.c | wc -l
[2] $ git grep -E "^--\w+" -- doc/man-sections/*.rst | wc -l


> But with alias I feel we just removing them because we found a newer
> nicer name and as a user (especially another dev) removing an alias
> feels like they are removed because of pride/principle that since they
> are old they must be go away.=20

This is really not my motivation, I do reject this sentiment and implicitly
pointing it like that towards me.  Lets keep the discussion on the technical
side, not imply anything on the personal side.

What I do believe in is our role of maintaining this project.  Which means =
we
need to clean up.  Some clean-ups are big.  Some are small.  This patch is a
small one.  Some times we keep options, some times we kick some out, some
times we migrate them to better alternatives.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--IxjTPXviL548NvF4fobN3ngmuOC6Iftht--

--uL4jOh73Rd682FEDB30yh9qCXrTw4ESAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfGEpRAAoJEIbPlEyWcf3yuIcP/386xL+1UHnf0nCeBdDAssLV
USZtA1IRtIEfiRwPb9hwF1LDNxJ1bPqAQtP1Q58nPac+gYc1nTTT5HGkt+5SuqLN
Be+dpfOaylnPsI6/gQV/RNccl/d6gqIaMrYuwqsEPfH+JD+HWKIUa9Q1Y3lLoM7R
qcab0i+suDxV/qhaeHWCdQQbV/DczuitwVmtsMeFkhakP0tRJk5pyZUZQrmkVO2L
vKV5HqIW6LIvBcgi0KsLOzQUVkxmnYLV5ZqDnLKsk2NDpy8TBbtIs2NLYLPYs8YC
Csmqzz1iD3yGcaPd2muViN/NlT6uXFAxFxq4ys8EC0DON3LznZJa+uwh5xRSjQyF
oeQQWzm6hj4yN69Iuy1VcTRKgfVQeHTptOmw3MNuGjztf30cbWa1EnpTtn80hc1B
8oQ7LtPOS/DcFynKps4cOI0Og/YgYh+/beMQFB5iT0nPzE8c9YsU2P0A37377PHD
Ndl0CHlkycGLbB7QEDJKMKZTn9eLF4XlOOMvyQuRc5y5zo7PAzgQuPub7efDCel6
HNSplCjpdSRrGxn+i6M2fZ2o24Bk3D7g7dFweMonadd65gDOQDsFsrd97Yf5PFTZ
zIuuwj8qMw2J0dBnqte+UqAXnxlkxoyGGQEl0bEmPuFakVgahpoE/OkfcGzIVgTs
mnAqeCyt28Zmi9G691x7
=laHh
-----END PGP SIGNATURE-----

--uL4jOh73Rd682FEDB30yh9qCXrTw4ESAz--

