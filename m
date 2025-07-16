Date: Wed, 16 Jul 2025 23:02:37 +0200 (CEST)
Message-Id: <202507162102.56GL2bRr043020@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250716165656.18887-1-gert@...1296...>
References: <20250716165656.18887-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: match test
 numbers with server numbers
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
To: sasepp@...2705...
Cc: openvpn-devel@lists.sourceforge.net

Basically just shuffling numbers around, but making future modifications
of the .rc files easier, because it's easier to see which client tests
talks to what server instance.  Thanks.

Buildbot-tested and no fails :-)

Your patch has been applied to the master branch.

commit 31aedd7fbfd9d4856a5ae7085d15228ec57fb2a1
Author: Samuli Seppänen
Date:   Wed Jul 16 18:56:49 2025 +0200

     t_server_null: match test numbers with server numbers

     Signed-off-by: Samuli Seppänen <sasepp@...2705...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250716165656.18887-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32194.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


