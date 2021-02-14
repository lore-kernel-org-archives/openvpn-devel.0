Date: Sun, 14 Feb 2021 17:05:32 +0100 (CET)
Message-Id: <202102141605.11EG5WAE023836@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210125125628.30364-5-arne@...1227...>
References: <20210125125628.30364-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce management client
 state for AUTH_PENDING notifications
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

As this is not depending on 03/11, I've applied it out of sequence.

One typo fixed ("techhnically").  Test run on the client, unsurprisingly
no breakage - I have nothing that excercises the new code yet, but 
it still looks very reasonable :-)

commit b29f7dffc073ebd2a3b04eac5f7aee2edcf5da49
Author: Arne Schwabe
Date:   Mon Jan 25 13:56:21 2021 +0100

     Introduce management client state for AUTH_PENDING notifications

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210125125628.30364-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21498.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


