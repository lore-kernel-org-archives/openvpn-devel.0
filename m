Message-ID: <428CD696.90701@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for a --capath option
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...> <4281E350.8020609@...349...> <42821866.9080008@...349...> <Pine.LNX.4.58.0505180533040.14237@...41...> <428B59C7.3010008@...349...> <Pine.LNX.4.58.0505190455500.14237@...41...>
In-Reply-To: <Pine.LNX.4.58.0505190455500.14237@...41...>
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
Date: Thu May 19 11:12:21 2005
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

>>I think a nice solution would be to rebuild the X509_STORE of the=20
>>SSL_CTX when a SIGHUP ou SIGUSR1 arrived. But I do not understand yet=20
>>enough the code of OpenVPN :
>>- where can I add an action when a SIGUSR1 or SIGHUP is handled ?
>>- how can I get the (list of ?) SSL_CTX object ?
>>Do you think that it is a good idea, and do you think that it is feasible=
 ?
> Because of OpenVPN's security architecture, it is very common for a
> privilege downgrade or chroot to occur after initialization.  This means
> that it may not be possible to re-read a file after initialization.
> This is a major reason why OpenVPN handles CRLs the way it does now: so=20
> that (a) the OpenVPN daemon need not be restarted after a CRL update, and=
=20
> (b) the CRL file itself can be located in the chroot jail without=20
> requiring that the private key or any other files reside there as well.

Ok, I see the issue :
CRL are in the "--capath" directory, so in the chroot jail. But CA=20
certificates can be presents in this directory too. It can be a problem=20
if an attacker managed to add a false CA & CRL in this directory : the=20
CA will be directly accepted by openvpn, so the signed certificates will=20
be accepted too, without any restart.

In fact, I think that all openssl systems with a "--CAPath" option must=20
have read access to the directory. So it's not a pure openvpn "bug"...

(note: a very nice feature could be to be able to add CRLs via the new=20
managment port...)


Can you explain me very quickly where and how I can add a=20
"x509_stores_reset()" function in openvpn, that it will be executed when=20
a sigusr1 is received?  I'm sorry but I do not clearly understand the=20
signal managment in "sig.c".


> Having said all that, I think --capath + X509_V_FLAG_CRL_CHECK is a good
> idea, as a more full-featured alternative to --crl-verify, when people
> don't mind needing to restart the daemon to re-read the CRL files.

Restart OpenVPN is a problem for me : our tunnels are used for=20
"real-time" apps (hundreds of Windows TSE clients), I cannot stop them=20
and break all TSE clients in case of a simple revocation... :-(


The ultimate solution will be OCSP, but... we are in 2005 ;-)

Thank you for your attention about this issue.
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

