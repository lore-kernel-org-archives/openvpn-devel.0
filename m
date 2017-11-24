Date: Fri, 24 Nov 2017 13:42:30 +0100 (CET)
Message-Id: <201711241242.vAOCgUcB037299@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171101220342.14648-2-steffan@...1856...>
References: <20171101220342.14648-2-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: pf: clean up temporary files if
 plugin init fails
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

I like that :-) - less code, less malloc()ing, less gcs around and 
more correct at that.  

I have also briefly reviewed the rest of the series, and everything looks 
good - but since Antonio has already ACKed everything, I leave that honour
to him.

Your patch has been applied to the master branch.

(This is refactoring, according to branch rules it only goes to 2.4 in
exceptionary circumstances, like "another patch depending on it" - but since
tls-crypt-v2 is also intended for master only, this is good enough for now)

commit d2342067d95621b130dd3985a077872b032d53d2
Author: Steffan Karger
Date:   Wed Nov 1 23:03:39 2017 +0100

     pf: clean up temporary files if plugin init fails

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20171101220342.14648-2-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15705.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


