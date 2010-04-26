Message-ID: <4BD57788.9060404@...1114...>
Date: Mon, 26 Apr 2010 13:22:48 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004260956.16533.dave_br@...1278...>
	<4BD56520.9070807@...1114...>
	<201004261148.38378.dave_br@...1278...>
In-Reply-To: <201004261148.38378.dave_br@...1278...>
Subject: [Openvpn-devel] Building from git tree (was: Re: [PATCH] Serial
 number export, fixed)
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 12:48, Davide Brini wrote:
> On Monday 26 Apr 2010 11:04:16 David Sommerseth wrote:
[...snip...]

> I have another (unrelated) question. The GIT master branch lacks the configure 
> script, so how do you go about building it for testing? I vaguely seem to 
> remember something about running autoscan plus other tricks, is that the case 
> with OpenVPN or are the instructions different? 

First of all, I would probably recommend working against the bugfix2.1
branch in this case.  You're actually fixing a bug.  And then it's going
to be easier to apply your patch to the main tree afterwards.  I see I
need to "soften" up the developers page a little bit on this point.  The
whole openvpn-testing.git tree is a moving target, and I'm adjusting the
routines to make it as smooth and easy for as many as possible.

For the building part, you just need to run 'autoreconf -i' (add -v to
be more verbose).  That should be all.

It would also be a good idea to always run 'make distcheck' when you're
feeling confident with the patch.  You also have 'make check', but that
only does a compilation against your "local" source code.  Running
distcheck will copy all the source files which is defined to be a part
of the distribution to a new directory and compile the source from
there, thus making sure you're not missing any files.  That's especially
important when adding new files to the repository.  Most probably you'll
need to update Makefile.am to get those files included.

> Also, whatever the
> instructions are, I would suggest they be added to the official "developer 
> information" page.

It actually is documented, but under the "Documentation for testers" ...
the old wiki got it here:

	<http://www.secure-computing.net/wiki/index.php/OpenVPN/Documentation_for_testers>

I'll make sure that documentation is referenced somehow when the new
community server gets fixed again.  All this documentation should be
available here primarily.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVd4MACgkQDC186MBRfrpVIQCgiMJD+hP2coratHwGPhVXXpxO
jRMAnRE+UEmxGeqRAiOFaXkiBfPqotVI
=RU5T
-----END PGP SIGNATURE-----

