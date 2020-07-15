Date: Wed, 15 Jul 2020 15:48:59 +0200 (CEST)
Message-Id: <202007151348.06FDmx2o069080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-10-arne@...1227...>
References: <20200711093655.23686-10-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Move adding
 inotify watch into its own function
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I have merged this out of sequence while we still haggle about
the least ugly way for 08 :-) - it's really "just moving this
code parts", but due to the reformatting and variable renaming
git can't see it.  Compared manually.  Also applied the typo
and grammar changes from tincantech to the commit message)

commit 708d1694c7878c6c538c4ab0961eaaa36c007fd0
Author: Arne Schwabe
Date:   Sat Jul 11 11:36:51 2020 +0200

     client-connect: Move adding inotify watch into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200711093655.23686-10-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20284.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


