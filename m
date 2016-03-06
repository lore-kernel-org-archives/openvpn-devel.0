Date: Sun, 6 Mar 2016 10:31:16 +0100 (CET)
Message-Id: <201603060931.u269VG0n045886@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1457241722-23433-1-git-send-email-selva.nair@...277...>
References: <1457241722-23433-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use appropriate buffer size for
	WideCharToMultiByte output in interactive.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

ACK.

https://msdn.microsoft.com/en-us/library/windows/desktop/dd374130(v=vs.85).aspx
explains about WideCharToMultiByte() usage with cbMultiByte==0.

I'm not sure if I understand in which scenarios data is fed to the
nascent openvpn.exe on stdin - buf if done at all, we should better do
it right :-) - I do wonder, though, if WriteFile() could block here, 
leading to a dead worker thread...  all other pipe operations seem to
go through AsyncPipeOp() - but that is orthogonal to this fix)

Your patch has been applied to the master branch.

commit 3654d953eb0bf40fb8c9e1fbaa3de1dd898dcbab
Author: Selva Nair
Date:   Sun Mar 6 00:22:02 2016 -0500

     Use appropriate buffer size for WideCharToMultiByte output in interactive.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1457241722-23433-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11318
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


