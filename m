From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Patch for a --capath option (was: Security bug
 with crl-verify)
In-Reply-To: <42821866.9080008@...349...>
Message-ID: <Pine.LNX.4.58.0505180533040.14237@...41...>
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...>
 <4281E350.8020609@...349...> <42821866.9080008@...349...>
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
Date: Wed May 18 04:45:23 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Thomas NOEL <thomas.noel@...349...>
Cc: openvpn-devel@lists.sourceforge.net


On Wed, 11 May 2005, Thomas NOEL wrote:

> Hello,
> 
> >>>  (...)
> >>>  #if OPENSSL_VERSION_NUMBER >= 0x00907000L
> >>>        X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK);
> >>>        X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK_ALL);
> >>>  #endif
> >>>  (...)>>
> >>>With this kind of X509_STORE_CTX, openssl automagically manage all CA 
> >>>and all CRL included in a "CAPath".
> >>Good idea -- it would be better for OpenSSL to handle all of the CRL stuff 
> >>for 0.9.7 and above.
> > I will try to produce a patch for a "--capath" option. See you in two or 
> > three hours.
> 
> Attached, a patch (experimental, proof of concept...).

> I'm not very happy with this patch : all CA and CRL are checked, but if 
> I update a CRL, openssl doesn't see any changes and continue to accept 
> my revoked certificate.

> I don't know if there is a "cache" system integrated in openssl... I 
> don't know if I correctly use X509_STORE_add_lookup() and 
> X509_LOOKUP_add_dir() ... I'm not a openssl guru, not at all ;-)

Thomas,

Thanks for the patch -- it would be nice to have OpenSSL deal with CRLs 
internally via CAPath.

I think the "cache" you are seeing is the SSL_CTX object -- did you make 
any progress in figuring out how to have OpenSSL re-read the CRL info from 
the CAPath dir?

James


