Date: Tue, 4 Aug 2020 21:32:13 +0200 (CEST)
Message-Id: <202008041932.074JWDWI064009@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200720142703.3324-1-arne@...1227...>
References: <20200720142703.3324-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Add
 documentation for the deferred client connect feature
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

Acked-by: Gert Doering <gert@...1296...>

The code is long in.  I thought I'd see some review by "not me"
on the docs, but since the 2.5_beta1 cutoff date is coming soon,
I just did this now.  Included all the latest suggestions from
Richard as well.

I have reworded the "script-options.rst" section somewhat, because
I found it a bit unclear in regards to "what does a script/plugin 
have to do, when?" - since I struggled with this, I now know :-)

Your patch has been applied to the master branch.

commit 71d56aea895cc13aad06048066251979162db3f3
Author: Arne Schwabe
Date:   Mon Jul 20 16:27:03 2020 +0200

     client-connect: Add documentation for the deferred client connect feature

     Signed-off-by: David Sommerseth <davids@...515...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200720142703.3324-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20511.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


