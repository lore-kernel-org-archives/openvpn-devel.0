content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Openvpn-devel] Multi-user openvpn
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF01D2DE57@...10...>
From: "Jean-Eric Cuendet" <Jean-Eric.Cuendet@...8...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Apr 18 01:25:03 2002
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...3...>, openvpn-devel@lists.sourceforge.net

>One other thing that would be cool, would be a flag to let openvpn
accept a connection within a certain amount of time and shutdown after
that.

The inactivity disconnect should handle that case.

If you start an openvpn session with --inactive 300, and the peer never
connects, the session will exit in 5 minutes.

Yes, that would work.
But the typical usage would be:
- Shutdown after 30 seconds if no connection
- Shutdown after 60-120 minutes if no network activity (after connection
was successful)

But inact timeout would be sufficient for our basic needs.
-jec




