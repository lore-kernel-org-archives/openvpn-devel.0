Date: Tue, 16 Dec 2025 18:22:55 +0100 (CET)
Message-Id: <202512161722.5BGHMtpL010283@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251216144207.12171-1-gert@...1296...>
References: <20251216144207.12171-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change ssl_ctx in struct
 tls_options to be a pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

I'm happy to record the Ack from Max F here - while the changes all look
reasonable, the deep inner workings of the SSL glue is not something I'd
feel comfortable ACKing.  That said, I did put this through the full
client/server test bed (which has lots of client connects, so quite a 
bit of "context activity") and nothing broke - so I guess it's good to
go into RC4, and see more testing there...

Your patch has been applied to the master branch.

commit 44dd39b3ef3980019277e7612fd5bc9cbd4d3e65
Author: Arne Schwabe
Date:   Tue Dec 16 15:42:00 2025 +0100

     Change ssl_ctx in struct tls_options to be a pointer

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1431
     Message-Id: <20251216144207.12171-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35116.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


