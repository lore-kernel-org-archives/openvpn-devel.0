From: Jon Kunkee <jkunkee@...2393...>
Date: Wed, 14 Nov 2018 00:32:48 +0000
Message-ID: <DM5PR2101MB104779DDD14DBE5E2FA0B11AB0C30@...2427...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-4-simon@...2293...>
 <DM5PR2101MB1112DB68D163884AD7ACDA80B0C50@...2412...>
 <99D61A626FDA8A4B90A270669121BE109936403D@...2294...>
 <DM5PR2101MB111297C51D45061C1CDC9563B0C60@...2412...>
 <99D61A626FDA8A4B90A270669121BE109936AE85@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109936AE85@...2294...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256     ; boundary="=-=+2yHeBQsz6+UgI=-="
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable
 Windows 10 detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=+2yHeBQsz6+UgI=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Note a side take-home message: msiexec.exe will never be Windows 10 aware.

Unfortunately, yes.

> > Let me know if that doesn't make sense or won't work for what you're
> > doing.

> I am familiar with EXE and manifests, thanks. Nevertheless, I really
> appreciate your time to extensively research and provide useful references
> in the debate.

It looks like I erred widely on the side of overinforming. I appreciate you=
r=20
patience with that.=20

> In my professional career I make EXE (or WSH) "parent installers" only
> because end-users usually have no clue what platform is their Windows. You
> can't do one-MSI-fits-all-platforms for native apps, so the parent instal=
ler
> EXE takes platform choice away from users. All other decision logic is
> inside MSI packages making them fully autonomous - once you pick the right
> one for your platform of course.

Makes sense. Fortunately x86 EXEs run on ARM64, so this even works=20
there. :)

> When the MSI package is installed by Group Policy Client, the MSI is
> launched directly by msiexec.exe.=20

Ah, I see. That puts a bit of a damper in bolting intelligence on during th=
e=20
msiexec invocation, doesn't it?

I'm no expert with GP, and what little I know suggests that any methods for
deploying custom EXEs through it are either much more complex than is=20
feasible for you to support or otherwise not worth using. You're the expert=
=20
between the two of us.

Without this ability and with the compat shimming of the MSI infrastructure,
there's not much else to be done.=20

> Hence such a complex workaround to detect the MSI has been launched on
> Windows 10. Microsoft made me do it. ;)

:)

> Please, note one last thing... I totally agree with everybody saying "you
> That's why this custom action *does not* return the Windows version - not=
 to=20
> tempt anybody else to use it for OS version detection.=20

> The name "FindSystemInfo" was picked generic on
> purpose, to allow us to add other detections missing in MSI should we need
> any down the road.

Smart! I hadn't followed the function to its callers, so I missed this.

Samuli, LGTM.

Thanks,
Jon

--=-=+2yHeBQsz6+UgI=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQ6s+QnGone4JL4whoCohEJkRnX4FAlvrbScACgkQoCohEJkR
nX5UCBAAm8JxordYREhvC29GWifCNLnCsJdSymECzLlzGnFXg64R9xg8LjhS2ckD
eepyf2Fe+z/NNMchKRFUOUTG4/vXussNzDkoZw1wV3RmJdKnNxigyAZ9cfb/lNbF
vsRW32VMksYseaahpFkMBvf/znhFwuLWOo4iC754YDF/HMW2Bl1JS2aywEBrIGrs
o18yHkaNkn2x7jBGWxPky8mK2pCrN/MdLNwvryrn6B52fhYxCwBKAUol6cayYq0S
NtHmrTne4SDRj3mL4az38/CCdmV9oUrJl7IUVOKP1kKt4+cCygcr67VnObaQqByh
/9vXFZH3A4yCslARyKgK50ZXqSkdDcmKA81IaxnfeqjUaVsqzmAd+WpZu76lJwts
cWYfNwa/cMI8+fmK0CLDGFLRawt3Zfl6X+La+ybJDqTjbICoy+rr0Q8WOg+Ao24j
ZRyg4osWus4joAi6G11KbNp0WyrBUK70hOMt2Yi1KNkko8x6C3SoI4FTJNMalsXQ
MuOQWVAL+RSuS9NuQ2qqxJG++gpFG66zM0GmrhCvndI/RdbBaFUTphUP8v4aJfVm
sqLeB54VifDS9Aha0qCQIxVWu7L48jfWbU4ZqfYOhks0pTWN0uuJvjRj6hcNJlwZ
hmvW1qC6zyKL5QmVtR5eCHfgfKGm6MVf2EluBjBcTZiLmZO2HDI=
=EixV
-----END PGP SIGNATURE-----


--=-=+2yHeBQsz6+UgI=-=--

