Date: Sun, 22 Oct 2023 13:10:23 +0200 (CEST)
Message-Id: <202310221110.39MBANnu060802@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231022105919.21779-1-gert@...1296...>
References: <20231022105919.21779-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools/gerrit-send-mail.py:
 tool to send Gerrit patchsets to Patchwork
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

Tested this on the last few gerrit-reviewed patches, and it does a good
job in "ensure that the mailing list archive has all to-be-committed patches,
and the information who reviewed and ACKed it, and where the gerrit info
can be found".  So, works for me and Frank, and for anyone else interested,
here it is...

Could it be optimized, like, "put a v5 right in the [PATCH] line"?  Yes,
of course :-) - but it's a good start.

Your patch has been applied to the master branch.

commit c827f9d83a7246971f435d0053b0252e49770f11 (master)
Author: Frank Lichtenheld
Date:   Sun Oct 22 12:59:19 2023 +0200

     dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patchwork

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231022105919.21779-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27279.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


