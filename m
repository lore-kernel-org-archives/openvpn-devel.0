Date: Thu, 28 Feb 2019 18:25:33 +0100 (CET)
Message-Id: <201902281725.x1SHPXJq043376@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1550709982-19319-1-git-send-email-selva.nair@...277...>
References: <1550709982-19319-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Better error message when
 script fails due to script-security setting
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

Thanks.  I have not tested the various error conditions, but the code
makes sense to me and it passes compile and t_client tests (which use
--up here), so it's not breaking stuff in fundamental and non-obvious
ways.

(Since David was mostly happy with the v1 approach except for the
"127" and "switch()", I assume he's totally fine with v2 now :-) )

Your patch has been applied to the master branch - it won't apply to
2.4 as we have no "run_command.*" there yet.  Shall we cherrypick
bf97c00f7dba4 and 253f015558 to get there?  Or do you want to do a
2.4 version of the patch?

commit 01a3c876d4911ff7ea82b04edeb43defdebc69d7 (master)
Author: Selva Nair
Date:   Wed Feb 20 19:46:22 2019 -0500

     Better error message when script fails due to script-security setting

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1550709982-19319-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18223.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


