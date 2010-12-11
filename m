Message-ID: <4D036D80.20409@...1114...>
Date: Sat, 11 Dec 2010 13:24:32 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Feature branch drop warning - --passtos and VLAN
	patch set
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Davide Guerri <dguerri@...384...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 23:07, David Sommerseth wrote:
| From: Davide Guerri<dguerri@...384...>
|
| This patch makes it possible to use the --passtos option with 802.1Q tagged
| ethernet frames.
|
| sf.net tracker:
|
<https://sourceforge.net/tracker/?func=detail&aid=2829878&group_id=48978&atid=454721>
|
| Signed-off-by: David Sommerseth<dazo@...384...>
| ---
|   proto.c |   14 +++++++++++---
|   proto.h |   12 ++++++++++++
|   2 files changed, 23 insertions(+), 3 deletions(-)

This patch has been laying around in a separate feature branch for about 40
weeks without any responses at all.  We have asked for help to test this feature:

<http://thread.gmane.org/gmane.network.openvpn.devel/3365>
<http://thread.gmane.org/gmane.network.openvpn.devel/3165/focus=3306>

Due to this lack of response, I am considering to drop that feature branch.

Unfortunately, this will result in some consequences for another patch-set,
which we also don't know too much about in regards to testing, VLAN support
patches from Fabian Knittel.

<http://thread.gmane.org/gmane.network.openvpn.devel/3645>

IIRC, this VLAN patch set depends on parts of the infrastructure for --passtos.

I personally see the a broader use case for the VLAN patches, and I would
*not* like to throw out the VLAN patches in addition.  So I therefore see just
a few solutions.  I would like to see the VLAN patches go into OpenVPN 2.3.

*a)* --passtos gets serious testing with responses *back to the mailing list*.
We need to know if this patch has any side-effects to users who do not use
this feature.  It needs to be validated that the patch itself does work properly.

Testing instructions are available here:
<http://www.secure-computing.net/wiki/index.php/OpenVPN/802.1Q_--passtos_patch>

*b)* Fabian Knittel embraces the pieces he needs from the --passtos patch to
his VLAN patches, thus becoming independent of --passtos.  This might require
some restructuring of Fabians feature branch and replacing the current one
with a new feat_vlan_tagging branch.

Fabian: Can you please also provide us with some testing instructions?
Including how to set it up and how to validate things works.  And also here we
need to test that this works for both users enabling and not enabling this
feature.

*c)* To drop --passtos and the VLAN patches completely.  This is the choice I
really want to try to avoid.


I would really like to have this solved before *mid January* - which means
approx. 5-6 weeks.  If silence continues to rule, I am forced to kick them out
- - as these patches are based on an older 2.1 release and we are planning a 2.2
release in January.

*If* we get these features tested and confirmed, these patches will be
considered for the OpenVPN 2.3 release.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0DbYAACgkQDC186MBRfrrFDQCfTZr1rzoGE8CeBhWcMfEEK/HP
AMsAn2eRm7pgf0w60tpjweA6XQ5uBtbf
=YI92
-----END PGP SIGNATURE-----

