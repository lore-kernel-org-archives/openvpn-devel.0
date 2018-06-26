From: Jon Kunkee <jkunkee@...2393...>
Date: Tue, 26 Jun 2018 21:11:37 +0000
Message-ID: <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
 <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
 <20180626191511.GI57262@...1296...>
In-Reply-To: <20180626191511.GI57262@...1296...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256     ; boundary="=-=uaQw4XFOnrlVVX=-="
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
To: Gert Doering <gert@...1296...>
Cc: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=uaQw4XFOnrlVVX=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=20
Hi,

> as a quick note - sorry, we won't make "June 27" as release date for=20
> the new tap driver.

> We tentatively plan for "one more week" now, which would be July 4th.=20

No worries. Thanks for the update!

>                  The Windows HLK tests for Server 2016 are somewhat=20
> "demanding" from what I hear from Samuli (you need to have a larger=20
> setup than "just the machine with the driver", it actually wants to=20
> talk through the driver to "things" - which need to be provisioned,=20
> etc.).=20

> Jon, do you have experience with the HLK test suite and could help=20
> explain some of the test failures ("what does the system expect to=20
> find here?") - what's remaining does not seem to be "driver" related=20
> but "things the tests expect to see in the network behind that driver"...=
=20
> gert=20

I have experience running the PCI portion of the HLK from Windows 8, so
that gives me the basic idea. Those tests required two machines: the
one with the device and the driver and the one with the HLK server.

Network device testing is more complex because the test needs to control
both the OS' end of the traffic and the external traffic. I found this:

https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/lan-test=
ing-prerequisites
(apologies if Exchange or Outlook mangles that link... ):

It appears that you need three devices: the HLK server, the device with
the 'hardware' and the driver for testing ('Test Machine' with a 'message
device'), and the external traffic source/sink ('Support Machine'). All
three probably need a backchannel link to the HLK server, while the Test
Machine and Support Machine do best with a dedicated link through the
device whose driver is being tested.

There should be a predefined set of individual tests that are required
by the signature service, probably NDISTest 6.5.

I'd be happy to review failure logs to help figure out what's going wrong.

Cheers,
Jon

--=-=uaQw4XFOnrlVVX=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQ6s+QnGone4JL4whoCohEJkRnX4FAlsyq/8ACgkQoCohEJkR
nX43BRAAne/aJ0zpm8qZeT10S6N1NjbYfkXXjTXuza/eUnhL2G+f1bAzGZkoUfwm
rvHdjdZRTNZUuYK1vf2Wz5FccCKqnNks14o3whEE5zOqfXejlS6Z/hJEvj8BtgfB
PunbbVRvW7BcWx44SU07GWmaofUAb80SD3ItDWohf0AvNnIRCSOYnvSfh92G84Xp
REWK4rKZZ7KoIQz2SwYkI0jG3QDqJ/AtS5L8Ti2WaVYEMMPqzp+/d2C90Az5R57e
FVSR9+xHBOb5/b8lQOj+QErvo1fLKI7qja/KzvGySyFFvD6BVA/TfwDBA8gqH5Ha
h2bWVKExKa9C7JMg+WjVocnTwtfiKZmarEzjcuOhdtTRvBh2qWWnTdvB708lRbM7
huwRCLL/38HqhjNjM5ykK3nUjxo+fD28Iar3V8H4URT2JZ6zw903ffTzrfJZmg97
o4IAc3cugahhEw7c6F6/fyMA812OJuhhgzLg+CishKNCLepD/MRO2LVe5Xie8n9k
9Qf5cANnLfhSrX2KEIFkDoOhvZRnh8He3Ed1kFVupm1JzCwX6zJSuTQT0hRlr4Vd
N13fa96RE8RCon4Hpwi4LXoUJNtStCcRVLEVrIZFvx3vokMIAe0cHyAa/9I81Qcr
yfWeM0iCXNBt8WdR3gv6UDGg1/SniRzqvjkD76zpjelmsBBuxSQ=
=HE1C
-----END PGP SIGNATURE-----


--=-=uaQw4XFOnrlVVX=-=--

