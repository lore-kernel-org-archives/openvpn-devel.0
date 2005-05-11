Message-ID: <4281BADE.2020402@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Security bug with crl-verify
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
Date: Wed May 11 00:59:22 2005
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

I think there is a security issue with the crl-verify code. OpenVPN only=20
check the issuer of the CRL, but not the CRL signature.

If you sign a CRL with another CA (even self signed) which have the same=20
DN than the certificate issuer, OpenVPN accept it as a good CRL : the=20
server or the client do not log any error... So, an attacker can easely=20
produce such a false CRL, nobody can see the attack.

The CRL must be validated : OpenVPN must verify it has been signed by=20
one of the CAs indicated in --ca.

Looking in the "racoon" code, I think that CRL handling is easier with
new versions of openssl (>=3D 0.9.7)

   (...)
   #if OPENSSL_VERSION_NUMBER >=3D 0x00907000L
         X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK);
         X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK_ALL);
   #endif
   (...)

With this kind of X509_STORE_CTX, openssl automagically manage all CA=20
and all CRL included in a "CAPath".

Thx,
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

