Message-ID: <43BAAE3E.2080907@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] AW: Re: [Openvpn-devel] PKCS#11 and easy-rsa
References: <6be76a4c79dcd0c0359583a8b0d1f44c@...527...>
In-Reply-To: <6be76a4c79dcd0c0359583a8b0d1f44c@...527...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jan  3 09:05:17 2006
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?G=F6tz_Babin-Ebell?= <goetz.babin-ebell@...526...>
Cc: openvpn-devel@lists.sourceforge.net

G=F6tz Babin-Ebell wrote:
>> In my view it lacks the following features:
>> 1. Allow the user to specify his own PKCS#11 library.
>> 2. Generate a new key.
>=20
> This is wide outside of the OpenVPN usage.
> Is is to be implemented in an PKCS#11 (key) managemement tool
> but NOT in an VPN daemon.

The update is for easy-rsa, which is a simple to use
interface in order to issue certificates.

The easy-rsa is already provided by OpenVPN in order to ease
user in the mission of certificate enrollment.

>=20
>> 3. Load the X.509 certificate into the token.
>=20
> And this too has nonthing to do with the functionality of an
> VPN daemon.
>=20
> Please:
> KISS.=20
> Keep It Simple and Save.

This what all try to do.

>=20
> OpenVPN is a small tool to do VPN tunneling.
> Stuffing not related functionality that seems fancy into it
> leads to bloatware.

True... But in order to allow people to use the solution,
they should be able to enroll certificates, easy-rsa is a=20
good starting point.

Since OpenVPN 2.1 will support PKCS#11 tokens, it would be
nice if the easy-rsa interface will also support PKCS#11 as=20
it support software keys.

Until now I've assumed that people who use PKCS#11 tokens
will enroll them using a different tool, Ondra suggested to=20
add PKCS#11 support to easy-rsa, this is fine! for my=20
opinion it should support a complete enrollment process.

Best Regards,
Alon Bar-Lev


