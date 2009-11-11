Message-ID: <4AFAA745.4030806@...1114...>
Date: Wed, 11 Nov 2009 13:00:05 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
In-Reply-To: <20091111102515.GA19782@...1066...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the validity of a certificate
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

On 11/11/09 11:25, Victor Wagner wrote:
> On 2009.11.11 at 09:40:59 +0100, David Sommerseth wrote:
> 
>> On 10/11/09 17:16, Till Maas wrote:
>>> I would like to get a notification in case a client certificate is used
>>> for a connection to an OpenVPN server, that is about to expire soon. Is
>>> there currently a way to do this? I looked into the tls-verify hook, but
>>> according to the documentation, only the Subject line of a certificate
>>> is available and not the validity. Is there maybe a way to log the
>>> expiration dates?
>>
>> I don't think this is possible without patching openvpn to put these
>> values into some environment variables for the --tls-verify hook.  I've
>> done something similar in regards to the SHA1 fingerprint for my own
>> project (I have had an OpenVPN patch pending since RC7).  But I'd be
>> willing to carry such a feature in my eurephia patch for OpenVPN, as
>> that sounds very useful.
> 
> Apache/mod_ssl does export entire certificate in the PEM format as
> environment variable. So, may be openvpn sould do the same?
> 
> Now various people patching openvpn to add some values:
> you've added sha1 fingerprint, I've added certificate extension
> subjectAltName, et cetera, et cetera.
> 
> But if entire certificate would be available, it would be possible to
> extract any information from it (or hash it with any algorithm) from the
> script using openssl command line utility or some binding or OpenSSL
> libraries to the choosen script language.

Good point!  I was not aware of the Apache/mod_ssl way of doing it.  My
only concern about that is if it would be possible to exhaust the memory
pool for environment variables?  Imagine a a buffer overflow bug if an
attacker sends a specially crafted certificate request with 1000
certificates in a chain.

The reason for this concern is that OpenVPN provides now all certificate
info available at once in many of the the different hooks, all with _0,
_1, _2, etc as a suffix at the end of the environment variable name.
With roughly 2KB per certificate, on a cruel attack with 1000 chained
certificates, that could mean 2MB would be needed for the environment
table and you would have 1000 environment variables to go through.

Maybe I'm concerned about a non-existing issue ... but I'd like to know
how things would behave in this scenario.

One way how to control this situation would be to also implement a
"--max-chained-certs" argument, which would default at something
reasonable, f.ex 5.

But initially, your suggestion is really not a bad idea as it would
solve future needs indeed.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr6pz8ACgkQDC186MBRfrqH2wCgqZfprWTvXeuNPe8iHdGfAZEr
BOUAniJOF9U+af+dwpFBpRDEIozPEbok
=KIVm
-----END PGP SIGNATURE-----

