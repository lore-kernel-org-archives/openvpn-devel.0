Message-ID: <428308EB.8080500@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Security bug with crl-verify
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...> <4281E350.8020609@...349...> <Pine.LNX.4.58.0505111505010.15651@...41...>
In-Reply-To: <Pine.LNX.4.58.0505111505010.15651@...41...>
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
Date: Thu May 12 00:44:12 2005
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Le 11.05.2005 23:25, James Yonan a =E9crit :
> True, but I think you're somewhat stretching the connotation of "security=
=20
> bug" here.

Yes. Sorry if the "security bug" subject hurt you.

> No matter how much OpenVPN tries to
> authenticate the CRL, an attacker with root privileges could easily
> install a stealth backdoor on the server which would completely bypass the
> VPN.

Ok, another example :
	- a root CA
	- two intermediate CAs
On the server we have 3 CA certificates and 3 CRL. The CRLs are updated=20
by a cron job. If an attacker managed to modify the CRL of one=20
intermediate CA, he can simulate a false CRL with the same DN as the=20
root CA or the other intermediate CA... The cron job on the server will=20
normally and automatically fetch the false CRL... It's not a very extrem=20
situation : only one intermediate CA has been attacked.

Of course, as OpenVPN only handle one CRL with --crl-verify (and=20
consequently only one CA), it's not a problem for now, I'm agree with=20
you. But if openvpn has to manage several CA (like in a real PKI), the=20
CRL management will have to be finer. Fortunately, OpenSSL 0.9.7=20
integrate all the tools for that.

Again, thanks for OpenVPN, and do not misundestood me : OpenVPN is a=20
very very nice piece of code anyway :-)

--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

