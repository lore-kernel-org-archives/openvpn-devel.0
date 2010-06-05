Message-ID: <4C0ABFFF.6060809@...1114...>
Date: Sat, 05 Jun 2010 23:22:07 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100604224938.GA19956@...1375...>
	<4C0AB229.4050307@...1114...>
	<201006052125.38352.dave_br@...1278...>
In-Reply-To: <201006052125.38352.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
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

On 05/06/10 22:25, Davide Brini wrote:
> On Saturday 05 June 2010, David Sommerseth wrote:
>> On 05/06/10 00:49, Matthias Andree wrote:
> 
>>> Note that some parts of the scripts may be Solaris /bin/sh unfriendly,
>>> for instance, Solaris's sh doesn't support test -e or [ -e. My patch
>>> does not address this.
>>
>> This makes me very reluctant from accepting the patch, to be very
>> honest.  I'd rather keep the current bashism which works on all
>> platforms where bash is available than to apply a patch which will break
>> the script from working on one of the supported platforms.
>>
>> I would rather like to see a patch which works safely on all platforms.
>>  If 'test -e' or '[ -e' does not work in /bin/sh on some platforms, that
>> do indeed speak for keeping the bash support - unless there are other
>> ways how to solve this issue.
> 
> I think Solaris should have a POSIX-compatible shell (korn shell, hence 
> supporting test -e) under /usr/xpg4/bin/sh, although for some reason the 
> default /bin/sh is an old bourne shell. People could link /bin/sh to the POSIX 
> shell, and then the scripts should work fine.

Yes, that can be seen as a solution for some people.  But then it would
be better for us to explicitly require the needed shell rather to tell
them to (w)hack their system "because easy-rsa don't support old Solaris
/bin/sh".

We should *never ever* recommend people to modify their OS base
installation at any point to make OpenVPN and/or its utilities to work.
 In fact, it's probably more likely that they would go in and modify the
shell script themselves to use the proper shell instead of re-link
/bin/sh - at least I hope the sys-admin would be that clever.

Anyhow, easy-rsa might not be the most critical tool, but accepting this
patch will cause a regression in the Solaris users point of view.  I'm
not willing to accept breaking features which we do know work in the
current release.

> However, I think it would be sensible, before merging, to actually do that and 
> test the scripts on a real Solaris system to check that they work as expected 
> (unfortunately I don't have access to a Solaris system, otherwise I would do 
> that myself).

The Solaris 10 docs states it pretty clear:

  -e file
      True if file exists. (Not available in sh.)

This limitation is also for -a, -G, -o, -O, -S, -nt, -ot and -ef.
source: <http://docs.sun.com/app/docs/doc/816-5165/test-1?l=en&a=view>

And there are 3 places where we do use 'test -e' in easy-rsa-2.0:

nherit-inter:29:    if [ -e "$1/$EXPORT_CA" ]; then
pkitool:371:		[ -e "$FN.crt.der" ]; rm "$FN.crt.der"
revoke-full:29:    if [ -e export-ca.crt ]; then

We simply need to solve these issues to avoid bashism.

Davide: I know you have done some bashishm cleanup already on some other
scripts.  Can you double check that those scripts do not break, based on
this Solaris information?  I was not aware of this limitation in
Solaris, so I did not check for such things during the review.  But
those patches needs to be double checked now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwKv/8ACgkQDC186MBRfrpIRgCgrq2qORzynmagW8sozDNYQL3g
IHEAoJxf80eFjh9ugdzkm6Z4tMGR53ef
=/k22
-----END PGP SIGNATURE-----

