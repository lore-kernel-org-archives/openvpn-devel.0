Date: Wed, 11 Nov 2009 15:54:43 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091111125443.GA29471@...1066...>
References: <20091110161632.GA31301@...1276...>
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
	<4AFAA745.4030806@...1114...>
MIME-Version: 1.0
In-Reply-To: <4AFAA745.4030806@...1114...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending	on
	the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.11.11 at 13:00:05 +0100, David Sommerseth wrote:

> 
> Good point!  I was not aware of the Apache/mod_ssl way of doing it.  My
> only concern about that is if it would be possible to exhaust the memory
> pool for environment variables?  Imagine a a buffer overflow bug if an
> attacker sends a specially crafted certificate request with 1000
> certificates in a chain.

I'm not sure that all intermediate CA Certificates have to be exported
such way. I don't remember if Apache does so, because I never tried to
test Apache with chain longer than 1 and without intermediate CA certs
in the OpenSSL cert-store.

For most purposes two things are sufficient
1. Check validity of client certificate data using chain 
(i.e. did intermediate CAs have right to issue certificate with such
extension). It is better done inside OpenSSL.  

I've written patch which enables OpenSSL builtin certificate policy
checking in OpenVPN.

2. Get an information from client certificate, not from intermediate CA
certificate in the chain.

> The reason for this concern is that OpenVPN provides now all certificate
> info available at once in many of the the different hooks, all with _0,
> _1, _2, etc as a suffix at the end of the environment variable name.
> With roughly 2KB per certificate, on a cruel attack with 1000 chained
> certificates, that could mean 2MB would be needed for the environment
> table and you would have 1000 environment variables to go through.
[skip]
> One way how to control this situation would be to also implement a
> "--max-chained-certs" argument, which would default at something
> reasonable, f.ex 5.
> 

Really, OpenSSL allows to set maximal
verification depth. Apache mod_ssl has a configuration directive which
sets maximum allowed chain length using SSL_CTX_set_verify_depth
function. OpenVPN doesn't provide such a directive now. 

So, may be exporting certificate should be accompanied with providing
such a directive with reasonable default.

I've never seen chains longer than 3, so 5 should be sufficient.



