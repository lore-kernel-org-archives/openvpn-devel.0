Date: Thu, 03 Sep 2009 10:06:53 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <1C795E2FCD154E46979DDDD5374B5ABE024D96FF@...1261...>
	(from jcullison@...1260... on Wed Sep  2 21:39:52 2009)
Message-Id: <1251990413.20315.4@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
 establish tunnel under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: John Cullison <jcullison@...1260...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/02/2009 09:39:52 PM, John Cullison wrote:

FWIW, I'm not a developer and may or may not have
useful info.  I'm just asking the questions I would
look into.  At some point I'll likely run out of
questions.

  Ping is not a valid test for
> us,
> as at least one of our firewalls blocks ICMP.

You could use a udp ping or something like telnet to port 80
just to keep the complication minimal, but you know your network best.

>=20
> I just ran ipconfig (it's like ifconfig, only for Windows) on my test
> XP
> box before and after the problem occurs, and the Default Gateway has
> indeed gone missing:

The next question is: Is the default gateway being configured
via DHCP options that are coming from OpenVPN or is there some
other reason why the default gateway is altered?  Is it the
local openvpn that's supposed to alter the gateway, the remote
end, or neither?  Your local and remote configs would help here.

>=20
> So I guess I can stop giving my guess as to what's going on and
> declare
> explicitly that something about OpenVPN is clobbering my default
> gateway
> setting when it cannot open a tunnel a second time.

Was there no OpenVPN on the other end both tests?  Does
it take 2 failed connection attempts to exhibit the
problem or just failure when there's no answer?





Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


