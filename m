Message-ID: <4AFAAD5C.4070303@...1114...>
Date: Wed, 11 Nov 2009 13:26:04 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>	<20091111102515.GA19782@...1066...>
	<4AFA9AA7.4030600@...260...>
In-Reply-To: <4AFA9AA7.4030600@...260...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mathieu GIANNECCHINI <mat.giann@...260...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/09 12:06, Mathieu GIANNECCHINI wrote:
> Victor Wagner a écrit :
>> On 2009.11.11 at 09:40:59 +0100, David Sommerseth wrote:
>>
>>   
>>> On 10/11/09 17:16, Till Maas wrote:
>>>     
>>>> I would like to get a notification in case a client certificate is used
>>>> for a connection to an OpenVPN server, that is about to expire soon. Is
>>>> there currently a way to do this? I looked into the tls-verify hook, but
>>>> according to the documentation, only the Subject line of a certificate
>>>> is available and not the validity. Is there maybe a way to log the
>>>> expiration dates?
>>>>       
>>> I don't think this is possible without patching openvpn to put these
>>> values into some environment variables for the --tls-verify hook.  I've
>>> done something similar in regards to the SHA1 fingerprint for my own
>>> project (I have had an OpenVPN patch pending since RC7).  But I'd be
>>> willing to carry such a feature in my eurephia patch for OpenVPN, as
>>> that sounds very useful.
>>>     
>>
>> Apache/mod_ssl does export entire certificate in the PEM format as
>> environment variable. So, may be openvpn sould do the same?
>>
>> Now various people patching openvpn to add some values:
>> you've added sha1 fingerprint, I've added certificate extension
>> subjectAltName, et cetera, et cetera.
>>
>> But if entire certificate would be available, it would be possible to
>> extract any information from it (or hash it with any algorithm) from the
>> script using openssl command line utility or some binding or OpenSSL
>> libraries to the choosen script language.
>>   
> 
> Ok, i try once again. Maybe the solution is here :
> http://article.gmane.org/gmane.network.openvpn.devel/2492

Indeed!  And you're about to get my vote for this implementation ... but
I have two concerns.

1) The certificate is first dumped to file.  Would it be possible to
pass it only via environment table, to avoid the file stage?  The reason
for this is primarily security (not to write more to disk than what you
really need on disk), and secondarily - SELinux - avoiding writing data
to disk you are more sure that SELinux or other MACs will not interfere
and deny the write requests.  This is especially crucial if OpenVPN is
run in as a contained user (which most daemons really do)

2) If an attacker sends a certificate with his certificate and 999 CA
certificates in a chain, what will happen?  What happens if the disk
goes full or the certificate cannot be written?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr6rVkACgkQDC186MBRfrrxSgCeMq5lVAvIAvPNVN6mfOgO7Avj
q0UAnjFM/FS6cgIt4igadYaHDThXli1c
=UKWi
-----END PGP SIGNATURE-----

