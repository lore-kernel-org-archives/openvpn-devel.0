Date: Wed, 8 Aug 2018 09:41:59 +0200 (CEST)
Message-Id: <201808080741.w787fxTh020188@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1533696271-21799-2-git-send-email-selva.nair@...277...>
References: <1533696271-21799-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Accept empty password and/or
 response in auth-pam plugin
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

Acked-by: Gert Doering <gert@...1296...>

Looks good and passes my use case ("PIN set, OTP empty").  So it was
not a bug in the openvpn client at all, I just misread the logs.

Since I join PIN+OTP into one string passed to PAM anyway, I also tested
"PIN empty, OTP set" and that works just as well.  Thanks.

Your patch has been applied to the master branch.

commit 7a8109023f4c345fe12f23421c5fa7e88e1ea85b
Author: Selva Nair
Date:   Tue Aug 7 22:44:31 2018 -0400

     Accept empty password and/or response in auth-pam plugin

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1533696271-21799-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17382.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


