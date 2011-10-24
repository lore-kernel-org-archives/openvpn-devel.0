Message-ID: <4EA50BBD.6030109@...1114...>
Date: Mon, 24 Oct 2011 08:54:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319366113-6891-1-git-send-email-davids@...1347...>
	<20111023153353.GX13250@...1518...>
In-Reply-To: <20111023153353.GX13250@...1518...>
Subject: Re: [Openvpn-devel] Fix PolarSSL and --pkcs12 option issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Nathan Stratton Treadway <nathanst@...1517...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/10/11 17:33, Nathan Stratton Treadway wrote:
> On Sun, Oct 23, 2011 at 12:35:13 +0200, David Sommerseth wrote:
>> diff --git a/options.c b/options.c index 39e7a57..4fd6933 100644 ---
>> a/options.c +++ b/options.c @@ -559,7 +559,9 @@ static const char
>> usage_message[] = "                  by a Certificate Authority in
>> --ca file.\n" "--extra-certs file : one or more PEM certs that
>> complete the cert chain.\n" "--key file      : Local private key in
>> .pem format.\n" +#ifndef USE_POLARSSL "--pkcs12 file   : PKCS#12
>> file containing local private key, local certificate\n" +#endif "
>> and optionally the root CA certificate.\n"
> 
> 
> Shouldn't that "#endif" be one line farther down, so that the "and 
> optionally the root CA certificate.\n" line is excluded along with
> the preceding line?

Duh!  Thanks a lot!  I've submitted a v2 patch of this patch, which fixes
this as well.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6lC7oACgkQDC186MBRfrovQQCgpzGkFut1J0+0fh0NjD2sPh5z
HasAn3wHXRfHAVVLcHLdydpe4OmTuQxQ
=VE2C
-----END PGP SIGNATURE-----

