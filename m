From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 21 Jun 2018 02:40:44 +0000
Message-ID: <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
In-Reply-To: <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256     ; boundary="=-=R/APc2R3UCbVFI=-="
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=R/APc2R3UCbVFI=-=
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Testing the signatures and the driver on ARM64 would be good. We don't 
> have any ARM64 Windows hardware at our disposal. 

Drop me a package and I'll take it for a spin. I have at least one device
with Secure Boot set up on a released build (1803).

> We don't have any tap-windows6 -specific tests at the moment, so I 
> generally just run the OpenVPN test suite against a bunch of OpenVPN 2.x 
> / Access Server / Private Tunnel servers: 
> <https://github.com/OpenVPN/openvpn-windows-test.git> 

I can give that a shot. If I can't figure something out from the README,
I'll ask questions here.

> Given that tap-windows6 driver has seen lots of modifications having 
> more focused tests would be good. Any ideas what we should test and how? 

As for tap-windows6, I have to profess a merely general understanding of
what it does: It allows the usermode daemon to read, intercept, and emit
raw network traffic, while the firewalling, routing, and encryption are
done by the OpenVPN daemon after the traffic leaves the driver.

Given that, I can think of a few test cases (not ordered in any way):

(All tests should run under Driver Verifier with basic sanity and NDIS
checks enabled.)

 * Heavy load on multiple TAPs
 * Upgrade
 * Empty, small, ~MTU, >MTU, and Jumbo packets
 * API fuzzing
 * Power transition testing

...but all of these take varying levels of dev investment to automate.

The easiest next step would be to expand the ping test to try varying
packet sizes (-l). (Windows' ping doesn't have a 'flood' option...)

My 2c,
Jon

--=-=R/APc2R3UCbVFI=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQ6s+QnGone4JL4whoCohEJkRnX4FAlsrECEACgkQoCohEJkR
nX41ww//cOS0PWMQJ0ruZH6eCYT38QrfeSUzlWnSbTFpr1QC4vsdC9HU8FgE8tKb
WcrEtVRteGSN41del1yzY3iBBehNZX3XHuqUbga7DlEtPMlm38CrImnauql/b6n2
OjVKREPp3rqVsGjR9p8YzzdrDeV/HbYUehyXuUr3IMRTcZciax0GdAEb/tLNR9SG
144v2FhDwHQR7KUG/7qeE98KB8eH66te5w9+XjsTJACqeJR5gkpPLGbBgwialMi1
Zi0YSeQnaG/PND4+aSrmKhX0gIUrMl2T3C7PtojalAMsa3mGi5k+tm8+t/420oie
SY0cvmphTrmTHpTWwwshzm/3J1F9nqnYZmZeEbwdvBZr1hBbhNseAFmV1xJVmkNL
HLLgHt01bcMBU/gSHDzfSOwXWoEpdxH2dupNcnIdUhLh3c5g3/0PhD3t6aTB5zXw
rcMOhlR2YylIqqOdwVXL7+7jHp/AJ5l0WLo6gol4oacPHyaOfTRJeYpYSdQbIoIm
wUTTTeNkST3ytL2zby+vIozMJ++ySkal/+ynF09c1es7Aqy6w0KWsUP2RLqtUaGz
nHOrnP/Gnkf4odxvFWXiPXZbbtZTjCVKYAZQN3EULH+7+jYKuZ2bwn2/rZmI9vRh
jwITVQRdiLNBsIlMyR4LR6YKU72eH6mKQS+eAmNBexHfda1xCl4=
=bumd
-----END PGP SIGNATURE-----


--=-=R/APc2R3UCbVFI=-=--

