Content-Class: urn:content-classes:message
MIME-Version: 1.0
Message-ID: <2A6C5A0148EE5B4CBAD6C9BD6F590C48023C57@...330...>
From: "Farid Sarwari" <fsarwari@...329...>
Subject: [Openvpn-devel] One Time Password support
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
Date: Wed Dec 15 16:24:02 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

If one time passwords are used in the authentication is there a way to tell=
 openvpn to renegotiate the SSL but not AUTH to prevent disconnection after=
 every renegotiation?=20

Or is the only way to use One Time Passwords to set --reneg-sec to somethin=
g really high?=20

I use three factor authentication to connect: username, password, Key (from=
 FOB device).=20
Key is appended to the username. Would it be possible to tell openvpn to pr=
ompt once again for a Key?=20

C:\> openvpn home.ovpn
Enter Auth Username: jsmith
Enter Auth Password: *******
Enter Auth Key: 234-2343



