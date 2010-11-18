Message-ID: <4CE58F06.7000603@...1114...>
Date: Thu, 18 Nov 2010 21:39:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>	<20101112165541.29963.qmail@...1287...>	<4CDD7309.3030808@...1114...>	<4CDD7559.5000604@...515...>	<4CDD77B9.8050606@...1114...>	<4CDD7D32.2050401@...515...>	<20101112175153.4861.qmail@...1287...>	<4CE2A7F9.2020402@...515...>	<20101116155849.23656.qmail@...1287...>
	<4CE54F2C.9040405@...515...>
In-Reply-To: <4CE54F2C.9040405@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
 from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/11/10 17:07, Samuli Seppänen wrote:
|
|> Samuli Seppänen wrote:
|>
|>> here's the next version of the patch;
|>>
|>
|> Functionally fine!
|>
|>
|>
|>>   def main(config):
|>> +
|>> +    # Do a signed build by default
|>> +    unsignedBuild=False
|>>
|>
|> Maybe name the option signedBuild instead? :)
|>
|>
|>
|>> +    # Check if the SignTool module is present. This avoids ImportErrors
popping
|>> +    # up annoyingly _after_ the build.
|>> +    if unsignedBuild == False:
|>> +       try:
|>> +          from signtool import SignTool
|>> +       except (ImportError):
|>> +          print "ERROR: SignTool python module not found! Can't do a
signed build."
|>> +          sys.exit(1)
|>> +
|>> +    if unsignedBuild == True:
|>> +       print "Doing an unsigned build as requested"
|>>
|>
|> I guess the pythonic way would be simply:
|>
|> if signedBuild:
|>    try import..
|> else:
|>    print as requested..
|>
|>
|>
|>> -    sign(config, 'all')
|>> +
|>> +    if unsignedBuild == False:
|>> +       sign(config, 'all')
|>> +
|>>
|>
|> signedBuild would be nicer, then simply:
|>
|> if signedBuild:
|>    sign()
|>
|>
|> //Peter
|>
|
| All fixes applied in this patch.
|

Applied to bugfix2.1 and merged into allmerged and beta2.2.

commit f20c2f0d6b42f652f39c0082237c3f8d69752ec9
Author: Samuli Seppänen <samuli@...515...>
Date:   Thu Nov 18 18:00:54 2010 +0200

~    Added command-line option parser and an unsigned build option to
~    build_all.py

~    Modified win/build_all.py so that it parses command-line options using
~    getopt.  Added option "-u / --unsigned" which allows forcing unsigned
~    builds and a "-h / --help" option. By default a signed build is
~    generated, provided that the Python SignTool module is installed. If not,
~    the build is interrupted.

~    Signed-off-by: Samuli Seppänen <samuli@...515...>
~    Acked-by: Peter Stuge <peter@...1287...>
~    Signed-off-by: David Sommerseth <dazo@...384...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzljwYACgkQDC186MBRfrot4QCeI5+9fPykjKgnq1YaiKJ8NOxv
Po4Anj1+e1455f4uPJo4+Zml6W8IhKQi
=sRCX
-----END PGP SIGNATURE-----

