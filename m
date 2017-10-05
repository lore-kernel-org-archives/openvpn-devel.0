From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ff439b51-a63e-049c-afc6-56018e3b88b3@...515...>
Date: Thu, 5 Oct 2017 13:35:12 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] How to manage code under the contrib/ directory?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

In yesterday's community meeting we talked a bit about how to best
manage code under contrib/ directory:

<https://github.com/OpenVPN/openvpn/tree/master/contrib>

We agreed that code going there does not necessarily need to go through
our usual pretty strict review process. Accepting things without some
review, however, would definitely bite us back later.

Getting more people involved in maintaining "contrib/" would be good, as
the brain-cycles of the core developers are fairly limited. We discussed
several options for encouraging participation from new people:

1) Allow GitHub pull requests for "contrib/"

This is the least invasive approach. We would document this new policy
in GitHub, Trac and the Git repository. This would lower the barrier for
participation somewhat. Things under "contrib/" would still be
considered "official" OpenVPN code.


2) Move "contrib/" to a separate "openvpn-contrib" Git repository

Everything under "contrib/" would be in a single Git repository. Code in
that repository would be less "official" than for option #1.


3) Create a separate Git repository for each contributed project

In this model each contributed feature would become its own Git
repository. We've split things out of the main repository before and the
results have been a bit mixed. The OpenVPN GUI project has been a big
success with several developers contributing significant amounts of code:

<https://github.com/OpenVPN/openvpn-gui/graphs/contributors>

EasyRSA 3 has been surprisingly successful despite the fact that it has
not yet even become the "official" EasyRSA version:

<https://github.com/OpenVPN/easy-rsa/graphs/contributors>

The openvpn-build cross-compile buildsystem project has been moderately
successful, even though there are only a few regular contributors:

<https://github.com/OpenVPN/openvpn-build/graphs/contributors>

The EasyRSA 2 project could be considered a failure:

<https://github.com/OpenVPN/easy-rsa-old/graphs/contributors>

It was noted in the meeting, however, that EasyRSA 2 is mature and
probably there's not that much need to fix it. This could partly explain
why there have been very few contributions to EasyRSA 2.

---

We do not wish to "drop the ball" on code under "contrib/". We would
also like to avoid the fate of the OpenVPN RADIUS plugin, which has been
forked several times in a row by individuals, leaving users with no idea
of which version is the least buggy one.

Any thoughts on which of these options would be best if the goal is to
encourage participation in developing code under "contrib/"? Are there
other approaches which we have overlooked?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

