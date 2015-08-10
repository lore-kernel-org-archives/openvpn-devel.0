Date: Tue, 11 Aug 2015 01:28:02 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20150810232802.GX3494@...2049...>
References: <20150730233727.GW3676@...2049...>
	<CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

Lev Stipakov, le Fri 31 Jul 2015 11:19:15 +0300, a =E9crit :
> Do you use radius plugin from http://www.nongnu.org/radiusplugin/ ? I
> think the way OpenVPN delegates authentication to a plugin
> (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook) is asynchronous, as well
> as plugin implementation, i. e. OpenVPN does not wait for a response.
> Instead it periodically checks a tmp file to where plugin is supposed
> to write authentication result (1 or 0).

Since I was still getting trafic misses even with acf properly
working, I dug a bit further, and the issue I'm still having is with
accounting. Here is the log I'm having, for instance on a :

Tue Aug 11 00:54:10 2015 RADIUS-PLUGIN: BACKGROUND ACCT: New User.
Tue Aug 11 00:54:10 2015 RADIUS-PLUGIN: BACKGROUND ACCT: New user acct: use=
rname: bla@...1106..., interval: 0, calling station: ::ffff:92.146.150.249,=
 commonname: bla@...1106..., framed ip: 80.67.179.7, framed ipv6: 2001:0910=
:0802:0000:0000:0000:0000:1307.

[during these two seconds, openvpn doesn't trafic any more]

Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND-ACCT:  Get ACCOUNTING_RE=
SPONSE-Packet.
Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND ACCT: Start packet was s=
end.
Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND ACCT: User was added to =
accounting scheduler.
Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND-ACCT:  No routes for use=
r.
Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND-ACCT:  Create IPv6 route=
 string ip -6 route add 2001:910:1307::/48 dev tun2 proto static 2> /dev/nu=
ll dev tun2.
Tue Aug 11 00:54:12 2015 RADIUS-PLUGIN: BACKGROUND-ACCT:  Add route to syst=
em routing table.

[and now trafic passes again]

Looking at the source code in openvpn_plugin_open_v2, I see:

context->acctsocketbackgr.send ( ADD_USER );
...
context->acctsocketbackgr.send ( newuser->getVsaBuf(), newuser->getVsaBufLe=
n() );
//get the response
const int status =3D context->acctsocketbackgr.recvInt();

This is again synchronous code, and this time I don't see any option
to make it asynchronous...  I can see that when accounting fails, an
exception is thrown, to return an error to openvpn and thus prevent
the connection.  I guess this is an important part that shouldn't be
dropped, but I don't see a way to make it asynchronous without modifying
the openvpn core.

In our case we don't actually make use of radius accounting...

Samuel

