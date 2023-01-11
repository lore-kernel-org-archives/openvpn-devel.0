Date: Wed, 11 Jan 2023 14:45:19 +0100 (CET)
Message-Id: <202301111345.30BDjJd4076549@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230110170257.113527-1-frank@...2641...>
References: <20230110170257.113527-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: check_engine_keys: make pass
 with OpenSSL 3
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looking more closely I can see that I misread the regex, and it's all
fine indeed.  Passing the test on my test candidates (ossl 1.1.x, 
ossl 3.0.x but no engine support) and also on the GHA actions with
both ossl versions.

Your patch has been applied to the master branch.

commit af25448ee19da5d225a6a1f30f26dc3949ed8921 (master)
commit d09db604dac1e8140c0e4cad73a8b3d2e21cbebc (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Jan 10 18:02:57 2023 +0100

     check_engine_keys: make pass with OpenSSL 3

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230110170257.113527-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25949.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


