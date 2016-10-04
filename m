From: Gert Doering <gert@...1296...>
Date: Tue,  4 Oct 2016 14:22:11 +0200
Message-Id: <20161004122211.89657-1-gert@...1296...>
In-Reply-To: <20161004113854.42470-1-gert@...1296...>
References: <20161004113854.42470-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] add POSTINIT_CMD_suf to
	t_client.sh and sample config
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
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the following branches

commit bae1ad7005fd9a1fadeed56370a9ac5422a33fee  (master)
commit 7891c8ce93b33749ee75ab579aa391bc5eab6e2f  (release/2.3)
Author: Gert Doering
Date:   Tue Oct 4 13:38:54 2016 +0200

     add POSTINIT_CMD_suf to t_client.sh and sample config

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20161004113854.42470-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12594.html
     Signed-off-by: Gert Doering <gert@...1296...>


Also(!), I had to cherry-pick 8fedf86abaf8fca8d0e9e81f70d7a5888a98b9ee
into 2.3 as 6ac1cf103e77b0d2aa3360c4373099bf4d9f1919:

commit 6ac1cf103e77b0d2aa3360c4373099bf4d9f1919
Author: David Sommerseth <davids@...1347...>
Date:   Sat Nov 16 16:17:54 2013 +0100

    t_client.sh: Add prepare/cleanup possibilties for each test case
    
    By adding PREPARE_$NUM and CLEANUP_$NUM variables containing command lines
    to execute before and after the test case is run.
    

otherwise, this patch did not apply - and it doesn't really make sense
to have only the POSTINIT_CMD_ and not PREPARE/CLEANUP.  Tested :-)
--
kind regards,

Gert Doering


