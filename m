Message-ID: <4DBDA4FE.7000308@...1114...>
Date: Sun, 01 May 2011 20:22:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4DBA6D8D.1070900@...515...>
In-Reply-To: <4DBA6D8D.1070900@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (28th Apr 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/04/11 09:49, Samuli Sepp=E4nen wrote:
| Discussed the purpose of openvpn-testing.git and openvpn.git repos. Dazo
| outlined his current thoughts:
|
| - openvpn-testing.git
|    - would contain feature branches
|    - would be a "sandbox" for testing potentially unstable features
|
| - openvpn.git
|    - would contain release/maintenance branches (e.g. 2.1, 2.2)
|    - would contain pre-release branches (e.g. 2.3 alpha, beta and rc)
|
| The "master" branch on both would be kept in sync. Agreed that this
| setup makes sense.
|

I have today updated the git trees accordingly, in addition to clean up old
and obsolete branches.

* branches on openvpn.git  (stable tree)
~  master
~  release/2.1
~  release/2.2

* branches on openvpn-testing.git  (testing tree)
~  master
~  experimental
~  feat_ipv6_payload
~  feat_ipv6_transport
~  feat_ipv6_wintap
~  feat_passtos
~  feat_vlan_tagging
~  frp
~  svn-branch/2.1
~  svn-branch/BETA21
~  obsolete/bugfix2.1
~  obsolete/feat_eurephia
~  obsolete/feat_misc

The obsolete/ branches are branches which are now merged into master and th=
ey
will be further developed there.  They are kept as obsolete branches for so=
me
time until their historic value is no longer interesting.

I have also rebuilt  the frp branch.  This one had old cruft and was outdat=
ed.
~ As we have no features in the "Feature Removal Process", I decided to just
start clean on from the master branch.

The experimental branch is also now just a copy of the master branch.  We w=
ill
discuss what more to merge into this branch.

As you also see, the release branch is removed from the testing tree and on=
ly
available in the stable tree.

Both git trees will have release tags for each release we've done.  Those
releases based on the git tree will also be signed tags.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk29pP4ACgkQDC186MBRfrpC9gCghFxLS2bZPW9uDWHSljrWv0zB
QogAoI5jRNXF1O2GW2qJBigeOOVcX22v
=3Dzg1e
-----END PGP SIGNATURE-----

