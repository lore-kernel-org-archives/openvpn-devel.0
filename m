Date: Thu, 5 May 2016 12:57:50 +0200 (CEST)
Message-Id: <201605051057.u45Avonb081315@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1462306478-21059-1-git-send-email-steffan@...1856...>
References: <1462306478-21059-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: improve error
	reporting in tls verify callback
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

Your patch has been applied to the master branch.

ACK from me as well, as it nicely shows the problem with our test certs
in the logs now....

Thu May  5 12:53:54 2016 VERIFY ERROR: depth=0, subject=C=US, ST=California, L=P
leasanton, O=OpenVPN community project, CN=server, emailAddress=samuli@...2134...
et: The certificate is signed with an unacceptable key (eg bad curve, RSA too sh
ort).

commit 524999ab35c79f0d9732647756ad6e4d4e11d73d
Author: Steffan Karger
Date:   Tue May 3 22:14:38 2016 +0200

     mbedtls: improve error reporting in tls verify callback

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1462306478-21059-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11594
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


