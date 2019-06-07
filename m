From: Matthias Andree <matthias.andree@...68...>
Message-ID: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>
Date: Fri, 7 Jun 2019 20:26:02 +0200
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] RFC: release/2.4 (OpenVPN 2.4.7) patch for building
 with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Luca Pizzamiglio <pizzamig@...1249...>

Greetings,

FreeBSD has received a patch contribution to enable OpenVPN 2.4.x to be
built with LibreSSL. I'm seeking comments, and yes I am aware of
master's a47508606be2c6359d4b27c3b65b72dfe4786222 commit description
that claims LibreSSL isn't in the best shape for TLS 1.3.

<https://bz-attachments.freebsd.org/attachment.cgi?id=204874>

<https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=238382>

Comments?

Best regards,
Matthias


