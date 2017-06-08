Date: Thu, 8 Jun 2017 21:24:34 +0200 (CEST)
Message-Id: <201706081924.v58JOYX5011601@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAO5O-ELXwXgGtRFou=FY1TAhW4W4BHPZF4=rqSY877njtXNMJg@...278...>
References: <CAO5O-ELXwXgGtRFou=FY1TAhW4W4BHPZF4=rqSY877njtXNMJg@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: refactor my_strupr
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

ACK, thanks.

Your patch has been applied to the master, release/2.4 and release/2.3 
branch (needed some manual work).

I have changed the commit message to be friendlier to "git shortlog" -
please do not make the first line of the commit message longer than
about 60-70 characters, and then include a blank line.  Your original
commit message would show up "in full" in git shortlog, which makes it 
much less "short"...  (the message is still as you put it, I just moved
it into the "not first line" block, and wrapped the lines to ~70 chars)

commit 69162924de3600bfe8ae9708a1d6e3f4515ef995 (master)
commit 69f00d8ce6862772919e2714adb72f13f3e92ca7 (release/2.4)
commit 8dd598e89f25074f2d4d23f77cb601cf48a810e3 (release/2.3)

Author: Guido Vranken
Date:   Thu Jun 8 00:44:15 2017 +0200

     refactor my_strupr

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAO5O-ELXwXgGtRFou=FY1TAhW4W4BHPZF4=rqSY877njtXNMJg@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14756.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


