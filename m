Message-ID: <4856D294.1060704@...334...>
Date: Mon, 16 Jun 2008 23:52:36 +0300
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,
In light of the Debian OpenSSL vulnerability, I was looking for a way to 
efficiently check for revoked certificates.
Updating CRLs is one way but it's not exactly efficient.

I've found that someone has actually implemented OCSP for OpenVPN[1].
Is there any specific reason that this hasn't been merged?

I saw evidence on the openvpn-devel archives that this was submitted 
almost a year ago but I didn't see any reviews or comments whatsoever.

James, perhaps this should be included in -rc9?

Regards,
Faidon

1: http://www.block64.net/

