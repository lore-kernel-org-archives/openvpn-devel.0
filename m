From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] man page --client-config-dir hint
In-Reply-To: <435BDF68.6000800@...480...>
Message-ID: <Pine.LNX.4.58.0510241228170.8183@...41...>
References: <435BDF68.6000800@...480...>
MIME-Version: 1.0
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
Date: Mon Oct 24 11:40:04 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Andreas Gaufer <Andreas.Gaufer@...480...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 23 Oct 2005, Andreas Gaufer wrote:

> Hi,
>=20
> my deep respect for this beautiful peace of software. It helps a lot=20
> every day.
>=20
> I was a little astonished because client-configuration-directory files=20
> seemed to be not re-read on
> client connect.
>
> I learned from the source that the responsible function only runs on=20
> session-init and not on
> session-move.

This is by design for UDP-based configurations, since UDP is
connectionless and we therefore need to distinguish between a "new"
connection and a merely "renegotiated" session.  The client-config-dir
file is only read on a new connection.

What you can do however, to help OpenVPN know when a client is
disconnecting, is to use --explicit-exit-notify.  This will immediately
clear out the client instance object on the server, rather than passively
letting it time out over n minutes.  Now, new connections will result in a
new initialization of the client instance object on the server, and
therefore cause a re-read of the client-config-dir file.

You can also try --nobind on the client.  This will cause the reconnection=
=20
to be on a new port #, which will give a hint to OpenVPN that this is a=20
new connection and not merely the continuation of an older connection.

> I did=EF=BF=BDt expect this from reading the man page.  The patch=20
> attached introduces a hint
> which could save other users a little time. I would be honored if you=20
> consider including it.

The problem is that if we start talking about session "init" vs. "move",=20
then we need to define what we mean by each to avoid confusion.

It might be more instructive to document the concept of a client instance=20
object on the server, and the different ways in which this object can be=20
created or destroyed.

James


