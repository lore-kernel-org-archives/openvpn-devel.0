Date: Thu, 11 Jan 2018 12:49:08 +0100 (CET)
Message-Id: <201801111149.w0BBn8aN001981@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1515573259-20968-1-git-send-email-steffan.karger@...1435...>
References: <1515573259-20968-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix types around
 buffer_list_push(_data)
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

.. because it gets rid of lots of extra casts that are only there because
the base types have been wrong, and people added casts to make compilers
happy...  (my favourite gripe).

Your patch has been applied to the master and release/2.4 branch.

commit b395f36e578b2def9da8e9347c0afa79814c0c7d (master)
commit c4c7f9208057ee6551d37c0bdab3896f1f549ce1 (release/2.4)
Author: Steffan Karger
Date:   Wed Jan 10 09:34:19 2018 +0100

     Fix types around buffer_list_push(_data)

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1515573259-20968-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16186.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


