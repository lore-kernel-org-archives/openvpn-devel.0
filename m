Date: Sun, 27 Apr 2014 15:22:05 +0200 (CEST)
Message-Id: <201404271322.s3RDM5qu017603@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1398588561-18964-1-git-send-email-steffan@...1856...>
References: <1398588561-18964-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make serial env exporting
	consistent amongst OpenSSL and PolarSSL builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Tested both OpenSSL and PolarSSL builds on the server side, and
certificate reporting is consistent, if differing in uppercase/lowercase:

OpenSSL:

tls_serial_0=22
tls_serial_1=13617978572412530086
tls_serial_hex_0=16
tls_serial_hex_1=bc:fc:c7:5c:47:87:ad:a6

PolarSSL:

tls_serial_0=22
tls_serial_1=13617978572412530086
tls_serial_hex_0=16
tls_serial_hex_1=BC:FC:C7:5C:47:87:AD:A6

(I'm too lazy right now to actually multiply out whether the hex 
representation of cert 1 matches the decimal representation, but if
both libraries return the same thing, that is good enough for me)


Your patch has been applied to the master branch ONLY, as it doesn't
work with PolarSSL 1.2 (no "x509_crt" type there) - so 2.3.x still has
inconsistency here.

commit f80a52b09eed8e5e0cad990c56ec99256d6cc2d0 (master)

Author: Steffan Karger
Date:   Sun Apr 27 10:49:20 2014 +0200

     Make serial env exporting consistent amongst OpenSSL and PolarSSL builds.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1398588561-18964-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8649
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


