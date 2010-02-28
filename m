Message-ID: <4B8A6E08.3090204@...1114...>
Date: Sun, 28 Feb 2010 14:22:16 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>
In-Reply-To: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>
Subject: Re: [Openvpn-devel] OpenVPN Pf plugin/small status patch
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/06/09 17:00, Arne Schwabe wrote:
> Hi,
> 
> I have written a simple plugin for packet filtering that looks up fw rules
> in the order
> 
> Commonname.pf
> IP_Port.pf
> IP.pf
> default.pf
> 
> If one of this files is found the file is used as PF configuration. Maybe
> this plugin is useful for someone else.

Hi!

Thank you for your patches.  I've been looking at both patches, and I
have some questions in regards to this plug-in.

How does this packet filtering further work?  I do not completely
understand how you imagine this should work.  I see that it tries to
open a number of files with different filename criteria , and if it
finds a file it copies it somewhere.

But how does that itself really provide packet filtering?

The code itself is not bad, I'd like to have it cleaned up a little bit
before inclusion.  Things I'm picking on are consequent spacing,
removing unneeded blank lines, improved comments (explaining *what* is
happening).

In addition the copypffile() function can be written a bit more clever,
avoiding using stack space for an array of file names.  As you already
have a for() loop, it would be better, IMHO, to build up the filename
string in this loop, using a simple select() for the filename template.

You also have a potential buffer overflow bug with your snprintf().  If
common name (the most likely one to attack) is longer than 256 bytes,
the filename will consist of those 256 bytes without a NULL terminator,
as snprintf() expect the NULL terminator to be included in the
size/length provided.

I'd recommend something like:

   char str[258];  // 256 bytes + 2 bytes extra

   memset(&str, 0, 258);  // Make sure it's NULL
   snprintf(str, 256, "%.253s.pf%c", cn, '\0');

or:

   char *str = calloc(1, 258); // 256 + 2 extra
   snprintf(str, 256, "%.253s.pf%c", cn, '\0');

   free(str);

This way str will never exceed 256 bytes, including the extension, and
it will be NULL terminated for sure.  In addition you are safer against
buffer overflows.  If using calloc(), the memory can be expected to be
zeroed as well (one of the advantages of calloc() compared to malloc()).

Using the str pointer above in a for loop, you can just call snprintf()
several times to change the contents, and free it after the for() loop.

I would also recommend to be stricter to the allowed string length when
processing IP addresses, port numbers and device name.  F.ex. the
filename template for port number could be: "%.5s.pf", as a port number
cannot be bigger than 65535, which is 5 digits.

And the last important thing, you have no error checking if copypffile()
fails or not.  OpenVPN will believe that this function call will always
work.  Granted, you if no files exist to be copied that might not be a
failure at all.  But it could be a failure if it could not write to the
destination file when it does the copy.

You also have two functions which might not be needed as well,
openvpn_plugin_client_contstructor_v1() and
openvpn_plugin_client_destructor_v1().  They don't seem to do anything
useful and OpenVPN don't require them, AFAIK.

The printf() messages could also specify the plug-in name instead of
just generic function names ... especially important for users who use
several plug-ins in parallel.


> Add I would like to ask to include the patch for multi.c.
> 
> There are commands in the management interface which require the cid. The
> only way at the moment to get the cid of connected clients is to have
> always a management connection established. The patch adds the CID to the
> status output.

This patch is sent for review by more developers.  It will need an
official ACK before inclusion, so I hope that will come soon.

Thank you once again for your contributions!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuKbggACgkQDC186MBRfrrG6ACfWIuNyCPpufx1DwRmv2RGCqug
8TEAnjRy8EPYVfrlCXw6xdSNg0UPaJl2
=oaxR
-----END PGP SIGNATURE-----

