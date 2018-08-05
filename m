From: Matthias Andree <matthias.andree@...68...>
Message-ID: <9154b5af-c1f7-1e2a-82e4-fde45e604b2b@...68...>
Date: Mon, 6 Aug 2018 00:24:07 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] FreeBSD -CURRENT (unreleased) issues with TAP known?
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Lars Schotte <lars@...2448...>

[Lars, OpenVPN-devel@ is subscriber-posts-only]


Greetings,

just in case this rings a bell somewhere...

I have received two reports from one FreeBSD-based user (Lars Schotte,
Cc'd) that OpenVPN appears to not work with tap/bridged mode on FreeBSD
-CURRENT, which is slated to become FreeBSD 12.0 later this year, but is
unreleased and not in code freeze yet.

The reports are here and are unanswered to date:

1.
https://lists.freebsd.org/pipermail/freebsd-current/2018-July/070395.html
(initial inquiry)

2.
https://lists.freebsd.org/pipermail/freebsd-current/2018-August/070501.html

2b. https://paste.fedoraproject.org/paste/Hn4M2JqZ~5xccLWOVD1xUw/raw


I am not sure if anyone can make head or tails of them, and it is
possible that there are regressions in FreeBSD's kernel that need to be
repaired before the upcoming release -- and I as the packager of OpenVPN
for FreeBSD have chosen it's too early for me to dig deeply, given that
the OS (FreeBSD-current) is currently still a moving target.

Best regards,

--=20
Matthias Andree



