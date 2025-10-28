Date: Tue, 28 Oct 2025 18:32:55 +0100 (CET)
Message-Id: <202510281732.59SHWtP9018754@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
Subject: [Openvpn-devel] [PATCH applied] Re: tcp: apply CLOEXEC to accepted
 socket, not listener
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
To: Joshua Rogers <MegaManSec@...2243...>
Cc: openvpn-devel@lists.sourceforge.net

So, this took a bit - the change itself seems trivially correct, but
after Arne's comment about "make sure that this does not break the
port share proxy" I needed to test this in more detail - and I can
confirm that it still works.

I have no real idea how the PS proxy works, but there is "a socketpair()
between openvpn/main and ps proxy process" and "event stuff" involved. 
It certainly doesn't fork() for each individual TCP connect.  What strace
suggests to me is "openvpn sends the original TCP data stream to the
PS proxy, and the responses go back via PS proxy -> openvpn main -> client",
so that wouldn't need to see the freshly accept()ed socket ever.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit c0d96fd8732bd903ab390bb5047a13880cdcac9b (master)
commit 2aa8550d44440a039da509a7afebfeacf0886a32 (release/2.6)
Author: Joshua Rogers
Date:   Wed Oct 22 01:20:52 2025 +0800

     tcp: apply CLOEXEC to accepted socket, not listener

     Signed-off-by: Joshua Rogers <MegaManSec@...2243...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33823.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


