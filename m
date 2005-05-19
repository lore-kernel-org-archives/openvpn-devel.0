From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Patch for a --capath option
In-Reply-To: <428B59C7.3010008@...349...>
Message-ID: <Pine.LNX.4.58.0505190455500.14237@...41...>
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...>
 <4281E350.8020609@...349...> <42821866.9080008@...349...>
 <Pine.LNX.4.58.0505180533040.14237@...41...> <428B59C7.3010008@...349...>
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
Date: Thu May 19 04:10:17 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Thomas NOEL <thomas.noel@...349...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 18 May 2005, Thomas NOEL wrote:

> Hello,
>=20
> Le 18.05.2005 13:42, James Yonan a =EF=BF=BDcrit :
> >>I'm not very happy with this patch : all CA and CRL are checked, but if=
=20
> >>I update a CRL, openssl doesn't see any changes and continue to accept=
=20
> >>my revoked certificate.
> >>I don't know if there is a "cache" system integrated in openssl... I=20
> >>don't know if I correctly use X509_STORE_add_lookup() and=20
> >>X509_LOOKUP_add_dir() ... I'm not a openssl guru, not at all ;-)
> > I think the "cache" you are seeing is the SSL_CTX object -- did you mak=
e=20
> > any progress in figuring out how to have OpenSSL re-read the CRL info f=
rom=20
> > the CAPath dir?
>=20
> The cache is in the X509_STORE objet. Looking at openssl sources=20
> (0.9.7), there is a "cache" flag in this struct, but this flag is unused:
>=20
>  From x509_vfy.h :
>=20
>     struct x509_store_st
>          {
>            /* The following is a cache of trusted certs */
>            int cache;      /* if true, stash any hits */
>            STACK_OF(X509_OBJECT) *objs;    /* Cache of all objects */
>            /* These are external lookup methods */
>            STACK_OF(X509_LOOKUP) *get_cert_methods;
> 	  (...)
> 	}
>=20
>=20
> When OpenSSL have to check a CRL in the STACK_OF(X509_OBJECT), a simple=20
> cache algorithm is used : if a CRL is found in the stack, use it ; if=20
> not, search it with the registred lookups methods and store it in the sta=
ck.
>=20
> I do not see any system for refresh the cache (no timeout, no function).
> I have sent a mail on openssl-user list without any anwser.
>=20
> Looking in apache-ssl, racoon (other openssl projects) : it seems that=20
> there all need a restart or reload after update the CRL.
>=20
> I think a nice solution would be to rebuild the X509_STORE of the=20
> SSL_CTX when a SIGHUP ou SIGUSR1 arrived. But I do not understand yet=20
> enough the code of OpenVPN :
> - where can I add an action when a SIGUSR1 or SIGHUP is handled ?
> - how can I get the (list of ?) SSL_CTX object ?
>=20
> Do you think that it is a good idea, and do you think that it is feasible=
 ?

Because of OpenVPN's security architecture, it is very common for a
privilege downgrade or chroot to occur after initialization.  This means
that it may not be possible to re-read a file after initialization.

This is a major reason why OpenVPN handles CRLs the way it does now: so=20
that (a) the OpenVPN daemon need not be restarted after a CRL update, and=20
(b) the CRL file itself can be located in the chroot jail without=20
requiring that the private key or any other files reside there as well.

Having said all that, I think --capath + X509_V_FLAG_CRL_CHECK is a good
idea, as a more full-featured alternative to --crl-verify, when people
don't mind needing to restart the daemon to re-read the CRL files.

James

