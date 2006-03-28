From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c6528a$f79501e0$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <20060327165648.99695.qmail@...593...>
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
Date: Tue Mar 28 09:14:05 2006
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

>-----Original Message-----
>From: openvpn-devel-admin@lists.sourceforge.net
[mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Iftikhar
Qureshi
>Sent: Monday, March 27, 2006 10:57 AM
>To: Dave
>Cc: openvpn-devel@lists.sourceforge.net
>Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
>
>

Iftikhar;

If interested, I just updated the source to correct a bug (previously you
had to specify the dev-node option) and to emulate supporting the nobind
option.  You still have to use the ip-win32 ipapi option.

Also, I have some initial good news.  I have successfully ping'ed the
server-side end of the tunnel.  This means data is flowing through the
driver and protocol stack correctly, from server to openvpn.exe.

I used a very minimal server configuration.  Now I need to figure out how to
set up more options so I probably won't be coding anything for a couple
days.

-Dave


