Date: Wed, 15 Nov 2023 15:31:04 +0100 (CET)
Message-Id: <202311151431.3AFEV47D098993@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231115103331.18050-1-gert@...1296...>
References: <20231115103331.18050-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not check key_state buffers
 that are in S_UNDEF state
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

I have tested the "lite" version of that patch (only the S_UNDEF patch)
for 30+ hours in a scenario that managed to crash after a few hours without
it, so am reasonably confident it fixes the 2.6.7 crashes observed - in
case there *are* other cases, we added a M_FATAL so we stop with a debug
note, and do not SIGSEGV.  This really is a "can't happen", but *if* it
does, we want to know.

Your patch has been applied to the master and release/2.6 branch.

commit a903ebe9361d451daee71c225e141f4e1b67107d (master)
commit b90ec6dabfb151dd93ef00081bbc3f55e7d3450f (release/2.6)
Author: Arne Schwabe
Date:   Wed Nov 15 11:33:31 2023 +0100

     Do not check key_state buffers that are in S_UNDEF state

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231115103331.18050-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27401.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


