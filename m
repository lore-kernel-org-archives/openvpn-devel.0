Date: Mon, 17 Jul 2023 19:25:05 +0200 (CEST)
Message-Id: <202307171725.36HHP5E1092102@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230712095412.570106-1-arne@...1227...>
References: <20230712095412.570106-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mock openvpn_exece on win32
 also for test_tls_crypt
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

As requested, merged BEFORE that other thing, whatever it is, I'll find
out :-)

I had some confusion about this patch at first ("why is it moving that
single function into a new file") and then I saw that it's being linked
to two different test drivers now.  So, makes sense.

Tested by pushing to GHA and having the windows + linux builders see if
they are happy with it...

Your patch has been applied to the master branch.

release/2.6 will see this as part of the grand unified cmake patch, I think.

commit ede590e57c96c2b16d9bf462c4b1dd967b37c432 (master)
Author: Arne Schwabe
Date:   Wed Jul 12 11:54:12 2023 +0200

     Mock openvpn_exece on win32 also for test_tls_crypt

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230712095412.570106-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26849.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


