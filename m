Date: Thu, 7 May 2020 20:46:19 +0200 (CEST)
Message-Id: <202005071846.047IkJmx037576@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200507135909.21227-1-a@...2181...>
References: <20200507135909.21227-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: convert *_inline attributes to
 bool
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have diffed v9 and v11, and the only change is the unit test related
stuff.  Unit tests pass with this version, so I assume it's good :-)

I take the ACK from Arne for v9 (because the main code change is the
same).

Client-tested on Linux and FreeBSD, though only with a very simple
inline config (key/ca/cert only) :-)  (trusting Arne's tests here).

Your patch has been applied to the master branch.

As a side note: this will be a major source of conflicts for everything
related to option.c being backported to 2.4...  so "shortly before 2.5"
is actually a good point to merge this.  To merge it to 2.4 is no-go,
way too intrusive and really "cleanup and refactoring", not bugfix / 
long-term compat stuff.


commit cb2e9218f2bc73fa22da1f6e850e5fe97f689730
Author: Antonio Quartulli
Date:   Thu May 7 15:59:09 2020 +0200

     convert *_inline attributes to bool

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200507135909.21227-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19854.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


