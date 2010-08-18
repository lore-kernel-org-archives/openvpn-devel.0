Message-ID: <4C6BD90E.2050707@...1114...>
Date: Wed, 18 Aug 2010 14:58:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1282134451-21285-1-git-send-email-dazo@...384...>
	<4C6BD3CB.5050009@...68...>
In-Reply-To: <4C6BD3CB.5050009@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
 if	t_client.rc is missing
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/10 14:36, Matthias Andree wrote:
> Am 18.08.2010 14:27, schrieb David Sommerseth:
>> This is to avoid 'make check' fail if this extra test case is not
>> configured.  The patch gives a PASS, but will notify the user that
>> this test was skipped.
> 
> The right approach would be to "exit 77" instead of 0,
> so that "make check" can report the SKIP properly.  Assuming that t_client.sh is
> listed in TESTS in some Makefile.am, which I didn't check.
> 

Ahh!  There it was!  I thought I had seen this before, but I couldn't
find any good references in the automake manual so far.  I'll fix this
and send a new patch.

Thanks a lot!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxr2Q4ACgkQDC186MBRfrrqxwCffcH35sVufO3GUaTueTQeuPW8
nXIAnRw9OJcVScGpEdGn2tYyBanpCy5w
=pE1H
-----END PGP SIGNATURE-----

