Date: Sat, 30 Jan 2021 10:53:07 +0100 (CET)
Message-Id: <202101300953.10U9r770087808@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1611778909-20630-2-git-send-email-gcox@...1057...>
References: <1611778909-20630-2-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH applied] Re: More explicit versioning
 compatibility in sample-plugins/defer/simple.c
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
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.5 and release/2.4 branch.

Again, I have not tested beyond a test compile (but it looks good).

As a side note: my change to change the required v3structver to "5"
was too restrictive - there was a bit of confusion what got added when, and I 
thought this was necessary for logging.  But it isn't, "5" is "with base64", 
and "4" is "with secure_memzero()" - which we wanted for plugin-auth-pam,
and my code was copy-pasted from there...  according to openvpn-plugin.h,
logging has been there from "v3 api structver v1".

I do not think it's needed to fix that as 2.4, 2.5 and master all have "v5" 
and people really should not code new plugins on 2.3 or older openvpn 
deployments...

commit a385a3e8a28f2ce96c7ee0be8940b257765add5a (master)
commit ae5ca3ebf1cccae2f2d11a2ed6219c40be9cc4ea (release/2.5)
commit 86c674230d6334c1aa18f74acc7a9741a6c9683a (release/2.4)
Author: Greg Cox
Date:   Wed Jan 27 20:21:49 2021 +0000

     More explicit versioning compatibility in sample-plugins/defer/simple.c

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1611778909-20630-2-git-send-email-gcox@...1057...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21508.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


