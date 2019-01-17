Date: Thu, 17 Jan 2019 17:29:48 +0100 (CET)
Message-Id: <201901171629.x0HGTmVU092731@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181016102627.18676-5-simon@...2293...>
References: <20181016102627.18676-5-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Detect TAP interfaces with
 root-enumerated hardware ID
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

We have a LGTM from Jon as well, but I'm taking this on me - because I
decided I want this in 2.4 as well.  Unlikely as it may be, we *will*
have people that happen to have a tap adapter on their system and try
to run 2.4.x binaries on it...  so this is long-term compatibility.

Your patch has been applied to the master and release/2.4 branch.

commit 6e03336d8a4aada12c4950a9683a483470fe4f15 (master)
commit eef040cc909bb0e9bae793b61c2f4f0da7e109d5 (release/2.4)
Author: Simon Rozman
Date:   Tue Oct 16 12:26:27 2018 +0200

     Detect TAP interfaces with root-enumerated hardware ID

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181016102627.18676-5-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17762.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


