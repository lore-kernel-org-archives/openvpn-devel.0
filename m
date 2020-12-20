Date: Sun, 20 Dec 2020 11:54:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201220105430.GP976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IX80i0K4YGogjf0Q"
Content-Disposition: inline
Subject: [Openvpn-devel] wanted: mechanism to send text messages to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--IX80i0K4YGogjf0Q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I find myself looking for a mechanism by which I could send informational
messages ("your cert expires in two weeks, go refresh!" - "your openvpn
client needs an upgrade") from the openvpn server to incoming clients.

Of course this should work with all connecting clients, that is, "text
clients", windows GUI, Tunnelblick, iOS Connect, Android.

As far as I am aware, there is no such mechanism today.

Do we want to make one?

--IX80i0K4YGogjf0Q--
