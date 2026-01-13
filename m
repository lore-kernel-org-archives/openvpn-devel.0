Date: Tue, 13 Jan 2026 09:46:35 +0100 (CET)
Message-Id: <202601130846.60D8kZ7m006347@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260113072750.16015-1-gert@...1296...>
References: <20260113072750.16015-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require script-security 2 when
 using unix: tun
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

Change makes sense ("all external program invocations guarded by 
--script-security") though that's more for consistency than for actual
security against "someone nasty hands you an openvpn config file and
asks you to run it, unchecked, on a linux system, as root".

Tested on a t_client test set that uses --dev unix: for "ping around"
tests - testing "as is" now yields:

   2026-01-13 09:34:40 WARNING: External program may not be called unless '--script-security 2' or higher is enabled. See --help text or man page for detailed info.

.. which is what we want to see.  Adding that makes it work.

(I have seen the remark from Frank about the message, but that's existing
code and not part of this patch - for the sake of saving time I decided to
merge this "as is", we can always improve the message in a separate patch)

Your patch has been applied to the master branch.

commit 4a15d4e51ddb58fbc7a2b2369f30e51616a2a591
Author: Arne Schwabe
Date:   Tue Jan 13 08:27:45 2026 +0100

     Require script-security 2 when using unix: tun

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1465
     Message-Id: <20260113072750.16015-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35223.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


