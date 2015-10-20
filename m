Message-ID: <562636A3.1050100@...1147...>
Date: Tue, 20 Oct 2015 14:42:11 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Interesting link related to OpenVPN on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

just read this post:
http://www.theregister.co.uk/2015/10/19/microsoft_openssh_code_release/

Here's Redmond's rough road map for the OpenSSH port:

         Update NoMachine port to OpenSSH 7.1 [Done]
         Leverage Windows crypto api=E2=80=99s instead of OpenSSL/LibreSSL =
and=20
run as Windows Service


[...]
esp the second bullet is interesting - if Microsoft created an=20
(opensource) patch for OpenSSH to use Windows crypto api's then we can=20
leverage this for OpenVPN-on-Windows as well.

share and enjoy,

JJK


