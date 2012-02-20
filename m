MIME-Version: 1.0
Date: Tue, 21 Feb 2012 00:00:37 +0800
Message-ID: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
From: Yang Zhe <yangzhe1990@...277...>
Subject: [Openvpn-devel] Better use ip -batch on adding/removing server
	pushed routes on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

It's quite slow to add thousands of routes via execve thousands times.
It's better writing the parameters to a pipe to `ip -batch -` on
linux.

--=20
Sincerely,
=C2=A0 =C2=A0 Yang Zhe

