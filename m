Message-ID: <4B8B954C.6000600@...1114...>
Date: Mon, 01 Mar 2010 11:22:04 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267421566.30675.5@...1207...>
In-Reply-To: <1267421566.30675.5@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] enhance tls-verify possibility
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 06:32, Karl O. Pinc wrote:
> On 02/28/2010 10:24:36 PM, Peter Stuge wrote:
>> David Sommerseth wrote:
>>> +++ b/options.c
>>> @@ -529,6 +529,9 @@ static const char usage_message[] =
>>>    "                  tests of certification.  cmd should return 0
>> to allow\n"
>>>    "                  TLS handshake to proceed, or 1 to fail.  (cmd
>> is\n"
>>>    "                  executed as 'cmd certificate_depth
>> X509_NAME_oneline')\n"
>>> +  "--tls-export-cert [directory] : Get peer cert in PEM format and
>> store it \n"
>>> +  "                  in an openvpn temporary file in [directory].
>> Peer cert is \n"
>>> +  "                  stored before tls-verify script execution and
>> deleted after.\n"
>>
>> Please update the man page too
> 
> There is no man page.  It's in sample-scripts/.
> 
> However, the openvpn(8) --tls-verify section of the man page
> is poor.  I just sent another patch that clarifies it.
> Perhaps this is what you're looking for?  If not then
> just ignore my man page patch.

I don't mean to be harsh ... but this patch updates options.c and
introduces a new argument to OpenVPN.  So I agree, Peter, a man page
update is needed!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLlUwACgkQDC186MBRfrpiUQCgrCwtf8ptYVxsktB2dLq83T1U
ic8Amwf5tLcVlwlrBKU+sAedeutTZK5H
=vzdA
-----END PGP SIGNATURE-----

