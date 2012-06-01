Message-ID: <4FC87A87.3010904@...1114...>
Date: Fri, 01 Jun 2012 10:17:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FC8736D.4030403@...515...>
In-Reply-To: <4FC8736D.4030403@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (31st May 2012)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/12 09:46, Samuli Sepp=E4nen wrote:
[...snip...]
>=20
> Had brief discussion regarding relative merits of patch management
> using the mailing list vs. GitHub. Dazo gave an estimate of the
> amount of work involved when using the mailing list:

Just to give a better understanding why the workload is considered
like this.

>=20
> - ACK: 20%

This requires reviewing code quality and the feature.  This is mostly
done by reading the patch file itself, evaluating if this change
really is needed, if the commit message explains well why this patch
is needed, is the coding style good and in compliance with most of the
typical style used in OpenVPN, look for typical issues in C (error
checking, NULL pointers, buffer overflows, etc).

It might be that in some cases, this ACK process takes 10% of the
time, sometimes 40% - all depending on the complexity of the patch.
But as an average, I probably spend 20% of the time doing this.

> - git-am: 40%

This includes applying the patch, adding the Acked-By: message and
testing this patch.  As a minimum, a complete build should be done
including 'make check'.  This also includes checking for compiler
warnings and other build related issues.

> - git-push 20%

The git-push itself is fairly simple, but it's needed to review the
build results from the buildfarm, to see if it builds cleanly on all
platforms we have available there.  Again, checking for compiler
warnings is an important step.

> - mailing the ACK message: 20%

This phase is to give a feedback to the submitter and the rest of the
community that the patch have been applied, and where to find this patch.

> So, pulling code from other repos on GitHub would probably save
> lots of time.

GitHub itself doesn't solve this at all.  But pulling from other git
repositories (that being repositories GitHub, git-daemon enabled
servers or http/https servers) where more people apply patches and
pushes them somewhere solves this.  GitHub is just a webUI built on
top of git.

However, pulling other git trees upstream requires that I and the
other active developers have full confidence in those external trees
and its maintainers.  I would even go so far to say that being active
on the #openvpn-devel IRC channel should be a requirement to be
considered.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/IeoQACgkQDC186MBRfrqVEwCeMcYI+CcP+YNCTIdwRtHzNhlg
Y7MAn35V++5t0L8A1Lwh5u9haJqIVjZH
=3DWU7o
-----END PGP SIGNATURE-----

