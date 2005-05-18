Message-ID: <428B59C7.3010008@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for a --capath option
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...> <4281E350.8020609@...349...> <42821866.9080008@...349...> <Pine.LNX.4.58.0505180533040.14237@...41...>
In-Reply-To: <Pine.LNX.4.58.0505180533040.14237@...41...>
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
Date: Wed May 18 09:43:10 2005
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

Le 18.05.2005 13:42, James Yonan a =E9crit :
>>I'm not very happy with this patch : all CA and CRL are checked, but if=20
>>I update a CRL, openssl doesn't see any changes and continue to accept=20
>>my revoked certificate.
>>I don't know if there is a "cache" system integrated in openssl... I=20
>>don't know if I correctly use X509_STORE_add_lookup() and=20
>>X509_LOOKUP_add_dir() ... I'm not a openssl guru, not at all ;-)
> I think the "cache" you are seeing is the SSL_CTX object -- did you make =

> any progress in figuring out how to have OpenSSL re-read the CRL info fro=
m=20
> the CAPath dir?

The cache is in the X509_STORE objet. Looking at openssl sources=20
(0.9.7), there is a "cache" flag in this struct, but this flag is unused:

 From x509_vfy.h :

    struct x509_store_st
         {
           /* The following is a cache of trusted certs */
           int cache;      /* if true, stash any hits */
           STACK_OF(X509_OBJECT) *objs;    /* Cache of all objects */
           /* These are external lookup methods */
           STACK_OF(X509_LOOKUP) *get_cert_methods;
	  (...)
	}


When OpenSSL have to check a CRL in the STACK_OF(X509_OBJECT), a simple=20
cache algorithm is used : if a CRL is found in the stack, use it ; if=20
not, search it with the registred lookups methods and store it in the stack.

I do not see any system for refresh the cache (no timeout, no function).
I have sent a mail on openssl-user list without any anwser.

Looking in apache-ssl, racoon (other openssl projects) : it seems that=20
there all need a restart or reload after update the CRL.

I think a nice solution would be to rebuild the X509_STORE of the=20
SSL_CTX when a SIGHUP ou SIGUSR1 arrived. But I do not understand yet=20
enough the code of OpenVPN :
- where can I add an action when a SIGUSR1 or SIGHUP is handled ?
- how can I get the (list of ?) SSL_CTX object ?

Do you think that it is a good idea, and do you think that it is feasible ?

Thanks,
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

