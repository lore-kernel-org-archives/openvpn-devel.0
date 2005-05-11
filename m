From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Security bug with crl-verify
In-Reply-To: <4281BADE.2020402@...349...>
Message-ID: <Pine.LNX.4.58.0505110329020.15651@...41...>
References: <4281BADE.2020402@...349...>
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
Date: Wed May 11 02:52:12 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Thomas NOEL <thomas.noel@...349...>
Cc: openvpn-devel@lists.sourceforge.net

> Hello,
> 
> I think there is a security issue with the crl-verify code. OpenVPN only 
> check the issuer of the CRL, but not the CRL signature.
> 
> If you sign a CRL with another CA (even self signed) which have the same 
> DN than the certificate issuer, OpenVPN accept it as a good CRL : the 
> server or the client do not log any error... So, an attacker can easely 
> produce such a false CRL, nobody can see the attack.

I don't see how an attacker could produce a false CRL unless they had 
write access to the CRL file.

> The CRL must be validated : OpenVPN must verify it has been signed by 
> one of the CAs indicated in --ca.

I don't see how it matters whether or not the CRL is validated, because
anyone with sufficient privilege to overwrite the CRL file with an
"unauthorized" CRL would also simply be able to change the OpenVPN config
file to not use a CRL in the first place.

I would only consider this to be a security bug if there was some way that
a remote client could successfully connect using a certificate which had
been banned by the CRL.

And I don't see how this would be possible, because the CRL bans 
certificates by serial number, and a remote client could not change the 
serial number on their certificate unless they had access to the root CA 
key, or unless they had the ability to actually change the CRL file on the 
server, which they couldn't do unless they already had root access to the 
server.

> Looking in the "racoon" code, I think that CRL handling 
is easier with > new versions of openssl (>= 0.9.7)
> 
>    (...)
>    #if OPENSSL_VERSION_NUMBER >= 0x00907000L
>          X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK);
>          X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK_ALL);
>    #endif
>    (...)
> 
> With this kind of X509_STORE_CTX, openssl automagically manage all CA 
> and all CRL included in a "CAPath".

Good idea -- it would be better for OpenSSL to handle all of the CRL stuff 
for 0.9.7 and above.

James


