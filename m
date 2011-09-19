Message-ID: <4E773F7A.7010902@...1114...>
Date: Mon, 19 Sep 2011 15:11:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20110919113206.2fe282f8@...1506...>
In-Reply-To: <20110919113206.2fe282f8@...1506...>
Subject: Re: [Openvpn-devel] Incorrect instructions in tester documentation
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/09/11 11:32, Davide Brini wrote:
> On the "TesterDocumentation" page, the instructions say
> 
> When testing this version of OpenVPN, we would appreciate if all deprecated
> features would be disabled by default. We want to know how OpenVPN behaves
> for you without these features. When doing the compile-time configuration
> of OpenVPN, please make sure the following arguments are included:
> 
>     --disable-depr-random-resolv
> 
> 
> However there doesn't appear to be such an option recognized by the
> configure script:
> 
> $ ./configure --disable-depr-random-resolv 
> configure: WARNING: unrecognized options: --disable-depr-random-resolv
> ...
> 
> Not sure whether I'm doing something wrong or the docs need to be updated.
> Thanks!

Hi,

The docs probably need a review again.  That configure option was obsoleted
when James resolved this in a complete different way a while ago.
Nowadays, you don't need to use this argument at all.  That's the only
change AFAIR.  Please feel free to update the docs!


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk53P3cACgkQDC186MBRfrqa3QCgmKY+/UK0+CzsiOjiB6Bfkc35
KZcAn0LDkynZWUS/UIgGJjQ57BSueiIW
=VNXf
-----END PGP SIGNATURE-----

