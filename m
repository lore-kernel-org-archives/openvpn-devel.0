Date: Thu, 18 May 2017 14:38:34 +0200 (CEST)
Message-Id: <201705181238.v4ICcYdE084386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
References: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid a 1 byte overcopy in
	x509_get_subject (ssl_verify_openssl.c)
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
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.3 branch.

commit 04c84548c2e1f3ef55b6737b454ba5b4d903b319 (release/2.3)
Author: Guido Vranken
Date:   Sat May 13 12:37:50 2017 +0200

     Avoid a 1 byte overcopy in x509_get_subject (ssl_verify_openssl.c)

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14649.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


