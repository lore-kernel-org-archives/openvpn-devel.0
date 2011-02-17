Message-ID: <4D5C65CE.4040403@...1114...>
Date: Thu, 17 Feb 2011 01:03:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1297893314-9037-1-git-send-email-g.esp@...260...>
In-Reply-To: <1297893314-9037-1-git-send-email-g.esp@...260...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Fix warning: format not a string
 literal and no format arguments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gilles Espinasse <g.esp@...260...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/02/11 22:55, Gilles Espinasse wrote:
| Seen with gcc-4.4.5 and -Wformat -Wformat-security
|
| Signed-off-by: Gilles Espinasse<g.esp@...260...>
| ---
|   options.c |    6 +++---
|   push.c    |    4 ++--
|   2 files changed, 5 insertions(+), 5 deletions(-)

Thank you very much, but I'm sorry to be a party killer ... this is already
implemented in the beta2.2, bugfix2.1 and allmerged branches.

commit d6b783a8ec505c8e158bd0304c5e195cff5bb8c3
Author: David Sommerseth <dazo@...384...>
Date:   Fri Sep 17 17:10:25 2010 +0200

~    Fixed compiler warnings reported on Ubuntu 10.04

~    The warnings reported where:
~    --------------------------------------------------------
~    misc.c:158: warning: ignoring return value of ?nice?, declared with
~    attribute warn_unused_result
~    options.c:4033: warning: format not a string literal and no format
~    arguments
~    options.c:4043: warning: format not a string literal and no format
~    arguments
~    options.c:4053: warning: format not a string literal and no format
~    arguments
~    push.c:182: warning: format not a string literal and no format arguments
~    push.c:199: warning: format not a string literal and no format arguments
~    push.c:235: warning: format not a string literal and no format arguments
~    status.c:171: warning: ignoring return value of ?ftruncate?, declared
~    with attribute warn_unused_result
~    --------------------------------------------------------

~    Signed-off-by: David Sommerseth <dazo@...384...>
~    Acked-by: Gert Doering <gert@...1296...>
~    Acked-by: Peter Stuge <peter@...1287...>


But good catch!  Please be sure you check against at least the allmerged
branch in the future, and you might avoid dumping into this issue again.

And kudos for using the git tree and git send-email!

We're also in the last stages of finalising the 2.2-RC release, so in the near
future beta2.2 will become our master branch.  The git tree will go through
some minor changes, and we will simplify where to grab the correct code.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1cZc4ACgkQDC186MBRfrocIwCfUqNQIH/0D+OGZrNoW4QeauDg
AqIAoJ29S4PtV3NCiPQxnq4GldOS+sAK
=SNZs
-----END PGP SIGNATURE-----

