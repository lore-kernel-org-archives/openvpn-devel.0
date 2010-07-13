Message-ID: <4C3C2CDA.60409@...1299...>
Date: Tue, 13 Jul 2010 21:07:38 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
Subject: [Openvpn-devel] bug stopping the use of mssfix/fragment in udp+tcp
	configs?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there

I have just looked at the current 2.2 git code and the bug blocking the
use of udp+tcp combination configs when you want to use mssfix/fragment 
is still present. See
https://community.openvpn.net/openvpn/wiki/Topics-2010-04-22 for
references.

By that I mean I cannot use fragment/mssfix even within a udp
"<connection>" profile - as the tcp profiles that follow trigger openvpn
to error.

Is that planned to be fixed? With it, an openvpn config can contain udp,
tcp and tcp-via-auto-proxy "<connection>" profiles - leading to the best
opportunity for openvpn "escaping" from almost any network imaginable -
without user intervention.

Thanks!

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


