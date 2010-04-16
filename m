Message-ID: <4BC8385D.8040703@...1114...>
Date: Fri, 16 Apr 2010 12:13:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...> <4BC81AED.8010206@...1338...>
	<4BC824D3.8000008@...1114...>
	<4BC82AF0.5080905@...1114...>
	<20100416093554.GJ12312@...1296...>
In-Reply-To: <20100416093554.GJ12312@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/04/10 11:35, Gert Doering wrote:
> Hi,
> 
> On Fri, Apr 16, 2010 at 11:16:32AM +0200, David Sommerseth wrote:
>> I'll look more into this, as the only advantage is that if open() with
>> O_EXCL|O_CREAT fails if the file exists, it should be used instead.
> 
> Unfortunately, this won't help against symlink attacks directed to
> non-existant files (like "-> /etc/nologin").  

That's right, this could create a local DoS.  I'm going to have a more
careful look at test_file() afterwards.  Considering to make it use
stat() instead of just trying to open the file for reading.

> It *will* protect against symlink attacks to existing files (overwriting
> /etc/passwd or something similarily nasty).
> 

Agreed!  And that's why I've decided to rewrite the patch to use open()
with O_EXCL.  With an improved test_file() function, this potential bug
should be closed.

I've dived into the kernel code to see what it *really* does (when the
man page are so unclear), and it should behave as those other Unices
does as well.  So, O_EXCL do make sense to avoid overwriting existing
files if it is a symlink to an existing file.


Btw ... When diving into the kernel code, I stumbled upon this comment
in fs/namei.c:1872:

	/* Does someone understand code flow here? Or it is only
	 * me so stupid? Anathema to whoever designed this non-sense
	 * with "intent.open".
	 */

Thought that one was worth sharing ;-)  Having that said, this part of
the kernel code is not too easy to follow.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvIOFoACgkQDC186MBRfrr2UgCgrunMn9SRRTnlMB6606oTQgAd
07UAoJZmr8xAX7KKb8ERKW30X1Nuo8ZW
=KmQ+
-----END PGP SIGNATURE-----

