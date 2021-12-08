Date: Wed, 8 Dec 2021 16:22:00 +0100 (CET)
Message-Id: <202112081522.1B8FM0va001320@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211208144101.19166-1-maximilian.fillinger@...2507...>
References: <20211208144101.19166-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Define have_blowfish variable
 in ncp unit tests
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for quickly fixing my oversight :-) - and yes, *this* time, I
have actually tested the resulting build.  Both with openssl and mbed.

Your patch has been applied to the release/2.5 branch.

commit 39f50f58b73333b73502a593c4beda3af947bcac (release/2.5)
Author: Max Fillinger
Date:   Wed Dec 8 15:41:01 2021 +0100

     Define have_blowfish variable in ncp unit tests

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211208144101.19166-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23356.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


