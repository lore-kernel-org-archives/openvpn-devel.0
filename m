Message-ID: <1090328908.40fd194cddc1b@...256...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: [Openvpn-devel] develop extended authentication
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jul 20 06:09:06 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

I'm actually doing a training in a company looking at openvpn for vpn ssl use.

But there're actually several not_yet_developped features which are necessary
for the usage we want to do of openvpn.

We are satisfied of openvpn certificate handling, but we use them only to
authenticate a computer and not the user behind the screen, so the first thing
we would like to develop is extended authentication like a couple of login/password.
But in this aim, we would like to get these authentication data via a LDAP
directory which regroup all users/groups authentication data.

And, for now, our final requirement is network ACL support for those
users/groups: if 'this' user connect to the vpn, so he's allowed to use this
subnet and this subnet, but not all others. those info would be stored in the
LDAP dir and apply by a iptables-like firewall located on the openvpn server. I
think this could be achieve by executing a sh/perl script requiring just the
username and getting directly ACL in the LDAP dir. So no real FW should be
include into openvpn.

I'm *very* conscient these features are really hard work to do because they ask
me to add them to openvpn. So my questions are:
- what do you think about those features?
- because I'm not yet a good coder, is there people availables to help to begin
make a patch for openvpn?
- you great developpers of openvpn, are there some start point to understand
before trying to 'hack' openvpn?

To the question 'GPL?' I answer 'SURE' because my company and I love free software.

I understand all of this represent really hard work, but I've to do it, so I ask
your help :-)

Didier

ps: and sorry for my horrible english :-/

