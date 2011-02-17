Message-ID: <4D5CE662.8040903@...515...>
Date: Thu, 17 Feb 2011 11:12:02 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Splitting the ACK/NACK system into two?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Lately I've been thinking of ways to improve our ACK/NACK system so that
patches could get merged _or_ rejected faster. There have some cases
where no clear resolution has been reached, one example being the
floating-tls patch[1]. The way I see it, whether a patch should be
merged into OpenVPN depends on two factors:

a) Does it make sense (feature-vise) to include the patch in OpenVPN?
b) Is the patch of good quality / does it follow our coding conventions?

Of these a) should be the primary consideration, after which b) can be
looked into. In some cases determining a) is trivial, e.g. if the patch
fixes a bug. Similarly, determining b) should be easy most of the time.
Only patches which add, modify or remove features may require in-depth
discussion on b). Although all of this is obvious, I've noted that very
few non-developers have participated in the ACK/NACK system, even they
would be perfectly capable of handling a). A good example is the DHCP
filtering patch[2]. Therefore, I propose the following formal
modification to the ACK/NACK system:

- anybody can give a "Feature ACK/NACK" (a) for any given patch; or, in
other words saying "this patch is worth/not worth including"
- once (a) is given, a developer can give "Code ACK/NACK" (b), which
will result in merging the patch or in request to modify the patch

To avoid adding extra layer of bureaucracy both ACKs (a+b) could be
given by the same person. I believe this approach would give us several
benefits:

- allow more people to participate in the ACK/NACK work
- reduce workload of the developers (due to ^^^)
- help focus on a) before b)
- allow quicker rejection of "this does not make sense" type patches
- allow sharing responsibility in giving an ACK (e.g. if developer can't
give a "Feature ACK", but can still give a "Code ACK")

Any thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/4213>
<http://thread.gmane.org/gmane.network.openvpn.devel/4378>
<http://article.gmane.org/gmane.network.openvpn.devel/4221>

[2] <https://forums.openvpn.net/topic7479.html>


