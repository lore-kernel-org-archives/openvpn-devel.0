References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
 <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
 <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
From: Bernhard Schmidt <berni@...376...>
Message-ID: <dfb116ab-cde6-1269-ff14-a11c2e1111fb@...376...>
Date: Fri, 4 Jan 2019 18:32:22 +0100
MIME-Version: 1.0
In-Reply-To: <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
Content-Language: de-LU
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn@...2080...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Am 04.01.19 um 17:25 schrieb David Sommerseth:

Hi everyone,

> Okay, I was a bit unclear.  The approach used with openvpn.service and
> openvpn@...1685... are broken by (Debian) design.  Quite many users have
> reported that these service files does not work at all.  But I'll admit, =
I'm
> not really up-to-date if these service files have been updated by
> distro-packagers later on.

(One of the) Debian OpenVPN maintainer here. I'd like to get some input
about the perceived brokenness of the openvpn@...1685... in Debian. Freeze
is coming up, but we still have time to fix issues if they arise. I'm
not aware of any major bugs reported for this.

First of all, we ship both openvpn@...1685... (which is maintained in
Debian) and openvpn-client@...1685... and openvpn-server@...1685... from the
upstream sources. As a user of our package you are very much free (and
encouraged) to work with OpenVPN in the officially documented way.

openvpn@...1685... mostly comes from a compatibility layer. Since years in
Debian you could drop a .conf into /etc/openvpn and had it executed at
startup (controlled by a variable in /etc/default/openvpn). This is
pretty much remodeled by the use of a custom generator, see
https://sources.debian.org/src/openvpn/2.4.6-1/debian/openvpn-generator/
. openvpn.service just binds these instances together to allow for a
service openvpn restart to work. And I currently don't see a compelling
reason to drop this, since it allows upgrading users to keep working).

Since the .conf files are not split between client and server we have to
use one openvpn@...1685... that can accomodate both. But I really fail to
see the problem here. openvpn@...1685... and openvpn-server@...1685... are
not that much different. We do use systemd readyness notification, the
capability bounding set is the same (for server), the ExecStart line is
similar, we do restart on error.

openvpn@...1685...
ExecStart=3D/usr/sbin/openvpn --daemon ovpn-%i --status
/run/openvpn/%i.status 10 --cd /etc/openvpn --config
/etc/openvpn/%i.conf --writepid /run/openvpn/%i.pid

openvpn-server@...1685...
ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log
--status-version 2 --suppress-timestamps --config %i.conf

-client.service is a bit more restricted and uses --nobind and no status
file, but that's about it.

Bernhard

