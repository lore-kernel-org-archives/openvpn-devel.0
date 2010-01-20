Message-ID: <4B570C63.1050808@...515...>
Date: Wed, 20 Jan 2010 16:00:03 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN core development processes?
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

Hi,

In the first development model we discussed our development processes in
some length. To get some idea how other security-oriented projects
handle their development, I took a look at two - OpenSSL and
IPsec-tools. The idea was to see if we can learn something from them. I
think the most important development processes in any OSS project are:

1) Getting code into main development tree
2) Reporting bugs (and managing bug reports)

OpenSSL (http://www.openssl.org/about) handles patches and bugs using
mailing lists and a bug tracker. These are at least partially integrated
together. There is a relatively small group, 10 people, who have made
1000-21000 commits to the CVS. Only part of this group is currently
active. Testing branches are sometimes used when testing new features.
There are also several stable branches in addition to the main
development branch (HEAD). The rest of the developer community needs to
send patches (bug fixes, new features) to the "openssl-bugs" mailing
list. Sensitive bug reports are sent to a private list,
openssl-security. The usefulness of new features is discussed on the
"openssl-dev" list. Core developers act as gatekeepers making sure that
poor quality code does not end up in the repository. Read-only CVS
access is available, as well as daily snapshots.

IPsec tools (http://ipsec-tools.sourceforge.net) is a much smaller
project and has only 4 core developers with 200-1600 commits. Some of
these are not currently active. There are no "experimental" or
"unstable" branches for testing purposes. Bugs reports and patches are
handled with Trac (https://trac.ipsec-tools.net/report). It is also
possible to use the mailing lists for this purpose as well as for
generic development discussions. Similarly to OpenSSL, there's a special
private mailing list for reporting security problems. As with OpenSSL,
the small group of core developers act as gatekeepers. Read-only CVS
access is available.

I think we could use similar approaches in our development. For example,
the idea of being able to track bugs and patches simultaneously with a
tracker (e.g. Trac) and mailinglists is definitely good. Also having a
private mailing list for reporting security problems makes sense. I
think at the beginning James needs to continue being the "gateway" to
the main line of development. Later on a few others should be given the
core developer status with commit access. So something like this at first:

http://users.utu.fi/sjsepp/openvpn/process_contributing_to_openvpn.png

... and later this:

http://users.utu.fi/sjsepp/openvpn/process_contributing_to_openvpn_2.png

The second process avoids unnecessary bottlenecks. Perhaps we could also
have separate "experimental", "unstable" or "feature-testing" trees
maintained by other people. The code from these would then flow into the
main development tree. I believe these trees could we managed with Git
even if the main development branch is in SVN.

Any thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


