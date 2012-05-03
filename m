Message-ID: <4FA239AB.4080308@...1114...>
Date: Thu, 03 May 2012 09:54:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: add git revision to --version
 output if build from git repository
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/12 20:00, Alon Bar-Lev wrote:
> If configure is located at git repository, acquire branch and
> revision of head to be printed at --version output.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> configure.ac          |   11 +++++++++++ src/openvpn/options.c |
> 3 +++ 2 files changed, 14 insertions(+), 0 deletions(-)

This is definitely a step in the right direction.  However, it depends
on ./configure being run to get the updated git revision set.  When
developing and testing out changes, you don't always need to run
./configure for each build.  Thus this may provide a false reference.

Let me explain more carefully:

  $ ./configure
  $ make
  (test src/openvpn/openvpn)
  (hack more on source files in src/openvpn)
  $ make
  (test src/openvpn/openvpn)
  $ src/openvpn/openvpn src/openvpn/openvpn-test1
  (hack more on source files in src/openvpn)
  $ make
  (test src/openvpn/openvpn and compare against openvpn-test1)

If doing such an iteration over a day or two or maybe weeks (which is
not uncommon for me, as I don't have time to dig into OpenVPN every
day), the git revision reference provided with your patch will not
help me much.  And as I also work across several branches, testing
different approaches for the same issue, I would need far better
overview over what's git HEAD of 'make' and not the 'configure' run.

What I would like to see is something more like what's found in TOR
projects' obfsproxy, where the Makefile generates a micro-version.i,
which is included.  As this file is forced to be (re-)created each
time, it will always be accurate.

I don't say that obfsproxy have done the implementation correct, but
it can at least be a seed for inspiration:

Makefile.am part:
<https://gitweb.torproject.org/obfsproxy.git/blob/94ebc4c3edf1e3e5f313444e59981ac557578df5:/Makefile.am#l106>

main.c parts:
<https://gitweb.torproject.org/obfsproxy.git/blob/94ebc4c3edf1e3e5f313444e59981ac557578df5:/src/main.c#l38>
<https://gitweb.torproject.org/obfsproxy.git/blob/94ebc4c3edf1e3e5f313444e59981ac557578df5:/src/main.c#l57>

Otherwise, that this git revision is not available when doing
'make dist' is no problem.  In fact, that's fairly reasonable, as
an official release is far easier to track back to a concrete commit.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+iOakACgkQDC186MBRfrp1ZQCfZwJ740HBH2wGOEK5lAEt2681
W/gAoKHlGzxG124aj+CrK6uqsjCEcqvc
=lCZv
-----END PGP SIGNATURE-----

