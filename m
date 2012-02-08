Message-ID: <4F32A2A9.8020303@...1114...>
Date: Wed, 08 Feb 2012 17:28:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1328612333-10321-1-git-send-email-davids@...1347...>
	<1328621508-18076-1-git-send-email-davids@...1347...>
In-Reply-To: <1328621508-18076-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix assert() situations where
 gc_malloc() is called without a gc_arena object
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/02/12 14:31, David Sommerseth wrote:
> In commit bee92b479414d12035b0422f81ac5fcfe14fa645 the gc_malloc()
> was hardened to always require a gc_arena object for garbage
> collection. Some places in the code expected the old behaviour of a
> normal malloc() in these cases, that is a memory allocation without
> garbage collection.
> 
> This old behaviour is partly restored by allowing string_alloc() to
> do a non-gc based allocation if no gc_arena object is available.  In 
> addition some other places string_alloc() will now be called with a 
> gc_arena pointer where such an object is available.
> 
> The alloc_buf() function has also been refactored to not use 
> gc_malloc() at all.
> 
> v2: - removes a memleak when --ifconfig-ipv6 is used several times - 
> makes string_alloc() behave properly if DMALLOC is enabled
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- buffer.c
> | 32 ++++++++++++++++++++++++++++---- init.c       |    2 +-
> openvpn.c |    2 +- options.c    |    7 ++++++- pf.c         |    2
> +- ssl_verify.c |    2 ++ 6 files changed, 39 insertions(+), 8 
> deletions(-)
> 

Acked by Gert on #openvpn-devel.  Applied to master and pushed out to -stable
and -testing.

commit dc7be6d078ba106f9b0de12f3e879c3561c3c537
Author: David Sommerseth <davids@...1347...>
Date:   Mon Feb 6 00:30:47 2012 +0100

    Fix assert() situations where gc_malloc() is called without a
gc_arena object

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>



kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8yoqkACgkQDC186MBRfrpwUQCgqMy+nI3jvoIzxJF6j8tOgNRo
gdcAnAn9q5OOK4p8z/OJDvRkOkxxRQJs
=kYaj
-----END PGP SIGNATURE-----

