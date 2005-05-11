From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Security bug with crl-verify
In-Reply-To: <4281E350.8020609@...349...>
Message-ID: <Pine.LNX.4.58.0505111505010.15651@...41...>
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...>
 <4281E350.8020609@...349...>
MIME-Version: 1.0
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
Date: Wed May 11 14:27:07 2005
Content-Type: TEXT/PLAIN; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas NOEL <thomas.noel@...349...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 11 May 2005, Thomas NOEL wrote:

> Hello,
>=20
> Le 11.05.2005 11:49, James Yonan a =E9crit :
> >>I think there is a security issue with the crl-verify code. OpenVPN onl=
y=20
> >>check the issuer of the CRL, but not the CRL signature.
> >>If you sign a CRL with another CA (even self signed) which have the sam=
e=20
> >>DN than the certificate issuer, OpenVPN accept it as a good CRL : the=20
> >>server or the client do not log any error... So, an attacker can easely=
=20
> >>produce such a false CRL, nobody can see the attack.
> >=20
> > I don't see how an attacker could produce a false CRL unless they had=20
> > write access to the CRL file.
>=20
> I agree... But in theory, write access must not be sufficiant. The CRL=20
> is signed by the CA, this must be checked. Ok : it's theory ;-)
>=20
> To clarify the situation, here is a possible example of attack:
>=20
> Imagine I'm a user of an OpenVPN network. I have a user certificate,=20
> issued by the CA "/CN=3Dzorglub/". I'm fired, and my certificate is=20
> revocated by the CA. If (if, if, if...) I have write access to the CRL=20
> file on the server, I can put a false CRL signed by a false autosigned=20
> CA with the same DN "/CN=3Dzorglub/". Of course, I don't revoke any=20
> certificate in the CRL.
>=20
> Then I can access to the VPN again because the server does not check the=
=20
> CRL signature.

True, but I think you're somewhat stretching the connotation of "security=20
bug" here.

If a disgruntled employee with root access tries to leave a back door on
the server before security escorts him out of the building, one cannot
ascribe his ability to do so as a security bug.  root access, by
definition, is unrestricted.  No matter how much OpenVPN tries to
authenticate the CRL, an attacker with root privileges could easily
install a stealth backdoor on the server which would completely bypass the
VPN.

James

