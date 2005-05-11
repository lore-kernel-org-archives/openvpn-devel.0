Message-ID: <4281E350.8020609@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Security bug with crl-verify
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...>
In-Reply-To: <Pine.LNX.4.58.0505110329020.15651@...41...>
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
Date: Wed May 11 03:52:01 2005
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

Le 11.05.2005 11:49, James Yonan a =E9crit :
>>I think there is a security issue with the crl-verify code. OpenVPN only =

>>check the issuer of the CRL, but not the CRL signature.
>>If you sign a CRL with another CA (even self signed) which have the same =

>>DN than the certificate issuer, OpenVPN accept it as a good CRL : the=20
>>server or the client do not log any error... So, an attacker can easely=20
>>produce such a false CRL, nobody can see the attack.
>=20
> I don't see how an attacker could produce a false CRL unless they had=20
> write access to the CRL file.

I agree... But in theory, write access must not be sufficiant. The CRL=20
is signed by the CA, this must be checked. Ok : it's theory ;-)

To clarify the situation, here is a possible example of attack:

Imagine I'm a user of an OpenVPN network. I have a user certificate,=20
issued by the CA "/CN=3Dzorglub/". I'm fired, and my certificate is=20
revocated by the CA. If (if, if, if...) I have write access to the CRL=20
file on the server, I can put a false CRL signed by a false autosigned=20
CA with the same DN "/CN=3Dzorglub/". Of course, I don't revoke any=20
certificate in the CRL.

Then I can access to the VPN again because the server does not check the=20
CRL signature.

Except the fact that I replaced only one file, this attack will be=20
completely "invisible" : no restart of the daemon, no log in OpenVPN...=20
  As long as the CRL will not have been updated by the real CA, my false=20
CRL works...

Well, I agree that it's not really a BIG security issue... ;)

>>Looking in the "racoon" code, I think that CRL handling=20
> is easier with > new versions of openssl (>=3D 0.9.7)
>=20
>>   (...)
>>   #if OPENSSL_VERSION_NUMBER >=3D 0x00907000L
>>         X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK);
>>         X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK_ALL);
>>   #endif
>>   (...)>>
>>With this kind of X509_STORE_CTX, openssl automagically manage all CA=20
>>and all CRL included in a "CAPath".
> Good idea -- it would be better for OpenSSL to handle all of the CRL stuf=
f=20
> for 0.9.7 and above.

I will try to produce a patch for a "--capath" option. See you in two or=20
three hours.

Thanks again,
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

