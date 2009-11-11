Message-ID: <4AFAD26C.7010900@...1114...>
Date: Wed, 11 Nov 2009 16:04:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>	<20091111102515.GA19782@...1066...>	<4AFAA745.4030806@...1114...>
	<20091111125443.GA29471@...1066...>
In-Reply-To: <20091111125443.GA29471@...1066...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending
 on	the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/09 13:54, Victor Wagner wrote:
> On 2009.11.11 at 13:00:05 +0100, David Sommerseth wrote:
> 
>>
>> Good point!  I was not aware of the Apache/mod_ssl way of doing it.  My
>> only concern about that is if it would be possible to exhaust the memory
>> pool for environment variables?  Imagine a a buffer overflow bug if an
>> attacker sends a specially crafted certificate request with 1000
>> certificates in a chain.
> 
> I'm not sure that all intermediate CA Certificates have to be exported
> such way. I don't remember if Apache does so, because I never tried to
> test Apache with chain longer than 1 and without intermediate CA certs
> in the OpenSSL cert-store.
> 
> For most purposes two things are sufficient
> 1. Check validity of client certificate data using chain 
> (i.e. did intermediate CAs have right to issue certificate with such
> extension). It is better done inside OpenSSL.  
> 
> I've written patch which enables OpenSSL builtin certificate policy
> checking in OpenVPN.
> 
> 2. Get an information from client certificate, not from intermediate CA
> certificate in the chain.

I completely agree, that under normal circumstances, it should be enough
by letting OpenSSL take care of the certificate chain.  But as OpenVPN
now do list more certificates already, I was just trying to keep that
possibility still open.

In the OpenVPN plug-in I've written which does username, password and
certificate authentication, I've been playing with an idea of using the
certificate chain to apply different "rules" (network, login hours, etc)
based on the certificate chain as well.

An example:

        CA
        /\_____________
       /               \
     sales           IT dept
      CA               CA
     /   \           /    \
    sale1 sale2    admin1  admin2

This way you can for example give the same network access to all "sales
people" by assigning an access profile based users who got a certificate
signed by "sales CA" and another access profile to users with their
certificates signed by the "IT dept CA".

In other words, group management based on the certificate chain.  But
then all certs in the chain needs to be exported to the plug-ins.

>> The reason for this concern is that OpenVPN provides now all certificate
>> info available at once in many of the the different hooks, all with _0,
>> _1, _2, etc as a suffix at the end of the environment variable name.
>> With roughly 2KB per certificate, on a cruel attack with 1000 chained
>> certificates, that could mean 2MB would be needed for the environment
>> table and you would have 1000 environment variables to go through.
> [skip]
>> One way how to control this situation would be to also implement a
>> "--max-chained-certs" argument, which would default at something
>> reasonable, f.ex 5.
>>
> 
> Really, OpenSSL allows to set maximal
> verification depth. Apache mod_ssl has a configuration directive which
> sets maximum allowed chain length using SSL_CTX_set_verify_depth
> function. OpenVPN doesn't provide such a directive now. 

Exactly! :)  I knew I had seen this limit somewhere, just didn't connect
it to OpenSSL right now.  I don't find any traces of this function call
at all in the OpenVPN, so this would be needed.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr60mcACgkQDC186MBRfrqOugCgiDvs/kwpNxrAzoNJqqdhogts
k/cAniVHz1slgiY+rG/lsXg76D5JLXx/
=9g2E
-----END PGP SIGNATURE-----

