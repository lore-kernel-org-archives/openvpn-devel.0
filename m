Date: Sat, 26 Feb 2022 11:12:11 +0100 (CET)
Message-Id: <202202261012.21QACBPu018046@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220224172330.43451-1-mohsin92@...1835...>
References: <20220224172330.43451-1-mohsin92@...1835...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore deprecation warning for
 daemon on macOS
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
To: Saifur Rahman Mohsin <mohsin92@...1835...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for your submission.  Indeed, this is the same as Arne sent in
commit a480eaae1d32a6, which was only applied to one of the plugins in
question (plugins/down-root) and not plugins/auth-pam.

Your patch has been applied to the master branch.

commit d5c1ec2913620cec5b453c35d5c851f8c79a7ae1
Author: Saifur Rahman Mohsin via Openvpn-devel
Date:   Thu Feb 24 22:53:30 2022 +0530

     Ignore deprecation warning for daemon() on macOS (plugin/auth-pam)

     Signed-off-by: Saifur Rahman Mohsin <mohsin92@...1835...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220224172330.43451-1-mohsin92@...1835...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23890.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


