Date: Sat, 7 Jan 2023 18:55:31 +0100 (CET)
Message-Id: <202301071755.307HtVP7069871@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230103202330.1835-3-a@...2181...>
References: <20230103202330.1835-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: improve comment about
 hidden debug message
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

Not sure about the message rewording ("I can understand both variants
just fine"), but - as discussed - the comment is helpful for readers
foreign to these code paths.

Not tested beyond "does it compile?" - trivial enough.

Your patch has been applied to the master and release/2.6 branch.

commit b20daf274304ee30daa839910e633c96307a4744 (master)
commit fce1e72f18aea303056967f6a2e6be9324a9ca4e (release/2.6)
Author: Antonio Quartulli
Date:   Tue Jan 3 21:23:30 2023 +0100

     dco: improve comment about hidden debug message

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230103202330.1835-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25883.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


