References: <20161216155755.29931-1-list@...1798...>
	<0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
	<20161216200919.68d61c42@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fe5adcf8-b61e-3bb8-8810-4d8826ec3696@...2080...>
Date: Fri, 16 Dec 2016 22:15:46 +0100
MIME-Version: 1.0
In-Reply-To: <20161216200919.68d61c42@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Ia3Q724twK06MbIAlQqH87kckkjicGJk8"
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
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
--Ia3Q724twK06MbIAlQqH87kckkjicGJk8
Content-Type: multipart/mixed; boundary="wWU6KxXtXwvuCLJ8MI8gB29sLqSMLqKSP";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <fe5adcf8-b61e-3bb8-8810-4d8826ec3696@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
References: <20161216155755.29931-1-list@...1798...>
	<0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
	<20161216200919.68d61c42@...1799...>
In-Reply-To: <20161216200919.68d61c42@...1799...>

--wWU6KxXtXwvuCLJ8MI8gB29sLqSMLqKSP
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/12/16 20:09, Christian Hesse wrote:
> David Sommerseth <openvpn@...2080...> on Fri, 2016/12/16 19:14:
>> On 16/12/16 16:57, Christian Hesse wrote:
>>> From: Christian Hesse <mail@...1798...>
>>>
>>> Different unit instances create and destroy the same RuntimeDirectory.
>>> This leads to running instances where the status file (and possibly
>>> more runtime data) is no longer accessible.
>>>
>>> So create a RuntimeDirectory per instance.
>>>
>>> Signed-off-by: Christian Hesse <mail@...1798...>
>>> ---
>>>  distro/systemd/openvpn-client@...1685... | 2 +-
>>>  distro/systemd/openvpn-server@...1685... | 4 ++--
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/distro/systemd/openvpn-client@...1685...
>>> b/distro/systemd/openvpn-client@...1685... index 5618af3..fcb5302 100644
>>> --- a/distro/systemd/openvpn-client@...1685...
>>> +++ b/distro/systemd/openvpn-client@...1685...
>>> @@ -9,7 +9,7 @@
>>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
>>>  Type=3Dnotify
>>>  PrivateTmp=3Dtrue
>>> -RuntimeDirectory=3Dopenvpn-client
>>> +RuntimeDirectory=3Dopenvpn-client@%i=20=20
>>
>> I am quite sure we tested this, without any luck.  We ended up with a
>> directory named openvpn-client@%i ... well, we used openvpn-client-%i,
>> but the principle should be the same.
>>
>> This *might* have been fixed in a newer systemd releases, but as we have
>> RHEL7 as the oldest release we need to ensure this works properly there =
too.
>>
>> For the server side, we used status-%i.log to avoid clashing on the
>> status log.
>>
>> debbie10t did plenty of testing with various configurations, so he can
>> probably fill out more details in the various test cases he used.  We
>> should probably document those tests in our wiki though.
>=20
> Running systemd 232 here and everything works as expected. This is with u=
nit
> files from current master:
>=20
> # systemctl start openvpn-server@...2216...
> # systemctl start openvpn-server@...2217...
> # systemctl stop openvpn-server@...2217...
> # ls -l /run/openvpn-server/
> ls: cannot access '/run/openvpn-server/': No such file or directory
>=20
> And the same with my patch applied:
>=20
> # ls -l /run/openvpn-server@...2218.../status.log=20
> -rw------- 1 root root 8419 Dec 16 20:03 /run/openvpn-server@...2218.../s=
tatus.log
>=20
> From systemd.exec(5) about RuntimeDirectory=3D:
>> Takes a list of directory names. If set, one or more directories by the
>> specified names will be created below /run (for system services) [...] w=
hen
>> the unit is started, and removed when the unit is stopped.
>=20
> So this works as long the no service is stopped or fails.
>=20
> I do not have RHEL7 around... What exactly fails there?

The directory is literally named 'openvpn-server@%i'

RHEL7.3 (latest common release) ships with:

$ rpm -q systemd
systemd-219-30.el7_3.6.x86_64
$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.3 (Maipo)

We don't have any particular policy that we should support anything else
than the latest major version (so 7.0 to 7.2 would not normally be
supported).


Regarding access to RHEL: There is a developer subscription available
for free if you sign-up with the Red Hat developer program (also no cost
sign-up) ... which is valid for one physical box and unlimited virtual
guests for non-production environments.  It also includes access to the
vast majority of RHEL add-on modules as well.

<https://developers.redhat.com/products/rhel/get-started/>

Otherwise, CentOS or Scientific Linux is very close to RHEL, just
lagging some weeks/months after each minor point release (7.2 -> 7.3).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--wWU6KxXtXwvuCLJ8MI8gB29sLqSMLqKSP--

--Ia3Q724twK06MbIAlQqH87kckkjicGJk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYVFmCAAoJEIbPlEyWcf3yKOAP/RmAEoLwUkwmSTs4FeUerq47
EXHgUL+XekmRbmIalqszLgZkmfHo3VHKLZoPK2AbayCvYQuniV4FdqH9T8CyTOUF
5qUxv/soNI1GRHrxMf/ekNdT6pTWMSMXtay4xApfqXDrR2cuLtcQyHxWIIESIJQ7
2pRu6Q9lNK1YU9V4mczYWoTYM3utc+oT88E4CtBNAXR/UfYoGzs7x/saZ5RNlqRJ
8EdFtgs9/vnem+klIPFYAvIHc1AB+/ehelrzyjz+06quafxiRRlCjgDD6dauAgU8
9Aaw6xkp3Z9d2kJov6ys/TV5alc5wV+Sb7rPCd0YS5i2gtVLVuE5T7GBO942FMfe
S1ZQC57Ym0v+Q60kvMrLXpKQE9ba/nSBBnJJzxubFiEZYUVaj2Em71RNZ9mzrG2l
jZ9l86KpK2K4F2feser/DDe/iAiMHjAcY+zyhrvp2wcH59vm8Dlm+clw3WTiZaaH
TKl0BT6X1QKFzNejisW8kIexU36/B67719YBARYKsSXcwKr9CAtc5viWHcl/gSKX
SNLpOvmuv1K3PsZix0q9m2qnruHUjaYdVylUFl70X+MHR9Ja8MU8x2hVoLlgZyTH
NTmnhuvjr3gRdGT5E7yH1x/p8XXHWnlAnb6KA8lbzdfgsDBWIUrvTFlW85L4H7Ab
Dzy/mfhr3qNo2FFeBESr
=hBUz
-----END PGP SIGNATURE-----

--Ia3Q724twK06MbIAlQqH87kckkjicGJk8--

