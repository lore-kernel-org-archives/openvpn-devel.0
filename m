Date: Wed, 4 Mar 2026 12:58:08 +0100 (CET)
Message-Id: <202603041158.624Bw8vS058351@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304105007.14485-1-gert@...1296...>
References: <20260304105007.14485-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Clarify usage of
 char_class
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

Easy and straightforward enough, plus extra documentation :-)

I have not tested this beyond BB, but given the nature of the change
and that all these casts have been (implicitly) there already, I do not
expect surprises.  Nightly t_server tests will complain if I'm wrong.

Your patch has been applied to the master branch.

commit 9735675529450467ff5ad5e6500caef4d225b17b
Author: Frank Lichtenheld
Date:   Wed Mar 4 11:50:01 2026 +0100

     buffer: Clarify usage of char_class

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1142
     Message-Id: <20260304105007.14485-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35867.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


