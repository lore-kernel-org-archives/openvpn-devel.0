Message-ID: <4DFF3759.2010709@...1114...>
Date: Mon, 20 Jun 2011 14:04:41 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1308302282-27985-1-git-send-email-samuli@...515...>	<1308556181-20317-1-git-send-email-samuli@...515...>
	<4DFF127B.1060006@...1114...> <4DFF1488.4040509@...1147...>
	<4DFF165D.7070501@...1114...> <4DFF2133.5010003@...1147...>
In-Reply-To: <4DFF2133.5010003@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add new openssl.cnf to easy-rsa/Windows
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
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/06/11 12:30, Jan Just Keijser wrote:
[...snip...]
>> Samuli, can you please look closer into this?  I did a more careful diff
>> from 2.0/openssl.cnf and Windows/openssl.cnf ... and it seems quite
>> different.  Can we please unite them?
>>
>> JJK: Do you know which differences are needed between Windows and
>> non-Windows?
>>
>>   
> I just checked that the openssl.cnf file shipped with the windows version
> of  openvpn 2.1.4 is identical to the easy-rsa/2.0 version - is there any
> reason not to do the same for openvpn 2.2?
> 

Good question!

Samuli, what do you think?  Could we actually just move the 2.0/openssl.cnf
to a common directory where the installers will pick this config file?  To
have the same file in more places in the source tree sounds chaotic for me,
especially when 2.1.4 uses the same file everywhere.

I'd suggest ./easy-rsa as a good common base.

I'm also wondering if we need to still carry easy-rsa/1.0 in the source
tree.  It looks rather dead ...

$ git log --follow --oneline ./easy-rsa/1.0/
3c7f2f5 version 2.1_beta1

Compared to this:

$ git log --follow --oneline ./easy-rsa/2.0/
6dc6019 pkitool lacks expected option "--help"
2d4e768 bash->bourne script cleanup
564a210 Updated copyright date to 2010.
9f4725e pkitool lacks expected option "--help"
d7fa38f Update copyright to 2009.
2534aa4 Fixed revoke-full to deal with issue arising from addition ...
dbec0a2 Modified pkitool to allow flexibility in separating the Com...
d56dec6 Change to pkitool/openssl.cnf so that calling scripts can s...
367ed08 Copyright notice changed to reflect change in name of Telet...
1c0cc4a Copyright change OpenVPN Solutions LLC -> Telethra, Inc.
eca8691 Updated copyright notice to 2008.
4d90d73 Updated version & changelog.
d4fb6d4 Set tool defaults in pkitool.
eba4632 Added note about alternative version of easy-rsa that suppo...
8d54351 Clean up configure on FreeBSD for recent autotool versions ...
acb567c A few more updates: -r 1015:1025 https://svn.openvpn.net/pr...
a8105c6 Merged PKCS#11 extensions to easy-rsa/2.0  (Alon Bar-Lev). ...
513baee Small fixes: * Fixed variable declaration in crypto.c that ...
411e89a Merged --remote-cert-ku, --remote-cert-eku, and --remote-ce...
8810c26 Moved easy-rsa 2.0 scripts to easy-rsa/2.0 to be compatible...

$ git log --follow --oneline ./easy-rsa/Windows/
54c739e Revert "Add new openssl.cnf to easy-rsa/Windows"
663860a Add new openssl.cnf to easy-rsa/Windows
3810843 Fix a build-ca issue on Windows
6b2883a Change all CRLF linefeeds to LF linefeeds
d0b4271 In Windows build, package a statically linked openssl.exe t...
4030142 The easy-rsa directory installed by the windows installer c...
6fbf66f This is the start of the BETA21 branch. It includes the --t...


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/N1YACgkQDC186MBRfrqnhACfRIzVbmXxPr07nnD71SQWkf1H
AxAAn3JCMtBqWh4X7loLPntg6vkAKeRt
=wEAg
-----END PGP SIGNATURE-----

