Message-ID: <4D263917.80908@...1114...>
Date: Thu, 06 Jan 2011 22:50:15 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
In-Reply-To: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
Subject: Re: [Openvpn-devel] beta2.2: automake support for plugin build
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
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/01/11 18:13, Matthias Andree wrote:
| Greetings,
|
| this is the beta2.2 patch pair for hooking the auth-pam and down-root
| plugins to the build.
|
| The bugfix2.1 patch pair has been sent earlier.
|
| Looking for review, ACK and NAK.
|

Hi Matthias,

And thanks a lot for your patches.  Just one question.  I see you try to do
all the Makefile generation in the main/root Makefile.am.  That is for sure a
fast-track to get started.  But I'm concerned if that might backfire in the
long run.

Why not to use the SUBDIRS variable in the root Makefile.am, and then have
separate Makefile.am per plugin?  That way, each plug-in can more easily
control the build independently.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0mORcACgkQDC186MBRfrrUMQCdEyCiQoerumQOo3ghc4F+kmrj
EGIAn3KhLzYGShvTZ5BRKoCcSVNIFXvl
=LG/J
-----END PGP SIGNATURE-----

