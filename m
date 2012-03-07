Message-ID: <4F576C3B.9090308@...1114...>
Date: Wed, 07 Mar 2012 15:10:03 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
In-Reply-To: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/03/12 13:48, Jonathan K. Bullard wrote:
[...skip...]
> 
> *Details *
> 
> OpenVPN 2.3alpha1 fails when the argument to "--up" contains more
> than an execution path. The problem also occurs for the "--down"
> option and the new "--route-pre-down" option (and presumably any other
> options that take more than just an execution path).
> 
> OpenVPN 2.2.1 and earlier work fine with an identical command line.
> 
> This happens on OS X; I don't know about other platforms but I assume
>  option processing is not very platform specific.
> 
> 2.3alpha1 is apparently treating the entire argument that follows 
> "--up" as the path for a file to execute, instead of treating it as a 
> shell command consisting of a path optionally followed by arguments.
> 
> On 2.3alpha1:
> 
> test jkb$ *openvpn-2.3-alpha1/openvpn --config 
> /private/tmp/test/config.ovpn  --up "/private/tmp/test/up.sh -x"* 
> Options error: --up script fails with '/private/tmp/test/up.sh  -x': 
> No such file or directory Options error: Please correct these errors.
>  Use --help for more information.

Ouch!  I see that check_file_access() needs to strip out any arguments.
It will now basically 'access("/private/tmp/test/up.sh -x")' ... which is
a file which doesn't exist ... but if it tested for
'access("/private/tmp/test/up.sh")' it should find the file.

However, it isn't as easy to just skip through the string and "terminate
it" on the first space (0x20) value, as it might have been escaped.
Which can make quite typical paths like this fail:

   "C:\Program Files\OpenVPN\bin\up-script.bat"

I got my plate very full right now, so if you or someone else have time
to poke at this, that'd be great.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XbDkACgkQDC186MBRfrp1NgCeO7CLBygxocRknDbrYMNl3lg4
nnMAn0nSnMVMGTcSDDttD8zOp5JDhnX/
=rgox
-----END PGP SIGNATURE-----

