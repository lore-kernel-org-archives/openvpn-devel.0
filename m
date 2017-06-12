Date: Mon, 12 Jun 2017 17:08:24 +0200 (CEST)
Message-Id: <201706121508.v5CF8O3o060922@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAO5O-EKCLjPpdKUH6cCoqoZDAfekSafpc7Ga55H2_5Hs4rBopg@...278...>
References: <CAO5O-EKCLjPpdKUH6cCoqoZDAfekSafpc7Ga55H2_5Hs4rBopg@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure option array p[] is
 always NULL-terminated
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
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  I'm not sure if this can ever be exploited (there's enough NULLs 
on the stack to eventually terminate), but it's certainly not looking
healthy.

I've reformatted your commit message & un-wrapped a number of broken long
lines.

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit 8b03d3d9307b407b0da98ebefb052b1fa87aefe7 (master)
commit 110f1e14da97918592a36d4405c807e76d9ad51c (release/2.4)
commit 8ee7fae5f65a2bcce5a4201ddab63d32d9b59a16 (release/2.3)
Author: Guido Vranken
Date:   Thu Jun 8 01:02:38 2017 +0200

     Ensure option array p[] is always NULL-terminated

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAO5O-EKCLjPpdKUH6cCoqoZDAfekSafpc7Ga55H2_5Hs4rBopg@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14757.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


