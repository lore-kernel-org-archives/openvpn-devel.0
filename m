Message-ID: <4FED5E04.10404@...1114...>
Date: Fri, 29 Jun 2012 09:49:24 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FEC9804.2070805@...1227...> <4FECB181.4070105@...1114...>
	<4FECCAF7.9060000@...1227...>
In-Reply-To: <4FECCAF7.9060000@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --management-external-key in
	2.3alpha
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/06/12 23:21, Arne Schwabe wrote:
>> But ... is it expected to pass --key if you use 
>> --management-external-key? I probably don't know enough about
>> this --management-external-key feature, so I might be wrong.
> 
> No. --key is not passed but --managment-external-key sets --key
> filename to EXTERNAL_KEY (like inline TAG for files).

Ahh, okay, that makes sense.  Should we consider to make --key and
- --management-external-key exclusive?  So they it will choke if both is
used?  Just to make the usage a bit clearer.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/tXgEACgkQDC186MBRfrr/RACfX/v8arl5/kfCQRNo/ZIDbzDh
rCgAnRVJAhmobwOFPn8ddgvufiXhE9u6
=V2AG
-----END PGP SIGNATURE-----

