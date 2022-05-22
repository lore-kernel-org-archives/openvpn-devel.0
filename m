Date: Sun, 22 May 2022 17:35:24 +0200 (CEST)
Message-Id: <202205221535.24MFZO4u015764@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220516104807.2568937-1-arne@...1227...>
References: <20220516104807.2568937-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement ED448 and ED25519
 support in xkey_provider
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

I have only stared a bit at the code, and then run "make check" on 
a FreeBSD / OpenSSL 3.0.3 - which passes, including test_provider
(the t_client check succeeds, but does not excercise this code at all -
so I'm not really testing it).

Uncrustify / pre-applypatch complained about the new ",<blank>" rules
in test_provider.c, so I fixed them :-) - thanks, Frank!

Your patch has been applied to the master branch.

commit c0323aa63d638ee72eb73fcf2a6983b568f952f9
Author: Arne Schwabe
Date:   Mon May 16 12:48:07 2022 +0200

     Implement ED448 and ED25519 support in xkey_provider

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20220516104807.2568937-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24363.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


