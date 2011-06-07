From: Russell Morris <openvpn@...1315...>
Date: Tue, 07 Jun 2011 16:31:09 -0500
Message-id: <1307482269235447500@...1315...>
MIME-version: 1.0
Subject: [Openvpn-devel] Application Questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Hi,

I am trying to use an external (GUI) to control OpenVPN ... and a few quest=
ions as a result. If you have any thoughts about these items your comments =
would be greatly appreciated!
- why is the management interface not available until a connection to a rem=
ote server is initiated (and first contact proceeding)? Why not bring this =
interface up immediately, and perhaps limit commands that are available (un=
til a "full" connection is made)?
- why does OpenVPN not support / provide exit codes (e.g. a particular exit=
 code to indicate that no available TAP adapters are available)?
- can OpenVPN use machine / domain login information to authenticate with a=
 proxy server (i.e. to send for NTLM authentication)? Web browsers seem to =
provide this, so I assume that it's possible.
- has anyone observed a "dead" connection (meaning that OpenVPN connects, b=
ut cannot pass traffic over the link ... but then is fine if run again)?

Thanks!

... Russell

