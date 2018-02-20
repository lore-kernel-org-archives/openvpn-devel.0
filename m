Date: Tue, 20 Feb 2018 11:30:35 +0100 (CET)
Message-Id: <201802201030.w1KAUZKR065496@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516909513-31683-1-git-send-email-selva.nair@...277...>
References: <1516909513-31683-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow external EC key through
 --management-external-key
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I have not done any real review on it, except "compile test" and "stare
a bit at the code for really obvious issues" - trusting Arne since his
GUI seems to be the only thing really using it today, so if he's happy,
I am as well)

commit 7eca140c70ff76177371dc94c19aeb8644c2c3b5
Author: Selva Nair
Date:   Thu Jan 25 14:45:13 2018 -0500

     Allow external EC key through --management-external-key

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1516909513-31683-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16365.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


